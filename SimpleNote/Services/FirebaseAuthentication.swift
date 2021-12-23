//
//  FirebaseAuthentication.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase
import CoreData
//let firebasecrud = FirebaseCrud()

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
    
    func signUpWithEmailAndPassword(email: String, pass: String,fname: String, lname: String, completion: @escaping AuthResultCallback) {
         Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
             if err != nil {
                 print("Error in creating user ")
                 completion(nil, err)
                 return
             }
             else{
                 FirebaseCRUD.shared.newUser(uid: (result?.user.uid)!, fname: fname, lname: lname) { signUpResponse in
                     if signUpResponse.isUserCreated == false{
                         completion(nil, signUpResponse.error)
                     }
                     else{
                         completion(result?.user, nil)
                     }
                 }
             
             }
         }
 //        let landingPage = SignUpViewController()
 //        landingPage.toLandingPage()
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
