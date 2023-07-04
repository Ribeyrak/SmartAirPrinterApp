////
////  PrintOptionsVC.swift
////  SmartAirPrinterApp
////
////  Created by Evhen Lukhtan on 26.06.2023.
////
//
//import UIKit
//import CoreBluetooth
//import SystemConfiguration
//import SystemConfiguration.CaptiveNetwork
//import Reachability
//
//protocol FindingPrintersVCDelegate: AnyObject {
//    func didSelectPrinter(_ name: String)
//}
//
//class FindingPrintersVC: UIViewController {
//    
//    // Bluetooth properties
//    var centralManager: CBCentralManager?
//    var discoveredPrinters: [CBPeripheral] = []
//    let reachability = try! Reachability()
//    
//    weak var delegate: FindingPrintersVCDelegate?
//    
//    // MARK: - UI
//    let label: UILabel = {
//        let v = UILabel()
//        v.text = "Finding printers"
//        v.numberOfLines = 0
//        v.textAlignment = .center
//        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        v.font = .systemFont(ofSize: 20, weight: .black)
//        return v
//    }()
//    
//    private let separatorView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .gray
//        return v
//    }()
//    
//    let activityIndicator: UIActivityIndicatorView = {
//        let v = UIActivityIndicatorView()
//        v.color = .black
//        return v
//    }()
//    
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.tableFooterView = UIView() // Убираем разделители для пустых ячеек
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .red
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//        setupUI()
//        configureAppearance()
//        configureTableView()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//    
//    // MARK: - Private functions
//    private func setupUI() {
//        view.addSubview(separatorView)
//        separatorView.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//            $0.height.equalTo(1) // Задайте нужную высоту разделителю
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(2.0/3.0) // Размещаем на 2/3 экрана от верха
//        }
//        
//        view.addSubview(label)
//        label.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(1.0/3.0)
//            $0.centerX.equalToSuperview()
//        }
//        
//        view.addSubview(activityIndicator)
//        activityIndicator.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).multipliedBy(1.0/3.0)
//            $0.left.equalTo(label.snp.right).offset(15)
//        }
//        activityIndicator.startAnimating()
//        
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(label.snp.bottom).offset(10)
//            $0.bottom.equalTo(separatorView).offset(-10)
//            $0.left.right.equalToSuperview().inset(35)
//        }
//    }
//    private func configureAppearance() {
//        view.backgroundColor = R.Colors.background
//        
//        navigationController?.navigationBar.tintColor = R.Colors.active
//        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [
//            .foregroundColor: R.Colors.titleBlack,
//            .font: R.Fonts.helvelticaRegular(with: 20)
//        ]
//        navigationController?.navigationBar.addBottomBorder(with: R.Colors.separator, height: 1)
//        navigationItem.title = "Printer"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navBarCloseButton))
//        
//        // доступность к wifi
//        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
//        do {
//            try reachability.startNotifier()
//        } catch {
//            print("Unable to start reachability notifier.")
//        }
//    }
//    
//    private func configureTableView() {
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrinterCell")
//    }
//    
//    // MARK: - Bluetooth methods
//    @objc func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//            // Bluetooth is enabled and ready
//            // Start scanning for nearby peripherals
//            centralManager?.scanForPeripherals(withServices: nil, options: nil)
//        } else {
//            // Bluetooth is not available or powered off
//            // Handle the appropriate case
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        // A peripheral is discovered
//        // You can filter and handle the discovered printers here
//        if !discoveredPrinters.contains(peripheral) {
//            discoveredPrinters.append(peripheral)
//            
//            // Do something with the discovered printer, e.g., display it in a list
//            // Example: Print the peripheral's name
//            if let printerName = peripheral.name {
//                print("Discovered printer: \(printerName)")
//            }
//            tableView.reloadData()
//        }
//    }
//    
//    // MARK: - Wifi methods
//    private func getDevicesInWiFiNetwork() -> [CBPeripheral] {
//        var devices: [CBPeripheral] = []
//
//        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
//            return devices
//        }
//
//        for interface in interfaces {
//            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as NSDictionary? else {
//                continue
//            }
//
//            if let ssid = info[kCNNetworkInfoKeySSID as String] as? String,
//               let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String {
//                let filteredPeripherals = discoveredPrinters.filter { peripheral in
//                    peripheral.name == ssid
//                }
//                if let peripheral = filteredPeripherals.first {
//                    devices.append(peripheral)
//                }
//            } else {
//                // Failed to retrieve Wi-Fi information
//                print("Failed to retrieve Wi-Fi information.")
//            }
//        }
//
//        return devices
//    }
//    
//    @objc private func reachabilityChanged(_ notification: Notification) {
//        guard let reachability = notification.object as? Reachability else {
//            return
//        }
//        
//        if reachability.connection == .wifi {
//            // Получаем список устройств в сети Wi-Fi
//            let devices = getDevicesInWiFiNetwork()
//            // Обновляем таблицу с найденными принтерами
//            discoveredPrinters = devices
//            tableView.reloadData()
//        }
//    }
//    
//    // MARK: - Actions
//    @objc func navBarCloseButton() {
//        let nextVC = PrintOptionsVC()
//        navigationController?.pushViewController(nextVC, animated: false)
//    }
//}
//
//// MARK: - TableView DataSource
//extension FindingPrintersVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return discoveredPrinters.filter { printer in
//            if let printerName = printer.name, !printerName.isEmpty {
//                return true
//            } else {
//                return false
//            }
//        }.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PrinterCell", for: indexPath)
//        cell.backgroundColor = .white
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.font = .systemFont(ofSize: 15)
//        
//        let filteredPrinters = discoveredPrinters.filter { printer in
//            if let printerName = printer.name, !printerName.isEmpty {
//                return true
//            } else {
//                return false
//            }
//        }
//        
//        let printer = filteredPrinters[indexPath.row]
//        cell.textLabel?.text = printer.name
//        
//        return cell
//    }
//}
//
//// MARK: - TableView Delegate
//extension FindingPrintersVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let printer = discoveredPrinters[indexPath.row]
//        centralManager?.connect(printer, options: nil)
//        
//        if let printerName = printer.name {
//            delegate?.didSelectPrinter(printerName)
//            print(printerName)
//        }
//        tableView.reloadData()
//    }
//}
//
//// MARK: - CBCentralManagerDelegate
//extension FindingPrintersVC: CBCentralManagerDelegate {
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        print("Успешно подключились к принтеру")
//        // Вы можете выполнять необходимые действия после подключения здесь
//    }
//    
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        print("Ошибка при подключении к принтеру")
//        // Обработайте ошибку здесь
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        print("Принтер был отключен")
//        // Вы можете выполнить необходимые действия при отключении здесь
//    }
//}
//
//extension PrintOptionsVC: FindingPrintersVCDelegate {
//    func didSelectPrinter(_ name: String) {
//        printerName = name
//        tableView.reloadData()
//    }
//}
//
//
