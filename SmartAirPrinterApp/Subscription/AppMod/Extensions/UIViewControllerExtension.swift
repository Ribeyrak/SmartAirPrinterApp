//
//  UIViewControllerExtension.swift
//  ModsApp
//
//  Created by David on 25.04.2023.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAroundssss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardddddd))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardddddd() {
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
        view.endEditing(true)
    }
}
