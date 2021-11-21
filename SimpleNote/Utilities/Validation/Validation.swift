//
//  Validation.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation

class Validation {
    static let shared = Validation()
    func isValidEmail(email: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Constants.emailRegex).evaluate(with: email)
    }
    func isValidPassword(password: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Constants.passwordRegex).evaluate(with: password)
    }
}
