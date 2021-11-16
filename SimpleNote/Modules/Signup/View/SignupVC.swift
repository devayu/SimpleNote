//
//  SignupVC.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var signFirstNameTextField: UITextField!
    @IBOutlet weak var signLastNameTextField: UITextField!
    @IBOutlet weak var signEmailTextField: UITextField!
    @IBOutlet weak var signPassTextField: UITextField!
    @IBOutlet weak var signRePassTextField: UITextField!
    
    
    let newUserVm = newUserVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //signPassTextField.enablePasswordToggle()
        //signRePassTextField.enablePasswordToggle()
        
    }
    
    @IBAction func SignUpTap(_ sender: Any){
        newUserVm.addUser(fname: signFirstNameTextField.text!, lname: signLastNameTextField.text!, email: signEmailTextField.text!, pass: signPassTextField.text!)
    }
    
    func toWelcomePage()
    {
        guard let WP = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else{return}
        
        navigationController?.pushViewController(WP, animated: true)
    }
    
}
