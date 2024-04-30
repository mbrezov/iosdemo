//
//  HTTP.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case post = "POST"
    }
    
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
    
}
