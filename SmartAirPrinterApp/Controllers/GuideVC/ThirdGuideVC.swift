//
//  ThirdGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 21.06.2023.
//

import UIKit

class ThirdGuideVC: UIViewController {
    
    weak var previousViewController: TestPrintGuideVC?

    // MARK: - Constants
    private enum Constants {
        static let labelText = "Check first"
        static let logoImage = "imageLogoGuide"
        static let bluetoothIcon = "bluetoothIcon"
        static let wifiIcon = "wifiBluetoothOn"
        static let globalSettingsLabel = "GLOBAL SETTINGS"
        static let buttonText = "Continue"
        static let closeButton = "Close"
    }
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.5, animated: false)
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
    
    private let wifiImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.wifiIcon)
        return v
    }()
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor(Constants.buttonText, .black)
        return v
    }()
    
    private let separatorView: UILabel = {
        let v = UILabel()
        v.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return v
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureAppearance()
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
        
        view.addSubview(wifiImageView)
        wifiImageView.snp.makeConstraints {
            //$0.leading.trailing.equalToSuperview()
//            $0.width.equalTo(350)
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalTo(nextScreenButton.snp.top).offset(-90)
            
            $0.center.equalToSuperview()
        }
        
        wifiImageView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(1)
        }
        
        view.addSubview(globalSettingsLabel)
        globalSettingsLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.bottom.equalTo(wifiImageView.snp.top).offset(-10)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        nextScreenButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func nextVC() {
        let nextVC = TestPrintGuideVC()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func mainVC() {
        let nextVC = TabBarController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}
