//
//  AppDelegate.swift
//  Ouro
//
//  Created by PC on 21/10/19.
//  Copyright © 2019 PC. All rights reserved.
//

import UIKit
import GoogleMaps
import  Firebase
import IQKeyboardManagerSwift
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame:UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)

        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyALizHyvUmnpjNuiwqRfyUStlP9ZLbcxn4")
        FirebaseApp.configure()
        if (UserDefaults.standard.data(forKey: "Userdata") as? Data) != nil {
            DispatchQueue.main.async {
                let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "ChooseExperianceVC") as! ChooseExperianceVC
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = initialViewControlleripad
                self.window?.makeKeyAndVisible()
            }
            //YES Already Login
//            let viewController = storyboard.instantiateViewController(withIdentifier: "ChooseExperianceVC") as! ChooseExperianceVC
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            self.window?.rootViewController = navigationController
//            self.window?.makeKeyAndVisible()
        } else {
            let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
            //NOT Login
//            let viewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
//            let navigationController = UINavigationController.init(rootViewController: viewController)
//            self.window?.rootViewController = navigationController
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
}

