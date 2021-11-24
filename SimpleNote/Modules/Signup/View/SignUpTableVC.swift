//
//  SignupVC.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
import UIKit

class SignUpTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var args: [String] = []
    let cellTypes: [String] = ["Label", "fname", "lname", "email", "pass", "repass", "Button"]
    private let signUpViewModel = VerifyUserVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        table.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        table.register(ButtonTableViewCell.nib(), forCellReuseIdentifier: ButtonTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
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
        for i in 1...5 {
        let index = IndexPath(row: i, section: 0)
            args.append((table.cellForRow(at: index) as! FieldTableViewCell).field.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        print(args)
        
        let isValid = signUpViewModel.validateEmptyFields(info: args)
        if !isValid.success {
            args = []
            switch isValid.forField {
            case .fname:
                let index = IndexPath(row: 1, section: 0)
                (table.cellForRow(at: index) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .email:
                let index = IndexPath(row: 3, section: 0)
                (table.cellForRow(at: index) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .pass:
                let index = IndexPath(row: 4, section: 0)
                (table.cellForRow(at: index) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .repass:
                let index = IndexPath(row: 5, section: 0)
                (table.cellForRow(at: index) as! FieldTableViewCell).field.setError(errorMessage: isValid.error!)
            case .none:
                break
            }
         }
        else{
            signUpViewModel.createAccount(userInfo: args)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6{
            return 200
        }
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellTypes[indexPath.row] == "Label"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.font.withSize(60)
            cell.textLabel?.text = "Sign Up"
            return cell
        }
        
        if cellTypes[indexPath.row] == "Button"{
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as! ButtonTableViewCell
            buttonCell.svc = self
            return buttonCell
        }
        
        if cellTypes[indexPath.row] == "fname"{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            fieldCell.field.placeholder = "First name"
            return fieldCell
        }
        
        if cellTypes[indexPath.row] == "lname"{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            fieldCell.field.placeholder = "Last name"
            return fieldCell
        }
        if cellTypes[indexPath.row] == "email"{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            fieldCell.field.placeholder = "Email"
            return fieldCell
        }
        if cellTypes[indexPath.row] == "pass"{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            fieldCell.field.placeholder = "Password"
            return fieldCell
        }
        if cellTypes[indexPath.row] == "repass"{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            fieldCell.field.placeholder = "Re-enter Password"
            return fieldCell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
            for: indexPath)
        cell.textLabel?.text = "Check"
        return cell
    }

}
