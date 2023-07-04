//
//  SecondGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 20.06.2023.
//

import UIKit
import CoreBluetooth
import SystemConfiguration
import Reachability


class SecondGuideVC: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let labelText = "Check first"
        static let logoImage = "imageLogoGuide"
        static let bluetoothIcon = "bluetoothIcon"
        static let wifiIcon = "wifiIcon"
        static let globalSettingsLabel = "GLOBAL SETTINGS"
        static let buttonText = "Enable Wi-Fi and Bluetooth to Continue"
        static let closeButton = "Close"
        static let wifiLabelText = "You can print documents, photos, files with any AirPrint supporting printer. You can print documents, photos, files with any AirPrint supporting printer.."
        static let switcherIcon = "switcherIcon"
    }
    
    var centralManager: CBCentralManager!
    let reachability = try! Reachability()
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.4, animated: false)
        v.trackTintColor = .gray
        v.layer.cornerRadius = 6
        v.progressTintColor = .black
        return v
    }()
    
    let closeButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.closeButton, for: .normal)
        v.tintColor = R.Colors.active
        return v
    }()
    
    let logo: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.logoImage)
        return v
    }()
    
    let label: UILabel = {
        let v = UILabel()
        v.text = Constants.labelText
        v.numberOfLines = 3
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.font = .systemFont(ofSize: 24, weight: .black)
        return v
    }()
    
    private let globalSettingsLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.globalSettingsLabel
        v.numberOfLines = 2
        v.textColor = #colorLiteral(red: 0.3764705658, green: 0.3764705658, blue: 0.3764705658, alpha: 1)
        v.font = .systemFont(ofSize: 11)
        return v
    }()
    
    private let wifiView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let wifiImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.wifiIcon)
        return v
    }()
    
    private let wifiImageLabel: UILabel = {
        let v = UILabel()
        v.text = "Wi-Fi"
        v.textColor = .black
        v.font = .systemFont(ofSize: 15)
        return v
    }()
    
    private let wifiUnderLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.wifiLabelText
        v.textColor = #colorLiteral(red: 0.3764705658, green: 0.3764705658, blue: 0.3764705658, alpha: 1)
        v.numberOfLines = 0
        v.font = .systemFont(ofSize: 13)
        return v
    }()
    
    private let bluetoothView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let bluetoochImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.bluetoothIcon)
        return v
    }()
    
    private let bluetoothImageLabel: UILabel = {
        let v = UILabel()
        v.text = "Bluetooth"
        v.textColor = .black
        v.font = .systemFont(ofSize: 15)
        return v
    }()
    
    private let bluetoothUnderLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.wifiLabelText
        v.textColor = #colorLiteral(red: 0.3764705658, green: 0.3764705658, blue: 0.3764705658, alpha: 1)
        v.numberOfLines = 0
        v.font = .systemFont(ofSize: 13)
        return v
    }()
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        //v.setTitleAndColor(Constants.buttonText, .black)
        v.titleLabel?.font = .systemFont(ofSize: 16)
        v.setTitle(Constants.buttonText, for: .normal)
        v.backgroundColor = .gray
        v.isEnabled = false
        return v
    }()
    
    let wifiActivityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.color = .black
        return v
    }()
    
    let bluetoothActivityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.color = .black
        return v
    }()
    
    let wifiImageOn = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.switcherIcon)
        return v
    }()
    let bluetoothImageOn: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.switcherIcon)
        return v
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        setupUI()
        configureAppearance()
        checkConnection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Private functions
    private func setupUI() {
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(view.safeAreaLayoutGuide)
            //$0.width.equalTo(317)
            $0.height.equalTo(5)
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(79)
            $0.height.width.equalTo(60)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logo.snp.bottom).offset(16)
        }
        
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.height.equalTo(50)
            //$0.width.equalTo(350)
        }
        
        view.addSubview(bluetoothUnderLabel)
        bluetoothUnderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(nextScreenButton.snp.top).offset(-60)
        }
        
        view.addSubview(bluetoothView)
        bluetoothView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(bluetoothUnderLabel.snp.top).offset(-10)
            $0.height.equalTo(50)
        }
        
        view.addSubview(wifiUnderLabel)
        wifiUnderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(bluetoothView.snp.top).offset(-48)
        }
        
        view.addSubview(wifiView)
        wifiView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(wifiUnderLabel.snp.top).offset(-10)
            $0.height.equalTo(50)
        }
        
        view.addSubview(globalSettingsLabel)
        globalSettingsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalTo(wifiView.snp.top).offset(-10)
        }
        
        wifiView.addSubview(wifiImageView)
        wifiImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.height.width.equalTo(25)
        }
        wifiView.addSubview(wifiImageLabel)
        wifiImageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(wifiImageView.snp.trailing).offset(7)
        }
        
        bluetoothView.addSubview(bluetoochImageView)
        bluetoochImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.height.width.equalTo(25)
        }
            
        bluetoothView.addSubview(bluetoothImageLabel)
        bluetoothImageLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(bluetoochImageView.snp.trailing).offset(7)
        }
        
        wifiView.addSubview(wifiActivityIndicator)
        wifiActivityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
        wifiActivityIndicator.startAnimating()
        
        bluetoothView.addSubview(bluetoothActivityIndicator)
        bluetoothActivityIndicator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
        bluetoothActivityIndicator.startAnimating()
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        
        // Wifi settings
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
       do{
         try reachability.startNotifier()
       }catch{
         print("could not start reachability notifier")
       }
    }
    
    private func checkConnection() {
        if reachability.connection == .wifi && centralManager.state == .poweredOn {
            nextScreenButton.titleLabel?.font = .systemFont(ofSize: 24)
            nextScreenButton.setTitle("Continue", for: .normal)
            nextScreenButton.backgroundColor = .black
            nextScreenButton.isEnabled = true
            
            navigationController?.pushViewController(ThirdGuideVC(), animated: false)
        }
    }

    // MARK: - Actions
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
          wifiActivityIndicator.stopAnimating()
          wifiView.addSubview(wifiImageOn)
          wifiImageOn.snp.makeConstraints {
              $0.centerY.equalToSuperview()
              $0.trailing.equalToSuperview().inset(30)
          }
          checkConnection()
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
      }
    }
}

extension SecondGuideVC: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
            bluetoothActivityIndicator.stopAnimating()
            bluetoothView.addSubview(bluetoothImageOn)
            bluetoothImageOn.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(30)
            }
            checkConnection()
        @unknown default:
            fatalError()
        }
    }
}
