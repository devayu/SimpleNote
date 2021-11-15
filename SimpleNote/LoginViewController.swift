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
    
}

