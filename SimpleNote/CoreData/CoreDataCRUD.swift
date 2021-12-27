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
    func getAll(completion: @escaping ([AddNoteModel]) -> Void) {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Notes.self)
        result?.forEach({debugPrint($0.noteTitle as Any)})
        let notesDict: [NSDictionary] = []
        //var notesDict: [NotesDict] = []
        var notesDict2: [AddNoteModel] = []
        var notesss: [NSDictionary] = []
        result?.forEach({ (cdNotes) in
            let notes = AddNoteModel(noteId: cdNotes.noteId!, title: cdNotes.noteTitle ?? "", author: cdNotes.noteAuthor ?? "", date: cdNotes.noteDate!, importance: cdNotes.noteImportance ?? "Low", description: cdNotes.description)
            notesDict2.append(notes)
        })
        
        
//        result?.forEach({ document in
//            notesss.append(document as NSDictionary)
//        })
        completion(notesDict2)
    }
}
