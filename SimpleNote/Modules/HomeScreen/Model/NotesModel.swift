//
//  NotesModel.swift
//  SimpleNote
//
//  Created by Mphrx on 28/11/21.
//

import Foundation

struct FirebaseUser: Codable {
    let uid: String
    let fName: String
    let lName: String?
    let email: String
    let notes: [SingleNote]
}

struct SingleNote: Codable {
    let noteId: String
    let noteAuthor: String
    let noteTitle: String
    let noteDate: Date
    let noteDescription: String
    let noteFiles: [String]
}
