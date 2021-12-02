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
            
//            db.collection("users").addDocument(data: ["firstName": fname, "lastName": lname, "uid": uid]) { (error) in
//                if error != nil {
//                    print("User created but data couldn't be added")
//                    completion(SignUpResponse(isUserCreated: false, error: error))
//                    return
//                }
//                else{
//                    completion(SignUpResponse(isUserCreated: true, error: nil))
//                }
//            }
            
            
            
        }
        //        let landingPage = SignUpViewController()
        //        landingPage.toLandingPage()
    }
    
}
