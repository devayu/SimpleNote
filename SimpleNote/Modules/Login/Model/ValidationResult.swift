//
//  ValidationResult.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation

enum TextFields {
    case password
    case email
}
struct ValidationResult {
    let success: Bool
    let error: String?
    let forField: TextFields?
}
