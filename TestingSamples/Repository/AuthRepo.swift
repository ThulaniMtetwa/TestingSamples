//
//  AuthRepo.swift
//  TestingSamples
//
//  Created by Thulani Mtetwa on 2023/05/26.
//

import Foundation


class AuthRepo {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func login(using username: String, and password: String, completionHandler: @escaping (Result<LoggedInResponse, Error>) ->()) {
        httpClient.execute(request: .login(with: username, and: password), completion: { result in
            completionHandler(self.parse(result))
        })
    }
    
    func parse(_ result: Result<Data, Error>) -> Result<LoggedInResponse, Error> {
        switch result {
        case .success(let success):
            return .success(try! JSONDecoder().decode(LoggedInResponse.self, from: success))
        case .failure(let failure):
            return .failure(failure)
        }
    }
}

extension URLRequest {
    static func login(with username: String, and password: String) -> URLRequest {
        var components = URLComponents(string: "https://www.myfxbook.com/api/login.json")
        components?.queryItems = [
            .init(name: "email", value: "\(username)"),
            .init(name: "password", value: "\(password)")
        ]
        
        return URLRequest(url: components!.url!)
    }
}
