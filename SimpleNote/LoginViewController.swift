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
    }
    
    @IBAction func didTapSignUp(){
        guard let SU = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else{return}
        
        navigationController?.pushViewController(SU, animated: true)
    }
    
}

