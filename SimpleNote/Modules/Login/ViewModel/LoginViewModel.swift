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
    func didRecieveUser(user: User?, error: Error?)
}

class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    func loginUser(request: LoginRequest) {
        FirebaseAuthentication.shared.signInWithEmailAndPassword(request: request) { user, error in
            self.delegate?.didRecieveUser(user: user, error: error)
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
        return ValidationResult(success: true, error: nil, forField: nil)
    }
}
