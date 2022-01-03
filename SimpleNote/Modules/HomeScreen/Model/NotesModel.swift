//
//  NotesModel.swift
//  SimpleNote
//
//  Created by Mphrx on 28/11/21.
//

import Foundation
import Firebase

struct SingleNoteCD {
    let noteId: String
    let noteAuthor: String
    let noteTitle: String
    let noteDate: Date
    let noteDescription: String
    let noteFiles: [String]
    let noteImportance: String
}

struct SingleNote {
    var noteId: String = "noteID placeholder"
    var noteAuthor: String = "noteAuthor placeholder"
    var noteTitle: String = "noteTitle placeholder"
    var noteDate: Timestamp = Timestamp(date: Date(timeIntervalSince1970: 1640597786))
    var noteDescription: String = "noteDescription placeholder"
    var noteImportance: String = "noteImportance placeholder"
    var noteImgUrl: String?
    var noteFileUrl: String?
}
enum NoteFields: String {
    case id = "noteId"
    case importance = "noteImportance"
    case author = "noteAuthor"
    case title = "noteTitle"
    case date = "noteDate"
    case description = "noteDesc"
    case imgUrl = "noteImgUrl"
    case fileUrl = "noteFileUrl"
}
