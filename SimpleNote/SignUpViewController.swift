//
//  SignUpViewController.swift
//  SimpleNote
//
//  Created by Mphrx. on 15/11/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var signEmailTextField: UITextField!
    @IBOutlet weak var signPassTextField: UITextField!
    @IBOutlet weak var rePassTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        signPassTextField.enablePasswordToggle()
        rePassTextField.enablePasswordToggle()
    }    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
