//
//  LoginViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    private lazy var emailTextField = EmailTextField()
    private lazy var passwordTextField = PasswordTextField(placeholder: "Password")
    private lazy var confirmButton = ActionButton(backgroundColor: UIColor(red: 0.8, green: 0.82, blue: 0.89, alpha: 1.0), title: "Login", action: confirmLogin)
    private lazy var signupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account?"
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
    private lazy var signupButton = ActionButton(backgroundColor: .systemIndigo, title: "Sign Up", action: signupHandler)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title="Login"
        
        configureTextFields()
        
        configureErrorLabel()
        
        configureConfirmButton()

        configureSignupLabel()
        
        configureSignupButton()
    }
    
    @objc func confirmLogin() {
        let userRequest = LoginUserRequest(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? ""
        )
        
        guard let request = Endpoint.login(userRequest: userRequest).request else { return }
        
        AuthService.getAccount(request: request) { result in
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
    
    @objc func signupHandler() {
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureTextFields() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)

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
    }
    
    func configureConfirmButton() {
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 200),
            confirmButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func configureErrorLabel() {
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureSignupLabel() {
        view.addSubview(signupLabel)
        
        NSLayoutConstraint.activate([
            signupLabel.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 20),
            signupLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configureSignupButton() {
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 250),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
