//
//  NoteValidationResult.swift
//  SimpleNote
//
//  Created by Mphrx on 01/12/21.
//

import Foundation
enum NoteTextFields {
    case title
    case author
    case description
}
struct NoteValidationResult {
    let success: Bool
    let error: String?
    let forField: NoteTextFields?
}
