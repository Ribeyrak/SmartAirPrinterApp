//
//  SubscriptionView.swift
//  ModsApp
//
//  Created by David on 15.04.2023.
//

import UIKit
import Gifu

class SubscriptionView: UIView {
    
    @IBOutlet weak var gif: GIFImageView!
    @IBOutlet var pay_view: UIView!
    @IBOutlet weak var promoSlider: AnimationSlider!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var purchaseButtonView: UIView!
    @IBOutlet weak var privacyB: UIButton!
    @IBOutlet weak var termsB: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var continueLabel: UILabel!
    
    private let iapManager = IAPManagerClass.shared
    private let price_text = NSLocalizedString("price_label", comment: "")
    private let price = NSLocalizedString("price_label_bold", comment: "")
    private let descriptionText = NSLocalizedString("agreement_full_text", comment: "")
    private var countProgress = 0.0
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nib_setupka_()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nib_setupka_()
    }
    
    private func nib_setupka_() {
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        pay_view = nibView
        pay_view.backgroundColor = .clear
        pay_view.frame = bounds
        pay_view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pay_view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(pay_view)
        setupka_UI()
    }
    
    @objc private func show_progress() {
        //progressView.isHidden = false
        //setapTimerForprogressViewsssssss()
    }
    
    @objc private func purchaseThisApp() {
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
        iapManager.makePurchaseddds()
    }
    
    @IBAction func privacyTapp(_ sender: UIButton) {
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
        let url = URL(string: SubscriptionKey.privacy)
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func termsTapp(_ sender: UIButton) {
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
        let url = URL(string: SubscriptionKey.terms)
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension SubscriptionView {
    
    private func setupka_UI() {
        //gif.animate(withGIFNamed: "but melon")
        //progressView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(show_progress), name: Notification.Name("show_progress"), object: nil)
        continueLabel.text = NSLocalizedString("continue", comment: "").uppercased()
        continueLabel.font = UIFont(name: "Silkscreen-Regular", size: 24)
        continueLabel.textColor = .clear
        purchaseButtonView.backgroundColor = .clear
        let tapPurchase = UITapGestureRecognizer(target: self, action: #selector(purchaseThisApp))
        purchaseButtonView.addGestureRecognizer(tapPurchase)
        setapTextSlidersssssss()
        konfigurLabelFirstssssss()
        configureLinkButtonsaaaaa()
    }
    
    private func setapTimerForprogressViewsssssss() {
//        progressView.progress = 0
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
//            guard let self = self else { return }
//            self.countProgress += 1
//            self.progressView.progress += 0.03333333
//#warning("30 seconds")
//            if self.countProgress == 30.0 {
//                self.timer?.invalidate()
//                NotificationCenter.default.post(name: Notification.Name("show_x_button"), object: nil)
//            }
//        }
//        RunLoop.current.add(timer!, forMode: .common)
    }
    
    private func setapTextSlidersssssss() {
        promoSlider.labelTexts = "\(NSLocalizedString("slider_one", comment: "").uppercased())|n\(NSLocalizedString("slider_two", comment: "").uppercased())|n\(NSLocalizedString("slider_three", comment: "").uppercased())|n\(NSLocalizedString("slider_four", comment: "").uppercased())|n\(NSLocalizedString("slider_five", comment: "").uppercased())"
        promoSlider.label.textColor = .white
        promoSlider.label.addShadowddcdc()
        if UIDevice.current.userInterfaceIdiom == .pad {
            promoSlider.label.font = UIFont(name: "Troika", size: 28)
        } else {
            promoSlider.label.font = UIFont(name: "Troika", size: 28)
        }
        promoSlider.backgroundColor = .clear
    }
    
    private func konfigurLabelFirstssssss() {
        label1.isHidden = true
        if #available(iOS 16, *) {
            if NSLocale.current.language.languageCode?.identifier == "en" {
                label1.isHidden = false
            }
        } else {
            if NSLocale.current.languageCode == "en" {
                label1.isHidden = false
            }
        }
        label1.text = price_text
        label2.text = descriptionText
        if UIDevice.current.userInterfaceIdiom == .pad {
            label1.font = UIFont(name: "Troika", size: 14)
            label2.font = UIFont(name: "Troika", size: 14)
            let priceLabelAttribute = NSMutableAttributedString.init(string: price_text)
            let nsRangePrice = NSString(string: price_text).range(of: price, options: String.CompareOptions.caseInsensitive)
            priceLabelAttribute.addAttributes([NSAttributedString.Key.font: UIFont(name: "Troika", size: 14) as Any, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], range: nsRangePrice)
            label1.attributedText = priceLabelAttribute
        } else {
            label1.font = UIFont(name: "Troika", size: 13)
            label2.font = UIFont(name: "Troika", size: 13)
            let priceLabelAttribute = NSMutableAttributedString.init(string: price_text)
            let nsRangePrice = NSString(string: price_text).range(of: price, options: String.CompareOptions.caseInsensitive)
            priceLabelAttribute.addAttributes([NSAttributedString.Key.font: UIFont(name: "Troika", size: 13) as Any, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], range: nsRangePrice)
            label1.attributedText = priceLabelAttribute
        }
        label1.textColor = UIColor.white
        label1.adjustsFontSizeToFitWidth = true
        label1.addShadowddcdc()
        label2.addShadowddcdc()
        label2.textColor = UIColor.white
    }
    
    private func configureLinkButtonsaaaaa() {
        let attributedString_termsB = NSAttributedString(string: NSLocalizedString("terms_of_use", comment: ""), attributes: [NSAttributedString.Key.font: UIFont(name: "Troika", size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.kern: 0])
        termsB.setAttributedTitle(attributedString_termsB, for: .normal)
        let attributedString_privacyB = NSAttributedString(string: NSLocalizedString("privacy_policy", comment: ""), attributes: [NSAttributedString.Key.font: UIFont(name: "Troika", size: 13) as Any, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.kern: 0])
        privacyB.setAttributedTitle(attributedString_privacyB, for: .normal)
        privacyB.titleLabel?.textAlignment = .center
        privacyB.titleLabel?.numberOfLines = 2
        termsB.titleLabel?.textAlignment = .center
        termsB.titleLabel?.numberOfLines = 2
        privacyB.titleLabel?.adjustsFontSizeToFitWidth = true
        privacyB.titleLabel?.lineBreakMode = .byClipping
        termsB.titleLabel?.adjustsFontSizeToFitWidth = true
        termsB.titleLabel?.lineBreakMode = .byClipping
        privacyB.titleLabel?.addShadowddcdc()
        termsB.titleLabel?.addShadowddcdc()
    }
    
}
