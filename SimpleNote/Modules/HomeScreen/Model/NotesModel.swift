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
    let noteImportance: String
}
enum NoteFields: String {
    case id = "noteId"
    case importance = "noteImportance"
    case author = "noteAuthor"
    case title = "noteTitle"
    case date = "noteDate"
    case description = "noteDesc"
}
