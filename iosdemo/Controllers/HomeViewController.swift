//
//  HomeViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var signupButton = ActionButton(backgroundColor: .systemIndigo, title: "Sign Up")
    private lazy var loginButton = ActionButton(backgroundColor: .systemIndigo, title: "Login")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
   
        configureButtons()
    }
    
    func configureButtons() {
        view.addSubview(signupButton)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -30),
            signupButton.widthAnchor.constraint(equalToConstant: 250),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        loginButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside) //addTarget has to be implemented into ActionButton, so the selector can be passed
        signupButton.addTarget(self, action: #selector(signupHandler), for: .touchUpInside)
    }
    
    @objc func signupHandler() {
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginHandler() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
