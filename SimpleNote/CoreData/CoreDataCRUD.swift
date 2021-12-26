//
//  CoreDataCRUD.swift
//  SimpleNote
//
//  Created by Mphrx. on 24/12/21.
//

import Foundation


class NotesRepository {
    
    func create(request: AddNoteModel){
        let cdNotes = Notes(context: PersistentStorage.shared.context)
        cdNotes.noteTitle = request.title
        cdNotes.noteAuthor = request.author
        cdNotes.noteDate = request.date
        cdNotes.noteImportance = request.importance
        cdNotes.noteId = request.noteId
        cdNotes.noteDesc = request.description
        print("Saving data in CD")
        PersistentStorage.shared.saveContext()
    }
}
