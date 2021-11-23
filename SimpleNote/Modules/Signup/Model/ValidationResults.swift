//
//  ValidationResult.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation

enum InputFields {
    case fname
    case email
    case pass
    case repass

}
struct ValidationResults {
    let success: Bool
    let error: String?
    let forField: InputFields?
}
