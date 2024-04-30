//
//  EmailTextField.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 29.04.2024..
//

import UIKit

class PasswordTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)

        self.placeholder = placeholder
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
//        isSecureTextEntry = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
    }
}
