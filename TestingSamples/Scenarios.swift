//
//  Scenarios.swift
//  TestingSamples
//
//  Created by Thulani Mtetwa on 2023/05/25.
//

import Foundation

enum APIError: Error {
    case underfined
    case urlNotFound
    case noData
    case invalidURL
}

struct UsernameValidator {
    func isValid(_ username: String) -> Bool {
        return username.count > 4
    }
}
