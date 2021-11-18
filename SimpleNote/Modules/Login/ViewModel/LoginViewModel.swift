//
//  LoginViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
// 

import Foundation
import SwiftUI
import Firebase

protocol LoginViewModelDelegate: AnyObject {
    func didRecieveData(data: User?)
    func didRecieveError(error: Error?)
}

class LoginViewModel {

    weak var delegate: LoginViewModelDelegate?
    func loginUser(request: LoginRequest) {
        FirebaseAuthentication.shared.signInWithEmailAndPassword(request: request) { user, error in
            if user == nil {
                self.delegate?.didRecieveError(error: error)
            } else {
                self.delegate?.didRecieveData(data: user)
            }
        }
    }

    func validateLoginFields(for request: LoginRequest) -> ValidationResult {
        if request.email.isEmpty {
            return ValidationResult(success: false, error: "Please enter your email.", forField: .email)
        }
        if !Validation.shared.isValidEmail(email: request.email) {
            return ValidationResult(success: false,
                                    error: "Please enter your email in the format: yourname@example.com",
                                    forField: .email)
        }
        if request.password.isEmpty {
            return ValidationResult(success: false, error: "Please enter your password.", forField: .password)
        }
        return ValidationResult(success: true, error: "", forField: nil)
    }
}
