//
//  ServerResponses.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

class SucessResponse: Decodable {
    let email: String
    let token: String
}

class ErrorResponse: Decodable {
    let error: String
}
