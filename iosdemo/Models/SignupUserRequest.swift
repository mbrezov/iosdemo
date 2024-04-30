//
//  signupUserRequest.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

struct SignupUserRequest: Codable {
    let email: String
    let password: String
    //let confirmPassword: String -> password checking will be implemented on the server side
}

struct LoginUserRequest: Codable {
    let email: String
    let password: String
}
