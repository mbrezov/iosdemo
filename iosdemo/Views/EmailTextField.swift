//
//  EmailTextField.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 29.04.2024..
//

import UIKit

class EmailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .secondarySystemBackground
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        autocorrectionType = .no
        keyboardType = .emailAddress
        placeholder = "E-mail"
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftViewMode = .always
    }
}
