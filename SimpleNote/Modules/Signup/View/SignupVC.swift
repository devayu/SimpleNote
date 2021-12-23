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
    @IBOutlet weak var signFirstNameTextField: CustomTextField!
    @IBOutlet weak var signLastNameTextField: CustomTextField!
    @IBOutlet weak var signEmailTextField: CustomTextField!
    @IBOutlet weak var signPassTextField: CustomTextField!
    @IBOutlet weak var signRePassTextField: CustomTextField!
    @IBOutlet weak var signErrorLabel: UILabel!
    
    let verifyUserVm = VerifyUserVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signPassTextField.enablePasswordToggle()
        signRePassTextField.enablePasswordToggle()
    }
    @IBAction func signUpTap(_ sender: Any) {
        
        let validFields = ""//verifyUserVm.verifyUser(fname: signFirstNameTextField.text!, lname: signLastNameTextField.text!, email: signEmailTextField.text!, pass: signPassTextField.text!, repass: signRePassTextField.text!)
        if validFields != ""{
            //verifyUserVm.addError(error: "validFields")
            signErrorLabel.text = validFields
            signErrorLabel.textColor = UIColor.red
        }
        else{
            signErrorLabel.text = ""
//            verifyUserVm.createAccount(email: signEmailTextField.text!, pass: signPassTextField.text!, fname: signFirstNameTextField.text!, lname: signLastNameTextField.text!)
        }
    }
//    func toLandingPage() {
//        guard let WP = storyboard?.instantiateViewController(withIdentifier: "LandingPageController") as? LandingPageViewController else{return}
//        navigationController?.pushViewController(WP, animated: true)
//    }
}
