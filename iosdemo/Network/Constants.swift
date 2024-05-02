//
//  Constants.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

struct Constants {
    static let scheme: String = "http"
    static let baseURL: String = "localhost"
    static let port: Int = 4000
    static let fullURL = "\(scheme)://\(baseURL):\(port)"
}
