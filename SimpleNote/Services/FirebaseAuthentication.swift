//
//  FirebaseAuthentication.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import Foundation
import Firebase
class FirebaseAuthentication {
    
    static let shared = FirebaseAuthentication()
    
    func signInWithEmailAndPassword(request: LoginRequest, completion: @escaping AuthResultCallback){
        let email = request.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let pass = request.password.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: pass) {  authResult, error in
            if let err = error {
                completion(nil,err)
                return
            }
            completion(authResult?.user,nil)
        }
    }
    
}
