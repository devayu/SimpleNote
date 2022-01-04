//
//  FirebaseCRUD.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase
struct CustomError: LocalizedError {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    public var errorDescription: String? {
        return message
    }
}
class FirebaseCRUD {
    static let shared = FirebaseCRUD()
    private var lastDocumentSnapshot: DocumentSnapshot!
    private var totalDocumentsSnapshot: DocumentSnapshot!
    private var query: Query!
    var isDataPaginating: Bool = false
    var reachedEndOfDocument: Bool = false
    var didAddNewNote: Bool = false
    func newUser(uid: String, fname: String, lname: String, completion: @escaping (SignUpResponse)->Void) {
        let db = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser?.uid {
            db.collection("users").document("\(currentUser)").setData(["firstName": fname, "lastName": lname, "notes":[]], merge: true) { error in
                if error != nil {
                    print("User created but data couldn't be added")
                    completion(SignUpResponse(isUserCreated: false, error: error))
                    return
                } else {
                    completion(SignUpResponse(isUserCreated: true, error: nil))
                }
            }
        }
    }
    func addNoteToFirebase(request: AddNoteModel, completion: @escaping (Bool, Error?) -> Void) {
        let dbRef = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser?.uid {
            let dataToAdd = ["noteId": request.noteId, "noteTitle": request.title, "noteAuthor": request.author, "noteDate": request.date, "noteImportance": request.importance, "noteDesc": request.description, "noteImgUrl": request.imgURL?.lastPathComponent, "noteFileUrl": request.fileURL?.lastPathComponent] as [String: Any]
            dbRef.collection("users").document("\(currentUser)").collection("notes").addDocument(data: dataToAdd) { error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                FirebaseCRUD.shared.didAddNewNote = true
                completion(true, nil)
            }
        }
    }
    func readNotesFromFirebase(fetchMoreData: Bool, completion: @escaping ([SingleNote], Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        let dbRef = Firestore.firestore().collection("users").document("\(currentUser)").collection("notes")
        query = dbRef.order(by: "noteDate", descending: true).limit(to: 5)
        if fetchMoreData {
            guard lastDocumentSnapshot.documentID != totalDocumentsSnapshot.documentID else {
                DataFetchHelper.shared.reachedEndOfDocument = true
                return
            }
            query = query.start(afterDocument: lastDocumentSnapshot)
            DataFetchHelper.shared.isPaginating = true
        }
        var notes: [SingleNote] = []
        query.getDocuments { snapshot, error in
            guard error == nil else {
                completion([], error)
                return
            }
            if snapshot?.isEmpty == true {
                completion([], CustomError("Seems Like You don't have any saved notes. Try adding one"))
                return
            }
            snapshot?.documents.forEach({ document in
                let data = document.data()
                var note = SingleNote(noteId: (data[NoteFields.id.rawValue] ?? "an error occured" )as! String, noteAuthor: (data[NoteFields.author.rawValue] ?? "an error occured") as! String, noteTitle: (data[NoteFields.title.rawValue] ?? "an error occured") as! String, noteDate: (data[NoteFields.date.rawValue] ?? Timestamp(date: Date(timeIntervalSince1970: 1640597786))) as! Timestamp, noteDescription: (data[NoteFields.description.rawValue] ?? "an error occured") as! String, noteImportance: (data[NoteFields.importance.rawValue] ?? "an error occured") as! String)
                if let imgUrl = data[NoteFields.imgUrl.rawValue], let fileUrl = data[NoteFields.fileUrl.rawValue] {
                    note.noteImgUrl = imgUrl as? String
                    note.noteFileUrl = fileUrl as? String
                }
                notes.append(note)
            })
            self.lastDocumentSnapshot = snapshot!.documents.last
            DataFetchHelper.shared.isPaginating = false
            completion(notes, nil)
        }
    }
    func uploadFiles(fileUrl: URL, noteId: String, completion: @escaping (Bool, Error?) -> Void) {
        let storage = Storage.storage().reference()
        if let currentUser = Auth.auth().currentUser?.uid {
            storage.child("\(currentUser)/\(noteId)/\(fileUrl.lastPathComponent)").putFile(from: fileUrl, metadata: nil) { _, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            }
        }
    }
    func downloadFiles(for noteId: String, fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let storage = Storage.storage().reference()
        if let currentUser = Auth.auth().currentUser?.uid {
            storage.child("\(currentUser)/\(noteId)/\(fileName)").downloadURL { imgUrl, err in
                print(imgUrl)
                guard let url = imgUrl, err == nil else {
                    completion(.failure(err!))
                    return
                }
                HttpUtility.shared.downloadDataFromUrl(url: url) { result in
                    switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    func getAllDocumentsSnapshot() {
        guard let currentUser = Auth.auth().currentUser?.uid else {return}
        let dbRef = Firestore.firestore().collection("users").document("\(currentUser)").collection("notes")
        let query = dbRef.order(by: "noteDate", descending: true)
        query.addSnapshotListener { docSnapshot, error  in
            guard error == nil else {return}
            self.totalDocumentsSnapshot = docSnapshot?.documents.last
        }
    }
}
