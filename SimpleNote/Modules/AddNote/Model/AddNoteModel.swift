//
//  AddNoteRequest.swift
//  SimpleNote
//
//  Created by Mphrx on 01/12/21.
//

import Foundation
struct AddNoteModel {
    let noteId: String
    let title: String
    let author: String
    let date: Date
    let importance: String
    let description: String
    let imgURL: URL?
    let fileURL: URL?
}
