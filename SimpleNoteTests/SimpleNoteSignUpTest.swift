//
//  SimpleNoteSignUpTest.swift
//  SimpleNoteTests
//
//  Created by Mphrx. on 03/01/22.
//

import XCTest
@testable import SimpleNote

class SimpleNoteSignUpTest: XCTestCase {

    func testSignUpWithNoName() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"", "lname":"", "email":"sid@gmail.com", "pass":"Mphrx@123", "repass":"Mphrx@123", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithNoEmail() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"Sid", "lname":"", "email":"", "pass":"Mphrx@123", "repass":"Mphrx@123", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithNoPassword() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"", "lname":"", "email":"sid@gmail.com", "pass":"", "repass":"Mphrx@123", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithNoRePassword() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"", "lname":"", "email":"sid@gmail.com", "pass":"Mphrx@123", "repass":"", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithDifferentPasswords() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"", "lname":"", "email":"sid@gmail.com", "pass":"Mphrx@123", "repass":"Mphrx@456", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithWrongEmailFormat() {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname":"Sid", "lname":"", "email":"test.test.com", "pass":"Mphrx@123", "repass":"Mphrx@123", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithWrongPassFormat() {
        let signUpVM = VerifyUserVM()
        let data = ["Label": "Sign Up", "fname":"Sid", "lname":"", "email": "test@test.com", "pass": "MphrxOneTwoThree", "repass":"MphrxOneTwoThree", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    func testSignUpWithWrongPassLength()  {
        let signUpVM = VerifyUserVM()
        let data = ["Label":"Sign Up","fname": "Sid", "lname":"", "email":"test@test.com", "pass":"Mph@12", "repass":"Mph@12", "Button":"SignUp"]
        let result = signUpVM.validateEmptyFields(info: data)
        XCTAssertNotNil(data)
        XCTAssertEqual(result.error, "")
        XCTAssertTrue(result.success)
    }
    


}
