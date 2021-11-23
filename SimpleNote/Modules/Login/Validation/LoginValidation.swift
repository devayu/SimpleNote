//
//  LoginValidation.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
class Validation {
    static let shared = Validation()
    func loginValidation(loginRequest: LoginRequest)-> ValidationResult {
        if loginRequest.email.isEmpty && loginRequest.password.isEmpty {
            return ValidationResult(success: false, error: "Email and Password cannot be empty")
        }
        if loginRequest.email.isEmpty {
            return ValidationResult(success: false, error: "Email cannot be empty")
        }
        if loginRequest.password.isEmpty {
            return ValidationResult(success: false, error: "Password cannot be empty")
        }
        if loginRequest.password.count < 8 {
            return ValidationResult(success: false, error: "Password cannot be less than 8 characters")
        }
        let passwordRegex = "^(?=.[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return ValidationResult(success: true, error: "")
    }
    func signUpValidation() {}
}
