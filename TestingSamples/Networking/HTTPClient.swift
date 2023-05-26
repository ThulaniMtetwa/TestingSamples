//
//  HTTPClient.swift
//  TestingSamples
//
//  Created by Thulani Mtetwa on 2023/05/26.
//

import Foundation

protocol HTTPClient {
    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

struct HTTPClientImplementation: HTTPClient {
    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(error!))
                }
            }
        }).resume()
    }
}
