//
//  FirebaseCRUD.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import FirebaseAuth
import Firebase

class FirebaseCrud {
    // Add a new user
    
    func newUser(email: String, pass: String, fname: String, lname: String) {
        Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
            if err != nil {
                print("Error in creating user ")
            }
            else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstName": fname, "lastName": lname, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        print("User created but data couldn't be added")
                    }
                }
                
            }
            print("-----------------------", result!, "-----------------------")
        }
//        let landingPage = SignUpViewController()
//        landingPage.toLandingPage()
    }
}
