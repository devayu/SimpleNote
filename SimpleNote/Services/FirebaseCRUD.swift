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
    
    func newUser(uid: String, fname: String, lname: String, completion: @escaping (SignUpResponse)->Void) {
            
            let db = Firestore.firestore()
            
            if let currentUser = Auth.auth().currentUser?.uid {
                
                db.collection("users").document("\(currentUser)").setData(["firstName": fname, "lastName": lname, "notes":[]], merge: true) { error in
                    
                    if error != nil {
                        print("User created but data couldn't be added")
                        completion(SignUpResponse(isUserCreated: false, error: error))
                        return
                    }
                    else{
                        completion(SignUpResponse(isUserCreated: true, error: nil))
                    }
                }
            }
    }
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
    func readNotesFromFirebase(paginateData: Bool, completion: @escaping ([NSDictionary], Error?) -> Void) {
        let dbRef = Firestore.firestore().collection("users").document("\(currentUser)").collection("notes")
        if let currentUser = Auth.auth().currentUser?.uid {
            let initialBatchOfData = documentPath.order(by: "noteDate", descending: true).limit(to: 5)
            var notes: [NSDictionary] = []
            initialBatchOfData.addSnapshotListener { snapshot, error in
                guard error == nil else {
                    completion([], error)
                    return
                }
                if paginateData {
                    guard let lastSnapshot = snapshot?.documents.last else {
                        return
                    }
                    let nextBatchOfData = documentPath.order(by: "noteDate", descending: true).start(afterDocument: lastSnapshot).addSnapshotListener { snapshot, error in
                        guard error == nil else {
                            print(error)
                            return
                        }
                        print("fetching more")
                        snapshot?.documents.forEach({ document in
                            notes.append(document.data() as NSDictionary)
                        })
                        print(notes)
                    }
                } else {
                    print("no pagination")
                    snapshot?.documents.forEach({ document in
                        notes.append(document.data() as NSDictionary)
                    })
                }
            }
//            dbRef.collection("users").document("\(currentUser)").collection("notes").order(by: "noteDate", descending: true).limit(to: 5).getDocuments { snapshot, error in
//                guard error == nil else {
//                    completion([], error)
//                    return
//                }
//                completion(notes, nil)
//            }
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
    
    private func _paginate(lastSnapshot: QueryDocumentSnapshot, documentPath: CollectionReference){
        
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
