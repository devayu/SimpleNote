//
//  ViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passTextField.enablePasswordToggle()
    }
    @IBAction func signInBtn(_ sender: Any) {
        
        let request = LoginRequest(email: emailTextField.text!, password: passTextField.text!)
        
        LoginViewModel.shared.loginUser(request: request) { result in
            
            if result.success == nil {
                let alert = Alerts.shared.showAlert(message: result.error!, title: "")
                self.present(alert, animated: true, completion: nil)
                
                Alerts.shared.dismissAlert(alert: alert)
            }
        }
        
    }
    
}

