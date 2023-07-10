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
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите текст"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        textView.delegate = self
    }
    
    private func configureViews() {
        title = "Введите текст"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .done, target: self, action: #selector(saveButtonTapped))
        
        view.addSubview(textView)
        textView.addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            placeholderLabel.bottomAnchor.constraint(lessThanOrEqualTo: textView.bottomAnchor, constant: -8)
        ])
    }
    
    @objc private func saveButtonTapped() {
        guard let text = textView.text else { return }
        delegate?.didFinishEnteringText(text)
        navigationController?.popViewController(animated: true)
    }
}

extension TextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
