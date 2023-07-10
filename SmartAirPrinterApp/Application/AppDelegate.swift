//
//  AppDelegate.swift
//  SmartAirPrinterApp
//
//  Created by Evhen Lukhtan on 14.06.2023.
//

import UIKit
import CoreData
import SwiftyDropbox
import FirebaseCore
import Adjust
import Pushwoosh
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        setupPushwooshAdjust()
        
        IAPManagerClass.shared.completeAllTransactionssssss()
        IAPManagerClass.shared.loadProductsddddd()
        
        //setupTabBarchik()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
            self.requestPermission()
        })
        
        return true
    }
    
    private func setupPushwooshAdjust() {
        let yourAppToken = adjustToken
        let environment = ADJEnvironmentSandbox as? String
        let adjustConfig = ADJConfig(
            appToken: yourAppToken,
            environment: environment!)
        adjustConfig?.logLevel = ADJLogLevelVerbose
        Adjust.appDidLaunch(adjustConfig)
        
        //set custom delegate for push handling, in our case AppDelegate
        Pushwoosh.sharedInstance().delegate = self;
        //register for push notifications
        Pushwoosh.sharedInstance().registerForPushNotifications()
    }
    
    private func setupTabBarchik() {
        let appearance = UITabBarItem.appearance()
        var tabbarFont = UIFont()
        if UIDevice.current.userInterfaceIdiom == .pad {
            //tabbarFont = UIFont(name: "Troika", size: 16)!
            tabbarFont = .systemFont(ofSize: 16)
        } else {
            //tabbarFont = UIFont(name: "Troika", size: 12)!
            tabbarFont = .systemFont(ofSize: 12)
        }
        let attributes = [NSAttributedString.Key.font: tabbarFont, NSAttributedString.Key.foregroundColor: UIColor(red: 0.929, green: 0.823, blue: 0.674, alpha: 1)]
        let attributes2 = [NSAttributedString.Key.font: tabbarFont, NSAttributedString.Key.foregroundColor: UIColor(red: 0.235, green: 0.373, blue: 0.388, alpha: 1)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .selected)
        appearance.setTitleTextAttributes(attributes2 as [NSAttributedString.Key : Any], for: .normal)
    }
    
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    // Now that we are authorized we can get the IDFA
                    print("     ------>   IDFA: ", ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                    
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        self.requestPermission()
                    })
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        func updateUnique1() {
            print("")
        }
        func updateUnique2() {
            print("")
        }
        return DropboxClientsManager.handleRedirectURL(url) { authResult in
            guard let authResult = authResult else { return }
            switch authResult {
            case .success(let token):
                print("Success! User is logged into Dropbox with token: \(token)")
            case .cancel:
                print("User canceld OAuth flow.")
            case .error(let error, let description):
                print("Error \(error): \(String(describing: description))")
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        func updateUnique1() {
            print("")
        }
        func updateUnique2() {
            print("")
        }
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FilesDataModel")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url - ", description.url?.absoluteString ?? "")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

extension AppDelegate: PWMessagingDelegate {
    //handle token received from APNS
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
    //this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageReceived message: PWMessage!) {
        print("onMessageReceived: ", message.payload?.description)
    }
    
    //this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh!, onMessageOpened message: PWMessage!) {
        print("onMessageOpened: ", message.payload?.description)
    }
}
