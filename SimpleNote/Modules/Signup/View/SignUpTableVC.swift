//
//  SignupVC.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
import UIKit
import Firebase



class SignUpTableViewController: UIViewController, RecievedUserFromFirebase {
    
    func didRecieveUser(data: User?, error: Error?) {
        print("this function called")
        if error != nil{
        let alert = Alerts.shared.showAlert(message: error!.localizedDescription, title: "")
        self.present(alert, animated: true)
        Alerts.shared.dismissAlert(alert: alert)
        }
        
        else{
            //transition here
            print("Transition to home screen ")
        }
    }

    
    @IBOutlet weak var table: UITableView!
    
    var data = ["Label":"","fname":"", "lname":"", "email":"", "pass":"", "repass":"", "Button":""]
    //var args: [String] = []
//    let cellTypes: [String] = ["Label","fname", "lname", "email", "pass", "repass", "Button"]
    var types = [
        [
            "type": "Label",
            "text": "Sign Up",
            "tag": 1011,
            "passwordToggle": false
        ],
        [
            "type": "text",
            "text": "First name",
            "tag": 1012,
            "passwordToggle": false
        ],
        [
            "type": "text",
            "text": "Last Name",
            "tag": 1013,
            "passwordToggle": false
        ],
        [
            "type": "text",
            "text": "Email",
            "tag": 1014,
            "passwordToggle": false
        ],
        [
            "type": "text",
            "text": "Password",
            "tag": 1015,
            "passwordToggle": true
        ],
        [
            "type": "text",
            "text": "Re Enter Password",
            "tag": 1016,
            "passwordToggle": true
        ],
        [
            "type": "button",
            "text": "Sign Up",
            "tag": 1017,
            "passwordToggle": false
            
        ]
    ]
    //let cellsType: [TypesOfCells.Type] = [Label.self, Text.self]
    
    private let signUpViewModel = VerifyUserVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = Auth.auth().currentUser
        if currentUser != nil{
            print(currentUser)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        table.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        table.register(ButtonTableViewCell.nib(), forCellReuseIdentifier: ButtonTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        
        signUpViewModel.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
    }
    
    func signUpTap2() {
        
        for cells in table.visibleCells{
            if cells.tag == 1012{
                data["fname"] = (cells as! FieldTableViewCell).field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if cells.tag == 1013{
                data["lname"] = (cells as! FieldTableViewCell).field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if cells.tag == 1014{
                data["email"] = (cells as! FieldTableViewCell).field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if cells.tag == 1015{
                data["pass"] = (cells as! FieldTableViewCell).field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            if cells.tag == 1016{
                data["repass"] = (cells as! FieldTableViewCell).field.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        print(data)
        let isValid = signUpViewModel.validateEmptyFields(info: data)
        if !isValid.success {
            switch isValid.forField {
            case .fname:
                print("Error in first name ")
                print(isValid.error)
                (table.viewWithTag(1012) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .email:
                (table.viewWithTag(1014) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .pass:
                (table.viewWithTag(1015) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .repass:
                (table.viewWithTag(1016) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .none:
                break
            }
         }
        else{
            signUpViewModel.createAccount(userInfo: data)
            
            guard let SU = storyboard?.instantiateViewController(withIdentifier: "DemoDraftsViewController") as? DemoDraftsViewController else{return}
            navigationController?.pushViewController(SU, animated: true)
        }
    }
    
}
