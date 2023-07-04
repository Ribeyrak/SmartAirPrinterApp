//
//  EmailPrintVC.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 04.07.2023.
//

import UIKit

class EmailPrintVC: UIViewController {
    
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainLabel, discriptionLabel, oneLabel, twoLabel, threeLabel, fourLabel, fiveLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
//        stackView.alignment = .center
        return stackView
    }()
    
    let mainLabel: UILabel = {
       let v = UILabel()
        v.text = "How to print email \n attachments?"
        v.textColor = .black
        v.font = .systemFont(ofSize: 24)
        return v
    }()
    
    let discriptionLabel: UILabel = {
       let v = UILabel()
        v.text = "You can print documents, photos, files with any AirPrint supporting printer."
        v.textColor = .black
        v.numberOfLines = 0
        v.textColor = UIColor(hexString: "#606060")
        v.font = .systemFont(ofSize: 14)
        return v
    }()

    let oneLabel: UILabel = {
       let v = UILabel()
        v.text = "1️⃣ Find Email"
        v.textColor = .black
        v.font = .systemFont(ofSize: 24)
        return v
    }()
    let twoLabel: UILabel = {
       let v = UILabel()
        v.text = "2️⃣ Open attachment"
        v.font = .systemFont(ofSize: 24)
        v.textColor = .black
        return v
    }()
    let threeLabel: UILabel = {
       let v = UILabel()
        v.text = "3️⃣ Share attachment"
        v.font = .systemFont(ofSize: 24)
        v.textColor = .black
        return v
    }()
    let fourLabel: UILabel = {
       let v = UILabel()
        v.text = "4️⃣ Open in “Printer”"
        v.font = .systemFont(ofSize: 24)
        v.textColor = .black
        return v
    }()
    let fiveLabel: UILabel = {
       let v = UILabel()
        v.text = "5️⃣ Print attachment"
        v.font = .systemFont(ofSize: 24)
        v.textColor = .black
        return v
    }()
    
    // MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        title = "Email Print"
    }
    
    private func setupUI() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
