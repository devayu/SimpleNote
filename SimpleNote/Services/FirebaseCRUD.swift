//
//  FirebaseCRUD.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase
class FirebaseCRUD {
    static let shared = FirebaseCRUD()
    func addNoteToFirebase(request: AddNoteModel, completion: @escaping (Bool, Error?) -> Void) {
        let dbRef = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser?.uid {
            let dataToAdd = ["noteId": request.noteId, "noteTitle": request.title, "noteAuthor": request.author, "noteDate": request.date, "noteImportance": request.importance, "noteDesc": request.description] as [String: Any]
            dbRef.collection("users").document("\(currentUser)").collection("notes").addDocument(data: dataToAdd) { error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            }
        }
    }
    func readNotesFromFirebase(completion: @escaping ([NSDictionary], Error?) -> Void) {
        let dbRef = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser?.uid {
            dbRef.collection("users").document("\(currentUser)").collection("notes").order(by: "noteDate", descending: true).limit(to: 5).getDocuments { snapshot, error in
                guard error == nil else {
                    completion([], error)
                    return
                }
                var notes: [NSDictionary] = []
                snapshot?.documents.forEach({ document in
                    notes.append(document.data() as NSDictionary)
                })
                completion(notes, nil)
            }
//            dbRef.collection("users").document("\(currentUser)").addSnapshotListener { snapshot, error in
//                guard error == nil else {
//                    completion([], error)
//                    return
//                }
//                if let notes = snapshot?.get("notes") as? NSArray {
//                    completion(notes.reversed() as NSArray, nil)
//                }
//            }
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
    func downloadFiles(fileName: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let storage = Storage.storage().reference()
        if let currentUser = Auth.auth().currentUser?.uid {
            storage.child("\(currentUser)/\(fileName)").downloadURL { imgUrl, err in
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
}
