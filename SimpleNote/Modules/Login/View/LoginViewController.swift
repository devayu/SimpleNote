//
//  ViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passTextField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passTextField.enablePasswordToggle()
    
    }
    @IBAction func signInBtn(_ sender: Any) {
        
        let request = LoginRequest(email: emailTextField.text!, password: passTextField.text!)
        let validationRes = LoginViewModel.shared.validateLoginFields(for: request)
        if !validationRes.success {
            switch validationRes.forField {
            case .email:
                self.emailTextField.setError(errorMessage: validationRes.error!)
            case .password:
                self.passTextField.setError(errorMessage: validationRes.error!)
            case .none:
                break
            }
        }
        else {
            LoginViewModel.shared.loginUser(request: request) { result in
            }
        }
        
    }
    
}

