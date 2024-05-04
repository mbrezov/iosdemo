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
    
    static let newsApiUrl = "https://newsapi.org/v2/everything?q=bitcoin&sortBy=popularity&apiKey=9ae6fe1553854303a30e81bb82105309"
}
