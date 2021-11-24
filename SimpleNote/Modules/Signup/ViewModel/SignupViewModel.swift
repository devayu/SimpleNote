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

class VerifyUserVM
{
    func verifyUser(userInfo: [String]) -> String
    {
        
        let emptyWarning = validateEmptyFields(info: userInfo)
        
//        if emptyWarning != ""{
//            return emptyWarning
//        }
        
        let formatWarning = validator.passEmailValidation(pass: userInfo[3], repass: userInfo[4], email: userInfo[2])
        
        if formatWarning != ""{
            return formatWarning
        }
        
        return ""
        
//        firemodel.newUser(email: email, pass: pass, fname: fname, lname: lname)
    }
    
    func createAccount(userInfo: [String])
    {
        firemodel.newUser(email: userInfo[2], pass: userInfo[3], fname: userInfo[0], lname: userInfo[1])
    }
    
    func validateEmptyFields(info: [String]) -> ValidationResults
    {
        if info[0].isEmpty{
            return ValidationResults(success: false, error: "Please enter a name ", forField: .fname)
        }
        else if info[2].isEmpty{
            return ValidationResults(success: false, error: "Please enter your Email ID ", forField: .email)
        }
        else if !validator.isValidEmail(email: info[2]){
            return ValidationResults(success: false, error: "Please follow the correct email format: name@example.com", forField: .email)
        }
        else if info[3].isEmpty{
            return ValidationResults(success: false, error: "Password cannot be empty ", forField: .pass)
        }
        else if info[3].count < 8{
            return ValidationResults(success: false, error: "Password cannot be less than 8 characters ", forField: .pass)
        }
        else if !validator.isValidPassword(password: info[3]){
            return ValidationResults(success: false, error: "Please follow the correct password format ", forField: .pass)
        }
        else if info[4].isEmpty{
            return ValidationResults(success: false, error: "Passwords do not match, please try again ", forField: .repass)
        }
        else if info[3] != info[4]{
            return ValidationResults(success: false, error: "Passwords do not match ", forField: .repass)
        }
        else{
            return ValidationResults(success: true, error: "", forField: .email)
        }
    }
    
    func addError(error: String){
        SignUpViewController().signErrorLabel.text = error
        SignUpViewController().signErrorLabel.textColor = UIColor.red
    }
}
