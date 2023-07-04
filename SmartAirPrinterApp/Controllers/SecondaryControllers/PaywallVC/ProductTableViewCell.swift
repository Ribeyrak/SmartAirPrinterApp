//
//  ProductTableViewCell.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 16.06.2023.
//

import UIKit
import Then

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class ProductTableViewCell: UITableViewCell {
    //MARK: - UI
    
    let trialLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    let perPeriodLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    let separator = UILabel().then {
        $0.textColor = .systemGray
        $0.text = "|"
    }
    
    let priceLabel = UILabel().then {
        $0.textColor = .black 
        $0.font = .systemFont(ofSize: 15)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.selected()
        } else {
            self.notSelected()
        }
        
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        confige()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // selected cell
    override var isSelected: Bool {
        didSet {
            if isSelected {
                selected()
            } else {
                notSelected()
            }
        }
    }
    
    // MARK: - Private Function
    private func setupUI() {
        contentView.addSubview(trialLabel)
        trialLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(29)
            $0.top.equalToSuperview().inset(9)
        }
        
        contentView.addSubview(perPeriodLabel)
        perPeriodLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(9)
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
        }
        
        contentView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(priceLabel.snp.leading).offset(-10)
        }
    }
    
    func confige() {
        textLabel?.textColor = .white
        textLabel?.highlightedTextColor = .black
        
        
        layer.cornerRadius = 16
        backgroundColor = .clear

        let selected = UIView()
        selected.backgroundColor = UIColor.white
        selected.layer.cornerRadius = 16
        selected.layer.borderColor = R.Colors.active.cgColor
        selectedBackgroundView = selected

        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 2
        layer.masksToBounds = true
        
    }
    
    func setupCell(with subs: Subscriptions) {
        trialLabel.text = subs.trialLabel
        perPeriodLabel.text = subs.totalPrice
        priceLabel.text = subs.pricePerMonth
    }

    private func selected() {
        layer.borderColor = R.Colors.active.cgColor
    }
    
    private func notSelected() {
        layer.borderColor = UIColor.gray.cgColor
    }
}

//MARK: - extensions
extension ProductTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
