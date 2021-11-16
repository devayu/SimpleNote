//
//  SignupViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
import FirebaseAuth

let firemodel = FirebaseCrud()

class newUserVM
{
    func addUser(fname: String, lname: String, email: String, pass: String)
    {
        firemodel.newUser(email: email, pass: pass, fname: fname, lname: lname)
    }
}
