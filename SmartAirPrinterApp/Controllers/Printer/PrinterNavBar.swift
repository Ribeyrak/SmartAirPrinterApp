//
//  PrinterNavBar.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 15.06.2023.
//

import UIKit

final class PrintNavBar: BaseView {
    
    private let dollarButton: UIButton = {
        let button = UIButton()
        button.setImage(R.Images.Common.dollarButton, for: .normal)
        return button
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(R.Images.Common.infoButton, for: .normal)
        return button
    }()

}

extension PrintNavBar {
    override func setupViews() {
        super.setupViews()
        addSubview(dollarButton)
        addSubview(infoButton)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
