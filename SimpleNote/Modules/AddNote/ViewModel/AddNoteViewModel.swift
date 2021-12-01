//
//  AddNoteViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 30/11/21.
//

import Foundation
import UIKit
enum Importance: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
class AddNoteViewModel {
    func addNote(addRequest: AddNoteRequest) {
    }
    func validateFields(title: String, author: String, description: String)->NoteValidationResult {
        if title.isEmpty {
            return NoteValidationResult(success: false, error: "Title cannot be empty.", forField: .title)
        }
        if author.isEmpty {
            print("running")
            return NoteValidationResult(success: false, error: "Author cannot be empty.", forField: .author)
        }
        if description.isEmpty {
            return NoteValidationResult(success: false, error: "Note description cannot be empty.", forField: .description)
        }
        return NoteValidationResult(success: true, error: nil, forField: .none)
    }
}
