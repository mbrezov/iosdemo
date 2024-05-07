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
        let vc1 = NewsViewController()
        let vc2 = MoreNewsViewController()
        let vc3 = SettingsViewController()
        
        vc1.tabBarItem.image = UIImage(systemName: "newspaper")
        vc2.tabBarItem.image = UIImage(systemName: "square.split.2x1")
        vc3.tabBarItem.image = UIImage(systemName: "gearshape")
        
        vc1.tabBarItem.title = "News"
        vc2.tabBarItem.title = "More News"
        vc3.tabBarItem.title = "Settings"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
