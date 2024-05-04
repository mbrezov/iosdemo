//
//  newsApiResponses.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 04.05.2024..
//

import Foundation

struct NewsApiResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
    let urlToImage: String?
    let content: String
}
