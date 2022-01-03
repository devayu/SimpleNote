//
//  SimpleNoteLoginTests.swift
//  SimpleNoteTests
//
//  Created by Mphrx on 30/12/21.
//

import XCTest
@testable import SimpleNote

class SimpleNoteAuthTests: XCTestCase {

    func testLoginValidationWithNoEmail() {
        let loginRequest = LoginRequest(email: "", password: "1234568")
        let loginVM = LoginViewModel()
        let result = loginVM.validateLoginFields(for: loginRequest)
        XCTAssertNotNil(result.error)
        XCTAssertFalse(result.success)
    }
    func testLoginResponseWithNoPassword() {
        let loginRequest = LoginRequest(email: "test@test.com", password: "")
        let loginVM = LoginViewModel()
        let result = loginVM.validateLoginFields(for: loginRequest)
        XCTAssertNotNil(result.error)
        XCTAssertFalse(result.success)
    }
    func testLoginResponseWithWrongEmailFormat() {
        let loginRequest = LoginRequest(email: "test.testing.com", password: "12345678")
        let loginVM = LoginViewModel()
        let result = loginVM.validateLoginFields(for: loginRequest)
        XCTAssertNotNil(result.error)
        XCTAssertFalse(result.success)
    }
    func testLoginValidationWithValidRequest() {
        let loginRequest = LoginRequest(email: "test@test.com", password: "12345678")
        let loginVM = LoginViewModel()
        let result = loginVM.validateLoginFields(for: loginRequest)
        XCTAssertNil(result.error)
        XCTAssertTrue(result.success)
    }

}
