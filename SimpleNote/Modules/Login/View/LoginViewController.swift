//
//  ViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import UIKit
import Firebase
class LoginViewController: UIViewController, LoginViewModelDelegate {
    // Outlets
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passTextField: CustomTextField!
    private let loginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
        passTextField.enablePasswordToggle()
    }
    @IBAction func signInBtn(_ sender: Any) {
        let request = LoginRequest(email: emailTextField.text!, password: passTextField.text!)
        let validationRes = loginViewModel.validateLoginFields(for: request)
        if !validationRes.success {
            switch validationRes.forField {
            case .email:
                self.emailTextField.setError(errorMessage: validationRes.error!)
            case .password:
                self.passTextField.setError(errorMessage: validationRes.error!)
            case .none:
                break
            }
         } else {
            loginViewModel.loginUser(request: request)
        }
    }
    func didRecieveData(data: User?) {
        if data != nil {
            // navigate to homescreen
            print(data)
        }
    }
    func didRecieveError(error: Error?) {
        let alert = Alerts.shared.showAlert(message: error!.localizedDescription, title: "")
        self.present(alert, animated: true)
        Alerts.shared.dismissAlert(alert: alert)
    }
}
