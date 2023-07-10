//
//  LoadingViewController11111.swift
//  ModsApp
//
//  Created by David on 26.04.2023.
//

import UIKit

class LoadingViewController11111: UIViewController {
    
    @IBOutlet weak var loadingViewFrame: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var widh: NSLayoutConstraint!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupka_UI()
        NotificationCenter.default.addObserver(self, selector: #selector(showContent), name: Notification.Name("showContent"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLoader()
        
    }
    
    private func animateLoader() {
        widh.constant = (loadingViewFrame.frame.width) * 0.9
        UIView.animate(withDuration: 3) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { _ in
            print("90%")
//            if ContentLocker.shared.isLostConnection == true {
//                ContentLocker.shared.isLostConnection = false
//                self.showContent()
//            }         
        }
    }
    
    private func setupka_UI() {
        view.backgroundColor = UIColor(red: 0.22, green: 0.286, blue: 0.349, alpha: 1)
        loadingViewFrame.layer.cornerRadius = loadingViewFrame.bounds.height / 2
        loadingViewFrame.layer.borderColor = UIColor(red: 0.929, green: 0.823, blue: 0.674, alpha: 1).cgColor
        loadingViewFrame.layer.borderWidth = 1
        loadingView.layer.cornerRadius = loadingView.bounds.height / 2
        loadingView.backgroundColor = UIColor(red: 0.929, green: 0.823, blue: 0.674, alpha: 1)
        if UIDevice.current.userInterfaceIdiom == .pad {
            loadingLabel.font = UIFont(name: "PressStart2P-Regular", size: 36)
        } else {
            loadingLabel.font = UIFont(name: "PressStart2P-Regular", size: 28)
        }
        loadingLabel.textColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        loadingLabel.text = NSLocalizedString("loading", comment: "").uppercased()
    }
    
    
    private func convertData() {
       
    }
    
    @objc private func showContent() {
        convertData()
        DispatchQueue.main.async { [self] in
            widh.constant = ((loadingViewFrame.frame.width) - 6)
            UIView.animate(withDuration: 1) { [weak self] in
                self?.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                print("done")
                
            }
        }
    }
}


