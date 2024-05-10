//
//  newsApiResponses.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 04.05.2024..
//

import Foundation

struct NewsApiResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let content: String
}
