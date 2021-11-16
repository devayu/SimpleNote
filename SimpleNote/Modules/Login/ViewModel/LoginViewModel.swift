//
//  LoginViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
// 

import Foundation


class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    func loginUser(request: LoginRequest, completion : @escaping (_ result : LoginResponse)->()){
        
        let validationResult = Validation.shared.loginValidation(loginRequest: request)
        
        if validationResult.success {
        // make Firebase login call
        }
        else {
            let loginResponse = LoginResponse(success: nil, error: validationResult.error)
            _ = completion(loginResponse)
        }
    }
}
