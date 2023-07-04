//
//  TestPrintGuideVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 22.06.2023.
//

import UIKit

class TestPrintGuideVC: UIViewController {
    
    weak var previousViewController: FifthGuideVC?
    
    // MARK: - Constants
    private enum Constants {
        static let labelText = "Test print"
        static let logoImage = "printLogoImage"
        static let documentImage = "documentImage"
        static let buttonText = "Print"
        static let closeButton = "Close"
        static let backButton = "Back"
    }
    
    // MARK: - UI
    let progressBar: UIProgressView = {
        let v = UIProgressView()
        v.layer.masksToBounds = true
        v.progressViewStyle = .default
        v.setProgress(0.6, animated: false)
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
    
    private let documentView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 10
        return v
    }()
    
    private let imageDocument: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: Constants.documentImage)
        return v
    }()
    
    private let documentNameLabel: UILabel = {
        let v = UILabel()
        v.text = "Sample document"
        v.textColor = .black
        v.font = .systemFont(ofSize: 15)
        return v
    }()
    
    private let documentTypeLabel: UILabel = {
        let v = UILabel()
        v.text = "PDF Document  22 KB"
        v.textColor = UIColor(hexString: "#606060")
        v.font = .systemFont(ofSize: 11)
        return v
    }()
    
    private let numberOfPagesInDoc: UILabel = {
        let v = UILabel()
        v.text = "1 Page"
        v.textColor = UIColor(hexString: "#606060")
        v.font = .systemFont(ofSize: 11)
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
        
        view.addSubview(nextScreenButton)
        nextScreenButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(54)
            $0.height.equalTo(50)
        }
        
        view.addSubview(documentView)
        documentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
        }
        
        documentView.addSubview(imageDocument)
        imageDocument.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(36)
        }
        documentView.addSubview(documentNameLabel)
        documentNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
            $0.leading.equalTo(imageDocument.snp.trailing).offset(11)
        }
        documentView.addSubview(documentTypeLabel)
        documentTypeLabel.snp.makeConstraints {
            $0.top.equalTo(documentNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(imageDocument.snp.trailing).offset(11)
        }
        
        documentView.addSubview(numberOfPagesInDoc)
        numberOfPagesInDoc.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(17)
        }
    }
    
    private func configureAppearance() {
        view.backgroundColor = R.Colors.background
        
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(mainVC), for: .touchUpInside)
        nextScreenButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func previousVC() {
        let nextVC = ThirdGuideVC()
        nextVC.previousViewController = self
        navigationController?.pushViewController(nextVC, animated: false)
    }
    
    @objc func nextVC(_ sender: UIButton) {
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo.printInfo()
        printInfo.outputType = .general
        printController.printInfo = printInfo
        
        // Добавьте ваш код для настройки контента печати, если необходимо
        let formatter = UIMarkupTextPrintFormatter(markupText: "<h1>Hello, world!</h1>")
        printController.printFormatter = formatter
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Для iPad
            printController.present(from: sender.frame, in: view, animated: true) { (printController, completed, error) in
                // Обработка завершения печати
                if completed {
                    // Печать завершена успешно
                    let alert = UIAlertController(title: "Print", message: "Document printed successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else if let error = error {
                    // Возникла ошибка при печати
                    let alert = UIAlertController(title: "Print", message: "Printing error: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Печать была отменена
                    let alert = UIAlertController(title: "Print", message: "Printing has been cancelled. Were you able to print the document?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                        // Пользователь выбрал "Нет", выполняем переход на FifthGuideVC
                        self.navigationController?.popToRootViewController(animated: false)
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                        // Пользователь выбрал "Нет", выполняем переход на FifthGuideVC
                        let nextVC = FifthGuideVC()
                        self.navigationController?.pushViewController(nextVC, animated: false)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Для iPhone
            printController.present(animated: true) { (printController, completed, error) in
                // Обработка завершения печати
                if completed {
                    // Печать завершена успешно
                    let alert = UIAlertController(title: "Print", message: "Document printed successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.navigationController?.popToRootViewController(animated: false)
                    }))
                    self.present(alert, animated: true, completion: nil)
                } else if let error = error {
                    // Возникла ошибка при печати
                    let alert = UIAlertController(title: "Print", message: "Printing error: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Печать была отменена
                    let alert = UIAlertController(title: "Print", message: "Printing has been cancelled. Were you able to print the document?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                        // Пользователь выбрал "Нет", выполняем переход на FifthGuideVC
                        let nextVC = FifthGuideVC()
                        self.navigationController?.pushViewController(nextVC, animated: false)
                    }))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                        // Пользователь выбрал "Нет", выполняем переход на FifthGuideVC
                        self.navigationController?.popToRootViewController(animated: false)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func mainVC() {
        navigationController?.popToRootViewController(animated: false)
    }
}


