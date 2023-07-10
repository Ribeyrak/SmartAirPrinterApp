//
//  UISearchBarExtension.swift
//  ModsApp
//
//  Created by David on 27.04.2023.
//

import UIKit

extension UISearchBar {
    
    func setPlaceholderTextColorTo_Appdddd(color: UIColor) {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = color
    }
    
    func setupSearchBardddd() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        searchTextField.clearButtonMode = .never
        self.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
//        self.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        self.tintColor = .black
        
        self.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        self.setPlaceholderTextColorTo_Appdddd(color: UIColor.black)
        
//        if let textField = self.value(forKey: "searchField") as? UITextField,
//           let iconView = textField.leftView as? UIImageView,
//           let clearButton = textField.value(forKey: "_clearButton") as? UIButton {
//            clearButton.addTarget(self, action: #selector(self.clearButtonActionApp), for: .touchUpInside)
//            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//            iconView.tintColor = UIColor.black
//        }
        
        if let searchTextfield = self.value(forKey: "searchField") as? UITextField  {
            searchTextfield.backgroundColor = .clear
        }
        
        if #available(iOS 13.0, *) {
            let placeholder = NSAttributedString(string: NSLocalizedString("search", comment: ""), attributes: [ .foregroundColor: UIColor.black.withAlphaComponent(1) ])
            let searchTextField = self.searchTextField
            
            // Key workaround to be able to set attributedPlaceholder
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    searchTextField.attributedPlaceholder = placeholder
                }
            }
        }
    }
    
    @objc private func clearButtonActionApp() {
        func updateUnique1() {
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        func updateUnique2() {
            print("")
            print("")
            if true {} else {}
            if false {}
            switch true {
            default: print("")
            }
        }
        self.resignFirstResponder()
        NotificationCenter.default.post(name: Notification.Name("clearButtonActionApp"), object: nil)
    }
}
