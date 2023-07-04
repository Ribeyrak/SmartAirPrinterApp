//
//  NavBarController.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearence()
    }
    
    private func configureAppearence() {
        view.backgroundColor = R.Colors.tabBarBackgroundColor
        navigationBar.isTranslucent = false
        navigationBar.tintColor = R.Colors.active
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: R.Colors.titleBlack,
            .font: R.Fonts.helvelticaRegular(with: 20)
        ]
        navigationBar.addBottomBorder(with: R.Colors.separator, height: 1)
    }
}
