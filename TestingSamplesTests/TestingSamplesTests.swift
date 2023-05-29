//
//  TestingSamplesTests.swift
//  TestingSamplesTests
//
//  Created by Thulani Mtetwa on 2023/05/25.
//

import XCTest
@testable import TestingSamples

final class TestingSamplesTests: XCTestCase {
    
    func testUsernameIsCorrectLengthValid() {
        //Given
        let systemUnderTest = UsernameValidator()
        //When
        let result = systemUnderTest.isValid("JaneDoe jh")
        //Then
        XCTAssertTrue(result)
    }
    
    func testUsernameIsShortNotValid() {
        //Given
        let systemUnderTest = UsernameValidator()
        //When
        let result = systemUnderTest.isValid("Jan")
        //Then
        XCTAssertFalse(result)
    }
    
    func testLoginInvoked() {
        //Given
        let mockClient = MockedHttpClient()
        let systemUnderTest = AuthRepo(httpClient: mockClient)
        //When
        systemUnderTest.login(using: "admin", and: "admin123", completionHandler: { _ in })
        //Then
        XCTAssertTrue(mockClient.executeCalled)
        XCTAssertEqual(mockClient.inputRequest, .login(with: "admin", and: "admin123"))
    }
    
    func testLoginResponseSuccess() throws {
        //Given
        let expectedResponse = LoggedInResponse(error: false, message: "", session: "loXyMBjndTxK709KE9HX549528")
        let response = try? JSONEncoder().encode(expectedResponse)
        var result: Result<LoggedInResponse, Error>?
        
        let mockClient = MockedHttpClient()
        mockClient.result = .success(response!)
        //When
        let systemUnderTest = AuthRepo(httpClient: mockClient)
        systemUnderTest.login(using: "admin", and: "admin123", completionHandler: { result = $0 })
        //Then
        guard let serverResponse = try result?.get() else {
            XCTFail("No response to get")
            return
        }
        
        XCTAssertEqual(serverResponse, expectedResponse)
    }
    
    func testLoginResponseFailed() throws {
        //Given
        let httpClient = MockedHttpClient()
        httpClient.result = .failure(DummyError())
        
        let sut = AuthRepo(httpClient: httpClient)
        
        var result: Result<LoggedInResponse, Error>?
        
        //When
        sut.login(using: "admin", and: "admin123") { result = $0 }
        
        //Then
        XCTAssertThrowsError(try result?.get()) { error in
            XCTAssertEqual(error as? DummyError , DummyError())
        }
    }
}

//MARK: Test data
struct DummyError: Error, Equatable {}

