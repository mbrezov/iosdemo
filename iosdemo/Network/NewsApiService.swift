//
//  NewsApiService.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 06.05.2024..
//

import Foundation

struct NewsApiService {
    func getNewsData(from url: String, completion: @escaping (Result<NewsApiResponse, Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
    
            let result: NewsApiResponse
            
            do {
                result = try JSONDecoder().decode(NewsApiResponse.self, from: data)
                completion(.success(result))
            } catch {
                print("failed to convert \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
