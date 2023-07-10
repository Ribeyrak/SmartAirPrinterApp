//
//  SceneDelegate.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static weak var shared: SceneDelegate?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Self.shared = self
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LaunchVideoViewController()
        //window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }

    func l0adApp() -> Void {
        let tabBarVC = LoadingViewController11111()
        let navVC = UINavigationController(rootViewController: tabBarVC)
        navVC.setNavigationBarHidden(true, animated: false)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    func loadSubscription() -> Void {
        let tabBarVC = LaunchVideoViewController()
        let navVC = UINavigationController(rootViewController: tabBarVC)
        navVC.setNavigationBarHidden(true, animated: false)
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

