//
//  SignupViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
import FirebaseAuth
import UIKit
//import FirebaseDatabase

let firemodel = FirebaseCrud()
let validator = Validator()

class verifyUserVM
{
    func verifyUser(fname: String, lname: String, email: String, pass: String, repass: String) -> String
    {
        
        let emptyWarning = validateEmptyFields(fname: fname, lname: lname, email: email, pass: pass, repass: repass)
        
        if emptyWarning != ""{
            return emptyWarning
        }
        
        let formatWarning = validator.passEmailValidation(pass: pass, repass: repass, email: email)
        
        if formatWarning != ""{
            return formatWarning
        }
        
        return ""
        
//        firemodel.newUser(email: email, pass: pass, fname: fname, lname: lname)
    }
    
    func createAccount(email: String, pass: String, fname: String, lname: String)
    {
        firemodel.newUser(email: email, pass: pass, fname: fname, lname: lname)
    }
    
    private func validateEmptyFields(fname: String, lname: String, email: String, pass: String, repass: String) -> String
    {
        if fname.isEmpty{
            return "Please enter a name "
        }
        else if email.isEmpty{
            return "Please enter your Email ID"
        }
        else if pass.isEmpty{
            return "Password can not be empty"
        }
        else if repass.isEmpty{
            return "Password do not match, please try again"
        }
        else{
            return ""
        }
    }
    
    func addError(error: String){
        SignUpViewController().signErrorLabel.text = error
        SignUpViewController().signErrorLabel.textColor = UIColor.red
    }
}
