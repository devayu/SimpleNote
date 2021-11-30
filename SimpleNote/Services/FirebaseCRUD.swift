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
    func addNoteToFirebase() {
    }
    func uploadFiles(fileUrl: URL) {
        let storage = Storage.storage().reference()
        if let currentUser = Auth.auth().currentUser?.uid {
            storage.child("\(currentUser)/\(fileUrl.lastPathComponent)").putFile(from: fileUrl, metadata: nil) { _, error in
                guard error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                storage.child("\(currentUser)/\(fileUrl.lastPathComponent)").downloadURL { imgUrl, error in
                    guard let url = imgUrl, error == nil else {
                        print(error)
                        return
                    }
                    print(url.absoluteURL)
                }
            }
        }
    }
}
