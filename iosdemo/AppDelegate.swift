//
//  AppDelegate.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let isLogged = UserDefaults.standard.string(forKey: "AuthToken")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if isLogged != nil {
                    window?.rootViewController = TabBarViewController()
                } else {
                    window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
                }
        
        window?.makeKeyAndVisible()
        
        return true
    }

}
