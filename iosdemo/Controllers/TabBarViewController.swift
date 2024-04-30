//
//  TabBarViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        configureTabBar()
       
    }
    
    private func configureTabBar() {
        let vc1 = MainViewController()
        let vc2 = SettingsViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "gearshape")
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        setViewControllers([nav1, nav2], animated: true)
    }
}
