//
//  FirebaseAuthentication.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase

let firebasecrud = FirebaseCrud()

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
                firebasecrud.newUser(uid: (result?.user.uid)!, fname: fname, lname: lname) { SignUpResponse in
                    if SignUpResponse.isUserCreated == false{
                        completion(nil, SignUpResponse.error)
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
}
