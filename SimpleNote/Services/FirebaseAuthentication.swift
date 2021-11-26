//
//  FirebaseAuthentication.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase
import CoreData
class FirebaseAuthentication {
    static let shared = FirebaseAuthentication()
    func signInWithEmailAndPassword(request: LoginRequest, completion: @escaping AuthResultCallback) {
        Auth.auth().signIn(withEmail: request.email, password: request.password) {  authResult, error in
            if let err = error {
                completion(nil, err)
                return
            }
            completion(authResult?.user, nil)
        }
    }
    
    func signOutUser(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let error {
            completion(false, error)
            return
        }
        completion(true, nil)
    }
}
