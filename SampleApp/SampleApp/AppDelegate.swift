//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Nakul  on 04/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum RootViewControllerType {
        case login, home
    }
    
    var window: UIWindow?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch
        window = UIWindow(frame: UIScreen.main.bounds)
        setRootViewController(rootType: .login)
        return true
    }

    
    func setRootViewController(rootType: RootViewControllerType){
        let initialViewController: UIViewController
        switch rootType {
        case .login:
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
        case .home:
            initialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController")
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
  
}
