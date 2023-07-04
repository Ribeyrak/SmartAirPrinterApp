////
////  FindingPrinterVC.swift
////  SmartAirPrinterApp
////
////  Created by Evhen Lukhtan on 26.06.2023.
////
//
//import UIKit
//
//class PrintOptionsVC: UIViewController {
//    
//    var titleCell = ["Copies", "Paper Size"]
//    var printerName: String?
//    
//    // MARK: - UI
//    let tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .insetGrouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//    
//    private let separatorView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .gray
//        return v
//    }()
//    
//    let printButton: UIButton = {
//        let v = UIButton(type: .system)
//        v.setTitle("Print", for: .normal)
//        v.titleLabel?.font = .boldSystemFont(ofSize: 16)
//        v.tintColor = .black
//        return v
//    }()
//    
//    let printView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .white
//        return v
//    }()
//    
//    // MARK: - Lifecycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        configureAppearance()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
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
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().inset(13)
//            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
//            $0.bottom.equalTo(separatorView.snp.top)
//        }
//        
//        view.addSubview(printView)
//        printView.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(separatorView.snp.bottom).offset(7)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(7)
//            $0.width.equalToSuperview().multipliedBy(0.5)
//        }
//    }
//    
//    private func configureAppearance() {
//        view.backgroundColor = R.Colors.background
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        tableView.rowHeight = 44
//        
//        navigationController?.navigationBar.tintColor = R.Colors.active
//        navigationController?.navigationBar.standardAppearance.titleTextAttributes = [
//            .foregroundColor: R.Colors.titleBlack,
//            .font: R.Fonts.helvelticaRegular(with: 20)
//        ]
//        navigationController?.navigationBar.addBottomBorder(with: R.Colors.separator, height: 1)
//        navigationItem.title = "Print Options"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(navBarCloseButton))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: printButton)
//        printButton.addTarget(self, action: #selector(findingPrinter), for: .touchUpInside)
//    }
//    
//    // MARK: - Actions
//    @objc func navBarCloseButton() {
//        let nextVC = TabBarController()
//        navigationController?.pushViewController(nextVC, animated: false)
//    }
//    
//    @objc func findingPrinter() {
//        print("pupsik")
//    }
//    
//}
//// MARK: - TableView DataSource
//extension PrintOptionsVC: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0, 2:
//            return 1
//        case 1:
//            return 2
//        default:
//            break
//        }
//        return section
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
//        cell.backgroundColor = .white
//        cell.textLabel?.textColor = .black
//        cell.textLabel?.font = .systemFont(ofSize: 15)
//        cell.detailTextLabel?.textColor = UIColor(hexString: "#606060")
//        cell.detailTextLabel?.textColor = UIColor(hexString: "#606060")
//        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
//        
//        let accessoryImage = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
//        let accessoryImageView = UIImageView(image: accessoryImage)
//        cell.accessoryView = accessoryImageView
//        
//        let selected = UIView()
//        selected.backgroundColor = .gray
//        cell.selectedBackgroundView = selected
//        
//        if indexPath.section == 0 {
//            if let name = printerName {
//                cell.textLabel?.text = name
//            } else {
//                cell.textLabel?.text = "Printer"
//            }
//        } else if indexPath.section == 1 {
//            cell.textLabel?.text = titleCell[indexPath.row]
//            
//            if indexPath.row != tableView.numberOfRows(inSection: indexPath.section) - 1 {
//                let separatorView = UIView()
//                separatorView.backgroundColor = tableView.separatorColor
//                cell.contentView.addSubview(separatorView)
//                separatorView.snp.makeConstraints {
//                    $0.leading.trailing.equalToSuperview().inset(10)
//                    $0.bottom.equalToSuperview()
//                    $0.height.equalTo(1)
//                }
//            }
//        } else {
//            cell.textLabel?.text = "Layout"
//            cell.detailTextLabel?.text = "1 page per shit"
//        }
//        return cell
//    }
//}
//
//// MARK: - TableView Delegate
//extension PrintOptionsVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            let findingPrintersVC = FindingPrintersVC()
//            findingPrintersVC.delegate = self
//            navigationController?.pushViewController(findingPrintersVC, animated: true)
//        }
//    }
//}
//
//
