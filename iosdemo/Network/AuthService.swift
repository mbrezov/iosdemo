//
//  AuthService.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

enum ServiceError: Error {
    case serverError(String)
    case decodingError(String = "Error parsing server response")
    case unknownError(String = "An unknown error occured")
}

class AuthService {
    
    static func createAccount(request: URLRequest, completion: @escaping
                              (Result<SucessResponse, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                
                if let error = error {
                    completion(.failure(ServiceError.serverError(error.localizedDescription)))
                } else {
                    completion(.failure(ServiceError.unknownError()))
                }
                return
            }
            
            let decoder = JSONDecoder()
     
            if let successMessage = try? decoder.decode(SucessResponse.self, from: data) {
                completion(.success(successMessage))
                return
            }
            else if let errorMessage = try?
                        decoder.decode(ErrorResponse.self, from: data) {
                completion(.failure(ServiceError.serverError(errorMessage.error)))
                return
            }
            else {
                completion(.failure(ServiceError.decodingError()))
                return
            }
        }.resume()
    }
}
