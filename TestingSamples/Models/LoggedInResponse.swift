//
//  LoggedInResponse.swift
//  TestingSamples
//
//  Created by Thulani Mtetwa on 2023/05/26.
//

import Foundation

struct LoggedInResponse : Codable {
    var error: Bool
    var message: String?
    var session: String?
}

extension LoggedInResponse: Equatable {
    static func ==(lhs: LoggedInResponse, rhs: LoggedInResponse) -> Bool {
        return lhs.error == rhs.error &&
        lhs.message == rhs.message &&
        lhs.session == rhs.session
    }
}
