//
//  HomeViewController.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 27.04.2024..
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("button", for: .normal)
        b.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        b.backgroundColor = .green
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

    @objc func buttonTapped() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

