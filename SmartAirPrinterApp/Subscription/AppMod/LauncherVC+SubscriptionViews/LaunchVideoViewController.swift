//
//  LaunchVideoViewController.swift
//  ModsApp
//
//  Created by David on 15.04.2023.
//

import UIKit
import AVFoundation
import Gifu

class LaunchVideoViewController: UIViewController {
    
    enum Screens {
        case first, second, subscription
    }
    
    @IBOutlet weak var gif: GIFImageView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var subscriptionContainerView: UIView!
    @IBOutlet weak var customViewContainer: UIView!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    private var myPlayer: AVPlayer?
    private var myPlayerLayer: AVPlayerLayer?
    private var firstView: FirstViewClass?
    private var secondView: SecondViewClass?
    private var subscriptionView: SubscriptionView?
    private var currentScreen: Screens = .first
    private let iapManager = IAPManagerClass.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(taptap))
        continueButtonView.addGestureRecognizer(tap)
        //gif.animate(withGIFNamed: "but melon")
        setupClearScreen(bool: true)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.iapManager.validatePurchase { [weak self] result in
                if result {
                    print("open app")
//                    ContentLocker.shared.isLocked = false
                    self?.goToTheApp()
                } else {
                    print("open subscription")
//                    ContentLocker.shared.isLocked = true
                    self?.openSubscription()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playMyVideoBackground()
        
    }
    
    @objc private func taptap() {
        if currentScreen == .first {
            currentScreen = .second
            setupCustomView(currentScreen)
        } else if currentScreen == .second {
            currentScreen = .subscription
            setupCustomView(currentScreen)
        }
    }
    
    private func openSubscription() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.setupClearScreen(bool: false)
            self?.setupCustomView(.first)
        }
    }
    
    private func setupCustomView(_ screen: Screens) {
        switch screen {
        case .first:
            firstView = FirstViewClass(frame: customViewContainer.bounds)
            customViewContainer.addSubview(firstView!)
        case .second:
            secondView = SecondViewClass(frame: customViewContainer.bounds)
            customViewContainer.addSubview(secondView!)
            secondView?.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.secondView?.transform = CGAffineTransform(translationX: 0, y: 0)
                self.firstView?.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            } completion: { [weak self] _ in
                self?.firstView?.removeFromSuperview()
                self?.firstView = nil
            }
        case .subscription:
            iapManager.transactionsDelegate = self
            NotificationCenter.default.addObserver(self, selector: #selector(show_x_button), name: Notification.Name("show_x_button"), object: nil)
            restoreButton.alpha = 0
            restoreButton.isHidden = false
            restoreButton.setAttributedTitle(NSAttributedString(string: NSLocalizedString("restore", comment: ""), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
            restoreButton.titleLabel?.addShadowddcdc()
            subscriptionView = SubscriptionView(frame: subscriptionContainerView.bounds)
            subscriptionContainerView.addSubview(subscriptionView!)
            subscriptionView?.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.restoreButton.alpha = 1
                self.subscriptionView?.transform = CGAffineTransform(translationX: 0, y: 0)
                self.customViewContainer?.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                self.continueButtonView?.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            } completion: { [weak self] _ in
                self?.customViewContainer?.removeFromSuperview()
                self?.continueButtonView?.removeFromSuperview()
            }
        }
    }
    
    private func setupClearScreen(bool: Bool) {
        if bool {
            subscriptionContainerView.isHidden = true
        } else {
            continueLabel.text = NSLocalizedString("continue", comment: "").uppercased()
            continueLabel.font = UIFont(name: "Silkscreen-Regular", size: 24)
            continueLabel.textColor = .clear
            continueButtonView.backgroundColor = .clear
            subscriptionContainerView.alpha = 0
            subscriptionContainerView.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.subscriptionContainerView.alpha = 1
            }
        }
    }
    
    private func playMyVideoBackground() {
        var myPathToVideo = ""
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: myPathToVideo = "iphoneVideo"
        case .pad: myPathToVideo = "iphoneVideo"
        default: print("")
        }
        guard let path = Bundle.main.path(forResource: "\(myPathToVideo)", ofType: "mp4") else { return }
        let fileURL = URL.init(fileURLWithPath: path)
        myPlayer = AVPlayer(url: fileURL)
        myPlayerLayer = AVPlayerLayer(player: myPlayer)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone: myPlayerLayer?.videoGravity = .resizeAspectFill
        case .pad: myPlayerLayer?.videoGravity = .resizeAspectFill
        default: print("")
        }
        myPlayerLayer?.frame = videoView.bounds
        videoView?.layer.addSublayer(myPlayerLayer!)
        myPlayer?.play()
        view.backgroundColor = .black
        setupVideoSubscribeNotificationssssss()
    }
    
    private func setupVideoSubscribeNotificationssssss() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupMyPlayerLayerToNil), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reinitializeMyPlayerLayer), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setupMyPlayerLayerToNil), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reinitializeMyPlayerLayer), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(myPlayerItemDidReachEnd(myNotification:)), name: .AVPlayerItemDidPlayToEndTime, object: myPlayer?.currentItem)
    }
    
    @objc private func show_x_button() {
        closeButton.alpha = 0
        closeButton.isHidden = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.closeButton.alpha = 1
        }
    }
    
    @objc private func myPlayerItemDidReachEnd(myNotification: Notification) {
       
        guard let myPlayerItem = myNotification.object as? AVPlayerItem else { return }
        myPlayerItem.seek(to: CMTime.zero) { [weak self] _ in
            self?.myPlayer?.play()
        }
    }
    
    @objc private func myPlayerItemReachedEnd() {
        
        myPlayer?.seek(to: .zero)
    }
    
    @objc private func setupMyPlayerLayerToNil() {
        
        myPlayer?.pause()
        myPlayerLayer = nil
    }
    
    @objc private func reinitializeMyPlayerLayer() {
        
        if let player = myPlayer {
            myPlayerLayer = AVPlayerLayer(player: player)
            if #available(iOS 10.0, *) {
                if player.timeControlStatus == .paused {
                    player.play()
                }
            } else {
                if player.isPlaying == false{
                    player.play()
                }
            }
        }
    }
    
    @IBAction func restoreActionsssss(_ sender: UIButton) {
        
        iapManager.makeRestoressss()
    }
    
    @IBAction func closeActionxxxxx(_ sender: UIButton) {
        
        openLockedApp()
    }
    
    private func openLockedApp() {
//        ContentLocker.shared.isLocked = true
        SceneDelegate.shared?.l0adApp()
    }
    
}

extension LaunchVideoViewController: IAPManagerClassProtocol {
    func infoAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }) )
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func goToTheApp() {
//        ContentLocker.shared.isLocked = false
        SceneDelegate.shared?.l0adApp()
    }
    
    func failed() {
        
        print("oups")
    }
    
    
}
