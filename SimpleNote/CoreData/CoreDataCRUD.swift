//
//  CoreDataCRUD.swift
//  SimpleNote
//
//  Created by Mphrx. on 24/12/21.
//

import Foundation
import CoreData

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
    func getAll(completion: @escaping ([SingleNote]) -> Void) {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Notes.self)
        result?.forEach({debugPrint($0.noteTitle as Any)})
        var notesDict2: [SingleNote] = []
        result?.forEach({ (cdNotes) in
            let notes = SingleNote(noteId: cdNotes.noteId!, noteAuthor: cdNotes.noteAuthor!, noteTitle: cdNotes.noteTitle!, noteDescription: cdNotes.noteDesc ?? "Placeholder Description", noteImportance: cdNotes.noteImportance ?? "Low", noteImgUrl: "", noteFileUrl: "")
//            let notes = SingleNoteCD(noteId: cdNotes.noteId!, noteAuthor: cdNotes.noteAuthor ?? "Placeholder Author", noteTitle: cdNotes.noteTitle!, noteDate: cdNotes.noteDate!, noteDescription: cdNotes.noteDesc ?? "Placeholder Description", noteFiles: ["Placeholder files"], noteImportance: cdNotes.noteImportance ?? "Low")
            notesDict2.append(notes)
        })
        let notes2 = SingleNote(noteId: "1234", noteAuthor: "Placeholder Author", noteTitle: "titles", noteDescription: "Placeholder Description", noteImportance: "Placeholder files", noteImgUrl: "Low")
        notesDict2.append(notes2)
        completion(notesDict2)
    }
    
    func get(byIdentifier id: String) -> SingleNoteCD? {
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        let predicate = NSPredicate(format: "noteId==%@", id)
        
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            let result2 = SingleNoteCD(noteId: (result?.noteId)!, noteAuthor: result?.noteAuthor ?? "Placeholder Author", noteTitle: (result?.noteTitle)!, noteDate: (result?.noteDate)!, noteDescription: result?.noteDesc ?? "Placeholder Description", noteFiles: ["Placeholder Description"], noteImportance: result?.noteImportance ?? "Low")
            return result2
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    private func getCDNotes(byIdentifier id: String) -> Notes? {
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        let predicate = NSPredicate(format: "noteId==%@", id)
        
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
        
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func delete(noteId: String) -> Bool {
        let cdNote = getCDNotes(byIdentifier: noteId)
        guard cdNote != nil else {return false}
        
        PersistentStorage.shared.context.delete(cdNote!)
        return true
    }
}
