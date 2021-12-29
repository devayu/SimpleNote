//
//  NotesModel.swift
//  SimpleNote
//
//  Created by Mphrx on 28/11/21.
//

import Foundation
import Firebase

struct SingleNote {
    let noteId: String
    let noteAuthor: String
    let noteTitle: String
    let noteDate: Timestamp
    let noteDescription: String
    let noteFiles: [String]
    let noteImportance: String

}

struct SingleNoteCD {
    let noteId: String
    let noteAuthor: String
    let noteTitle: String
    let noteDate: Date
    let noteDescription: String
    let noteFiles: [String]
    let noteImportance: String

}

