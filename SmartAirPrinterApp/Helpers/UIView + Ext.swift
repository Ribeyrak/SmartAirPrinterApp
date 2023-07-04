//
//  UIView + Ext.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit

extension UIView {
    
    func addBottomBorder(with color: UIColor, height: CGFloat) {
        let separator = UIView()
        separator.backgroundColor = color
        separator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        separator.frame = CGRect(x: 0,
                                 y: frame.height -  height,
                                 width: frame.width,
                                 height: height)
        addSubview(separator)
    }
    // button change color when tapped
    func makeSystem(_ botton: UIButton) {
        botton.addTarget(self, action: #selector(hendleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        
        botton.addTarget(self, action: #selector(hendleOut), for: [
            .touchUpInside,
            .touchDragOutside,
            .touchUpOutside,
            .touchDragExit,
            .touchCancel
        ])
    }
    
    @objc func hendleIn() {
        UIView.animate(withDuration: 0.15) { self.alpha = 0.55 }
    }
    
    @objc func hendleOut() {
        UIView.animate(withDuration: 0.15) { self.alpha = 1 }
    }
}
