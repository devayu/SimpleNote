//
//  CoreDataCRUD.swift
//  SimpleNote
//
//  Created by Mphrx. on 24/12/21.
//

import Foundation
import CoreData

class NotesRepository {
    static let shared = NotesRepository()
    var resultCount: Int = 0
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
    func getNumberOfData(){
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            guard result != nil else {return}
            resultCount = result.count
            print("resultcount", resultCount)
        } catch let error {
            debugPrint(error)
        }
    }
    func getDataFromCD(offsetInt: Int, limitSize: Int, fetchMore: Bool, completion: @escaping ([SingleNote]) -> Void) {
        var limitSize = limitSize
        if fetchMore {
            DataFetchHelper.shared.isPaginating = true
        }
        if resultCount <= offsetInt{
            DataFetchHelper.shared.isPaginating = false
            DataFetchHelper.shared.reachedEndOfDocument = true
            completion([])
        } else if resultCount < offsetInt + limitSize {
            limitSize = 0
        }
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Notes.self, offsetInt: offsetInt, limitSize: limitSize)
        print(result!.count,  "Alsopaginating")
        var notesDict2: [SingleNote] = []
        result?.forEach({ (cdNotes) in
            let notes = SingleNote(noteId: cdNotes.noteId!, noteAuthor: cdNotes.noteAuthor!, noteTitle: cdNotes.noteTitle!, noteDescription: cdNotes.noteDesc ?? "Placeholder Description", noteImportance: cdNotes.noteImportance ?? "Low", noteImgUrl: "", noteFileUrl: "")
            notesDict2.append(notes)
        })
        DataFetchHelper.shared.isPaginating = false
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
