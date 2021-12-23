//
//  SignUpValidation.swift
//  SimpleNote
//
//  Created by Mphrx. on 16/11/21.
//

import Foundation

class Validator{
    
    func passEmailValidation(pass: String, repass: String, email: String) -> String
    {
        //Password length
        if pass.count < 8{
            return "Password should be longer than 8 characters"
        }
        //Password regex here
        if isValidPassword(password: pass) != true{
            return "Please follow the correct password format"
        }
        
        //Email regex here
        if isValidEmail(email: email) != true{
            return "Incorrect email format, please enter a correct email"
        }
        
        //Password Matching
        if pass != repass{
            return "Passwords do not match"
        }
        
        return ""
    }
    
    func isValidEmail(email: String)->Bool{
        return NSPredicate(format: "SELF MATCHES %@", Constants.emailRegex).evaluate(with: email)
        
    }
    
    func isValidPassword(password:String)->Bool{
        return NSPredicate(format: "SELF MATCHES %@", Constants.passwordRegex).evaluate(with: password)
    }
}
