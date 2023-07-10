//
//  UILabelExtension.swift
//  ModsApp
//
//  Created by David on 17.04.2023.
//

import Foundation
import UIKit

extension UILabel {
    func addShadowddcdc() {
        layer.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .zero
        layer.masksToBounds = false
        layer.shouldRasterize = true
    }
}
