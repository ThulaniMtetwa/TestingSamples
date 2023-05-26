//
//  MockedHttpClient.swift
//  TestingSamplesTests
//
//  Created by Thulani Mtetwa on 2023/05/25.
//

import Foundation
@testable import TestingSamples

class MockedHttpClient: HTTPClient {
    var inputRequest: URLRequest?
    var executeCalled = false
    var result: Result<Data, Error>?
    
    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        executeCalled = true
        inputRequest = request
        result.map(completion)
    }
}
