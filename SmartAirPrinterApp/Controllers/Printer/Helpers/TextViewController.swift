//
//  TextViewController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 03.07.2023.
//

import UIKit

protocol TextViewControllerDelegate: AnyObject {
    func didFinishEnteringText(_ text: String)
}

class TextViewController: UIViewController {
    weak var delegate: TextViewControllerDelegate?
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .yes
        textView.spellCheckingType = .yes
        textView.backgroundColor = .white
        textView.textColor = .black
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews() {
        title = "Введите текст"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .done, target: self, action: #selector(saveButtonTapped))
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func saveButtonTapped() {
        guard let text = textView.text else { return }
        delegate?.didFinishEnteringText(text)
        navigationController?.popViewController(animated: true)
    }
}
