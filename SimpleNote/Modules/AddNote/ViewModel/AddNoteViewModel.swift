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

let cdNotesRepository = NotesRepository()

protocol AddNoteViewModelDelegate: AnyObject {
    func didAddNote(success: Bool, error: String?)
}
class AddNoteViewModel {
    weak var delegate: AddNoteViewModelDelegate?
    var imgUrl: URL?
    var fileUrl: URL?
    func addNote(addRequest: AddNoteModel) {
        uploadFile(urls: [imgUrl, fileUrl], noteId: addRequest.noteId) { isError, errorMessage in
            if isError {
                self.delegate?.didAddNote(success: false, error: errorMessage)
                print("Unable to upload")
            } else {
                FirebaseCRUD.shared.addNoteToFirebase(request: addRequest) { isDataAdded, error in
                    self.delegate?.didAddNote(success: isDataAdded, error: error?.localizedDescription)
                }
            }
        }

    }
    private func uploadFile(urls: [URL?], noteId: String, completion: @escaping (Bool, String?) -> Void) {
        urls.forEach { url in
            if let fileUrl = url {
                FirebaseCRUD.shared.uploadFiles(fileUrl: fileUrl, noteId: noteId) { _, error in
                    if error != nil {
                        completion(true, "Error in uploading file")
                        return
                    }
                }
            }
        }
       completion(false, nil)
    }
    func validateFields(title: String, author: String, description: String) -> NoteValidationResult {
        if title.isEmpty {
            return NoteValidationResult(success: false, error: "Title cannot be empty.", forField: .title)
        }
        if author.isEmpty {
            return NoteValidationResult(success: false, error: "Author cannot be empty.", forField: .author)
        }
        if description.isEmpty {
            return NoteValidationResult(success: false, error: "Note description cannot be empty.", forField: .description)
        }
        return NoteValidationResult(success: true, error: nil, forField: .none)
    }
    
    func singleNotetoAddNoteModel(noteConvert: SingleNote) -> AddNoteModel{
        let current = Date()
        let noteToAdd = AddNoteModel(noteId: noteConvert.noteId, title: noteConvert.noteTitle, author: noteConvert.noteAuthor, date: current, importance: noteConvert.noteImportance, description: noteConvert.noteDescription, imgURL: URL(string: ""), fileURL: URL(string: ""))
        return noteToAdd
    }
}
