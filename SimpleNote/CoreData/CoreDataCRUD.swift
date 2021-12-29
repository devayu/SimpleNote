//
//  CoreDataCRUD.swift
//  SimpleNote
//
//  Created by Mphrx. on 24/12/21.
//

import Foundation


class NotesRepository {
    func create(request: AddNoteModel) {
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
    func getAll(completion: @escaping ([SingleNoteCD]) -> Void) {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Notes.self)
        result?.forEach({debugPrint($0.noteTitle as Any)})
        var notesDict2: [SingleNoteCD] = []
        result?.forEach({ (cdNotes) in
            let notes = SingleNoteCD(noteId: cdNotes.noteId!, noteAuthor: cdNotes.noteAuthor ?? "Placeholder Author", noteTitle: cdNotes.noteTitle!, noteDate: cdNotes.noteDate!, noteDescription: cdNotes.noteDesc ?? "Placeholder Description", noteFiles: ["Placeholder files"], noteImportance: cdNotes.noteImportance ?? "Low")
            notesDict2.append(notes)
            
        })
        completion(notesDict2)
    }
}
