//
//  SignupViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import Foundation

import UIKit

class SignupViewController: UIViewController {
    
    let emailTextField = EmailTextField()
    let passwordTextField = PasswordTextField(placeholder: "Password")
    let confirmPasswordTextField = PasswordTextField(placeholder: "Confirm password")
    let confirmButton = ActionButton(backgroundColor: UIColor(red: 205/255, green: 209/255, blue: 228/255, alpha: 1.0), title: "Confirm Sign Up")
    let loginLabel = UILabel()
    let loginButton = ActionButton(backgroundColor: .systemIndigo, title: "Login")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title="Sign Up"
        
        configureTextFields()
        
        view.addSubview(loginButton)
        
        configureLoginButton()
    }
    
    @objc func loginHandler() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureTextFields() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(confirmButton)
        view.addSubview(loginLabel)

        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 45),   
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = "Already have an account?"
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center 
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        loginButton.addTarget(self, action: #selector(loginHandler), for: .touchUpInside) //addTarget has to be implemented into ActionButton, so the selector can be passed
    }
}
