//
//  Endpoints.swift
//  iosdemo
//
//  Created by Mario Brezovečki on 30.04.2024..
//

import Foundation

enum Endpoint {
    //path
    case signup(path: String = "/user/signup", userRequest: SignupUserRequest)
    case login(path: String = "/user/login", userRequest: LoginUserRequest)
    
    //makign a request
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.addValues(for: self)
        request.httpBody = self.httpBody
        
        return request
    }
    
    
    private var url: URL? {
        var components = URLComponents()
        
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        
        return components.url
    }
    
    private var path: String {
        //checks what route is and it returns a path
        switch self {
        case .signup(let path, _):
            return path
        case .login(let path, _):
            return path
        }
    }
    
    //making http method function
    private var httpMethod: String {
        switch self {
        case .signup:
            return HTTP.Method.post.rawValue //return "POST" string
        case .login:
            return HTTP.Method.post.rawValue //return "POST" string
        }
    }
    
    private var httpBody: Data? {
        //encoding signupUSerRequest into JSON forma
        switch self {
        case .signup(_, let userRequest):
            return try? JSONEncoder().encode(userRequest) //returns JSON
        case .login(_, let userRequest):
            return try? JSONEncoder().encode(userRequest) //returns JSON
        }
    }
    
}

extension URLRequest {
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .signup:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            return
        case .login:
            self.setValue(HTTP.Headers.Value.applicationJson.rawValue, forHTTPHeaderField: HTTP.Headers.Key.contentType.rawValue)
            return
        }
    }
}
