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
        
        LoginViewModel.shared.loginUser(request: request) { result in
            
            if result.success == nil {
                let alert = Alerts.shared.showAlert(message: result.error!, title: "")
                self.present(alert, animated: true, completion: nil)
                Alerts.shared.dismissAlert(alert: alert)
            }
        }
    }
    @IBAction func didTapSignUp() {
            guard let SU = storyboard?.instantiateViewController(withIdentifier: "SignUpTableViewController") as? SignUpTableViewController else{return}
            navigationController?.pushViewController(SU, animated: true)
        }
}
