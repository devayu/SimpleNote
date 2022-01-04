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

let validator = Validator()

class VerifyUserVM
{
    func verifyUser(userInfo: [String]) -> String
    {
        
        let formatWarning = validator.passEmailValidation(pass: userInfo[3], repass: userInfo[4], email: userInfo[2])
        
        if formatWarning != ""{
            return formatWarning
        }
        
        return ""
        
//        firemodel.newUser(email: email, pass: pass, fname: fname, lname: lname)
    }
    weak var delegate: RecievedUserFromFirebase?
    func createAccount(userInfo :[String:String]) {
        FirebaseAuthentication.shared.signUpWithEmailAndPassword(email: userInfo["email"]!, pass: userInfo["pass"]!, fname: userInfo["fname"]!, lname: userInfo["lname"]!) { user, err in
            self.delegate?.didRecieveUser(data: user, error: err)
        }
    }
    func validateEmptyFields(info: [String: String]) -> ValidationResults
    {
        print("Validating.....")
        if info["fname"]!.isEmpty{
            return ValidationResults(success: false, error: "Please enter a name ", forField: .fname)
        }
        else if info["email"]!.isEmpty{
            return ValidationResults(success: false, error: "Please enter your Email ID ", forField: .email)
        }
        else if !validator.isValidEmail(email: info["email"]!){
            return ValidationResults(success: false, error: "Please follow the correct email format: name@example.com", forField: .email)
        }
        else if info["pass"]!.isEmpty{
            return ValidationResults(success: false, error: "Password cannot be empty ", forField: .pass)
        }
        else if info["pass"]!.count < 8{
            return ValidationResults(success: false, error: "Password cannot be less than 8 characters ", forField: .pass)
        }
        else if !validator.isValidPassword(password: info["pass"]!){
            return ValidationResults(success: false, error: "Please follow the correct password format ", forField: .pass)
        }
        else if info["repass"]!.isEmpty{
            return ValidationResults(success: false, error: "Passwords do not match, please try again ", forField: .repass)
        }
        else if info["pass"]! != info["repass"]!{
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
