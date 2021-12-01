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
    func addNoteToFirebase(reuqest: AddNoteRequest) {
    }
    func uploadFiles(fileUrl: URL, completion: @escaping (Bool,Error?)->Void) {
        let storage = Storage.storage().reference()
        if let currentUser = Auth.auth().currentUser?.uid {
            storage.child("\(currentUser)/\(fileUrl.lastPathComponent)").putFile(from: fileUrl, metadata: nil) { _, error in
                guard error == nil else {
                    completion(false,error)
                    return
                }
                completion(true,nil)
            }
        }
    }
    func downloadFiles(fileName: String, completion: @escaping (Result<Data,Error>)->Void) {
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
