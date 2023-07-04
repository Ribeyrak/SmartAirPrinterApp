//
//  FirstGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 20.06.2023.
//

import UIKit

class FirstGuideVC: UIViewController {

    // MARK: - Constants
    private enum Constants {
        static let labelText = "Print from 18,000+ \n printers with just one \n app"
        static let logoImage = "imageGuide"
        static let buttonText = "Get started"
        static let closeButton = "Close"
    }
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.3, animated: false)
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
        //v.layer.masksToBounds = true
        v.layer.cornerRadius = 10
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.5
        v.layer.shadowOffset = CGSize(width: 4, height: 4)
        v.layer.shadowRadius = 4
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
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor(Constants.buttonText, .black)
        return v
    }()
    
    // MARK: - Lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.height.equalTo(50)
            //$0.width.equalTo(350)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextScreenButton.snp.top).offset(-16)
        }
                
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
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalTo(closeButton.snp.bottom).offset(20)
            $0.bottom.equalTo(label.snp.top).offset(-35)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        nextScreenButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func nextVC() {
        let nextVC = SecondGuideVC()
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
}
