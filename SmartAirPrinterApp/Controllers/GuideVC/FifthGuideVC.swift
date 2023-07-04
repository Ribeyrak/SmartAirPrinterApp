//
//  FifthGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 22.06.2023.
//

import UIKit

class FifthGuideVC: UIViewController {

    weak var previousViewController: SixthGuideVC?
    
    // MARK: - Constants
    private enum Constants {
        static let labelText = "Check your \n Printer Wi-Fi Settings"
        static let logoImage = "printLogoImage"
        static let documentImage = "documentImage"
        static let buttonText = "Print"
        static let closeButton = "Close"
        static let backButton = "Back"
        static let infoLabelText = "Is your Printer device connected to the same Wi-Fi as your iPhone or iPad?"
    }
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.7, animated: false)
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
    
    let backButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.backButton, for: .normal)
        v.tintColor = R.Colors.active
        v.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
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
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.font = .systemFont(ofSize: 24, weight: .black)
        return v
    }()
    
    private let connectView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let connetPrinterImage: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.logoImage)
        return v
    }()
    
    private let connectPlusLabel: UILabel = {
        let v = UILabel()
        v.text = "+"
        v.textColor = UIColor(hexString: "#C2C2C2")
        return v
    }()
    
    private let connetPhoneImage: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "phoneImage")
        return v
    }()
    
    private let infoLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.infoLabelText
        v.textColor = .black
        v.numberOfLines = 0
        v.textAlignment = .center
        v.font = .systemFont(ofSize: 15)
        return v
    }()
    
    private let noButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor("No", UIColor(hexString: "#C2C2C2"))
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let yesButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor("Yes", UIColor(hexString: "##3447F6"))
        v.layer.cornerRadius = 10
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
            $0.height.equalTo(5)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(29)
            $0.top.equalTo(progressBar.snp.bottom).offset(20)
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
        
        view.addSubview(connectView)
        connectView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(label.snp.bottom).offset(30)
            $0.height.equalTo(200)
        }
        
        connectView.addSubview(connectPlusLabel)
        connectPlusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(28)
            $0.width.height.equalTo(15)
        }
        
        connectView.addSubview(connetPrinterImage)
        connetPrinterImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalTo(connectPlusLabel.snp.leading).offset(-7)
        }
        
        connectView.addSubview(connetPhoneImage)
        connetPhoneImage.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(30)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(connectPlusLabel.snp.trailing).offset(7)
        }
        
        connectView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(connetPhoneImage.snp.bottom).offset(20)
        }
        
        connectView.addSubview(noButton)
        noButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
            $0.width.equalTo(106)
        }
        
        connectView.addSubview(yesButton)
        yesButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(106)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        
        yesButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noConnectionButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func previousVC() {
        let nextVC = TestPrintGuideVC()
        nextVC.previousViewController = self
        navigationController?.pushViewController(nextVC, animated: false)
    }
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
    @objc func nextVC() {
        let nextVC = SixthGuideVC()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    @objc func noConnectionButton() {
        let nextVC = SeventhGuideVC()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}
