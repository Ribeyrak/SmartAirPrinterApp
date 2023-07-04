//
//  CustomCellectionViewCell.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 16.06.2023.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private let image = UIImageView()
    private let directionImage = UIImageView().then {
        $0.image = UIImage(named: "dist")
    }
    let title = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 15)
    }
    let descript = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 15)
    }
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [image, directionImage, title, descript])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.distribution = .equalSpacing
        v.spacing = 20
        return v
    }()
    
    let containerView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // selected cell
    override var isSelected: Bool {
        didSet {
            if isSelected {
                //selected()
            } else {
                //notSelected()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(image)
        image.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(20)
        }

        containerView.addSubview(directionImage)
        directionImage.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(12)
            $0.height.width.equalTo(5)
        }

        containerView.addSubview(title)
        title.snp.makeConstraints {
            $0.top.equalTo(image.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(20)
        }

        containerView.addSubview(descript)
        descript.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    func setup(with products: Products) {
        image.image = UIImage(named: products.image)
        title.text = products.title
        descript.text = products.descript
        
        layer.cornerRadius = 14
        layer.masksToBounds = true
        layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
    }
}

// MARK: - extensions
extension CustomCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
