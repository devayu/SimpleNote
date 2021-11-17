//
//  LoginViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
// 

import Foundation
import SwiftUI


class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    func loginUser(request: LoginRequest, completion : @escaping (_ result : LoginResponse)->()){
        
        FirebaseAuthentication.shared.signInWithEmailAndPassword(request: request) { user, error in
            print(user)
            print(error)
        }
    }
    
    
    func validateLoginFields(for request: LoginRequest)->ValidationResult{
        if(request.email.isEmpty){
            return ValidationResult(success: false, error: "Please enter your email.",forField: .email)
        }
        if(request.password.isEmpty){
            return ValidationResult(success: false, error: "Please enter your password.",forField: .password)
        }
        
        if(!Validation.shared.isValidEmail(email: request.email)){
            return ValidationResult(success: false, error: "Please enter your email in the format: yourname@example.com",forField: .email)
        }
        
        return ValidationResult(success: true, error: "",forField: nil)
    }
}
