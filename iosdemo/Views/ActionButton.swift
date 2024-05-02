//
//  ActionButton.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 29.04.2024..
//

import UIKit

class ActionButton: UIButton {
    
    var selectorHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
  
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.selectorHandler = action
        configure()
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 12
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    @objc private func buttonTapped() {
        selectorHandler?()
    }
}
