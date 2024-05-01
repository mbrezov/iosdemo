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
    private lazy var confirmButton = ActionButton(backgroundColor: UIColor(red: 205/255, green: 209/255, blue: 228/255, alpha: 1.0), title: "Login")
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    private lazy var signupButton = ActionButton(backgroundColor: .systemIndigo, title: "Sign Up")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.errorLabel.isHidden = true
        
        title="Login"
        
        configureTextFields()
        
        configureErrorLabel()

        view.addSubview(signupButton)
        
        configureLoginButton()
    }
    
    @objc func didTapConfirm() {
        let userRequest = LoginUserRequest(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? ""
        )
        
        guard let request = Endpoint.login(userRequest: userRequest).request else { return }
        
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
                                window.makeKeyAndVisible()
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
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35),
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
        
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
    }

    func configureLoginButton() {
        view.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 250),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        signupButton.addTarget(self, action: #selector(signupHandler), for: .touchUpInside) //addTarget has to be implemented into ActionButton, so the selector can be passed
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
}
