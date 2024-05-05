//
//  SignupViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import Foundation

import UIKit

class SignupViewController: UIViewController {
    
    private lazy var emailTextField = EmailTextField()
    private lazy var passwordTextField = PasswordTextField(placeholder: "Password")
    private lazy var confirmPasswordTextField = PasswordTextField(placeholder: "Confirm password")
    private lazy var confirmButton = ActionButton(backgroundColor: UIColor(red: 0.8, green: 0.82, blue: 0.89, alpha: 1.0), title: "Confirm Sign Up", action: confirmSignup)
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an account?"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    private lazy var loginButton = ActionButton(backgroundColor: .systemIndigo, title: "Login", action: loginHandler)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title="Sign Up"
        
        configureTextFields()
        
        configureErrorLabel()
        
        configureConfirmButton()
        
        configureLoginLabel()
        
        configureLoginButton()
    }
    
    @objc func confirmSignup() {
        let userRequest = SignupUserRequest(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? "",
            confirmPassword: self.confirmPasswordTextField.text ?? ""
        )
        
        guard let request = Endpoint.signup(userRequest: userRequest).request else { return }
        
        AuthService.createAccount(request: request) { result in
            switch result {
                case .success(let successResponse):
                    UserDefaults.standard.set(successResponse.token, forKey: "AuthToken")
                    print("Email: \(successResponse.email)")
                    print("Token: \(successResponse.token)")
                    DispatchQueue.main.async {
                        let vc = TabBarViewController()
                    
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let window = windowScene.windows.first {
                                window.rootViewController = vc
                            }
                    }
                
                case .failure(let error):
                    DispatchQueue.main.async {
                        guard let error = error as? ServiceError else { return }
                    
                        switch error {
                            case .serverError(let message):
                                self.errorLabel.text = "\(message)"
                                self.errorLabel.isHidden = false
                            case .unknownError(let message):
                                self.errorLabel.text = "\(message)"
                                self.errorLabel.isHidden = false
                            case .decodingError(let message):
                                print("Decoding error: \(message)")
                        }
                    }
            }
        }
    }
    
    @objc func loginHandler() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureTextFields() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)

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
    }
    
    func configureErrorLabel() {
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureConfirmButton() {
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 35),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func configureLoginLabel() {
        view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 250),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
