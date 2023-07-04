//
//  TranslatorVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 16.06.2023.
//

import UIKit

class TranslatorVC: UIViewController {
    //MARK: - Constants
    private enum Constants {
        static let labelText = "Unlimited Access \n To All Features"
        static let logoImage = "translaterImage"
        static let discriptLabelText = "Translator helps you easily translate photo or \n scanned text in 100 languages."
        static let nextScreenButton = "Download"
        static let restoreButton = "Close"
    }
    
    //MARK: - UI
    let closeButton: UIButton = {
        let v = UIButton(type: .system)
        v.setTitle(Constants.restoreButton, for: .normal)
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
        v.numberOfLines = 2
        v.textAlignment = .center
        v.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        v.font = .systemFont(ofSize: 24, weight: .black)
        return v
    }()
    
    private let discriptLabel: UILabel = {
        let v = UILabel()
        v.text = Constants.discriptLabelText
        v.textAlignment = .center
        v.numberOfLines = 2
        v.textColor = #colorLiteral(red: 0.3764705658, green: 0.3764705658, blue: 0.3764705658, alpha: 1)
        return v
    }()
    
    private let nextScreenButton: NextScreenButton = {
        let v = NextScreenButton()
        v.setTitleAndColor(Constants.nextScreenButton, R.Colors.active)
        return v
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
        setupUI()
    }

    //MARK: - Private functions
    private func setupUI() {
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
        }
        
        view.addSubview(discriptLabel)
        discriptLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(nextScreenButton.snp.top).offset(-16)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(discriptLabel.snp.top).offset(-18)
        }
        
        view.addSubview(logo)
        logo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(label.snp.top).offset(-35)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        closeButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func nextVC() {
        let nextVC = PrinterController()
        navigationController?.pushViewController(nextVC, animated: false)
    }
}
