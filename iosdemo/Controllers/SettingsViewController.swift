//
//  SettingsViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation
import UIKit


class SettingsViewController: UIViewController {
    
    private lazy var logoutButton = ActionButton(backgroundColor: .systemIndigo, title: "Logout")
    private lazy var tabBar = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        configureButton()
    }
    
    func configureButton() {
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            logoutButton.widthAnchor.constraint(equalToConstant: 250),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    
        logoutButton.addTarget(self, action: #selector(logoutHandler), for: .touchUpInside)
    }
    

    @objc func logoutHandler() {
        UserDefaults.standard.removeObject(forKey: "AuthToken")
        UserDefaults.standard.synchronize()
        
        let vc = HomeViewController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = UINavigationController(rootViewController: vc)
                window.makeKeyAndVisible()
            }
        }
    }
}
