//
//  NextScreenButton.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit

final class NextScreenButton: UIButton {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleAndColor(_ title: String, _ color: UIColor) {
        label.text = title
        backgroundColor = color
    }
}

private extension NextScreenButton {
    
    func addViews() {
        addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func configure() {
        //label.font = Resouces.Fonts.helvelticaRegular(with: 20)
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white
        titleLabel?.font = .systemFont(ofSize: 36)
        layer.cornerRadius = 16
        makeSystem(self)
    }
}
