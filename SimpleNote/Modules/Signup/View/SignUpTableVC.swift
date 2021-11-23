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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        table.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        table.register(ButtonTableViewCell.nib(), forCellReuseIdentifier: ButtonTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        print("---------")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
        let index = IndexPath(row: 1, section: 0)
        print((table.cellForRow(at: index) as! FieldTableViewCell).field.text ?? "")
    }
    
    func signUpTap2() {
        for i in 1...5 {
        let index = IndexPath(row: i, section: 0)
        args.append((table.cellForRow(at: index) as! FieldTableViewCell).field.text ?? "")
        }
        print(args)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6{
            return 200
        }
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                for: indexPath)
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.font.withSize(60)
            cell.textLabel?.text = "Sign Up"
            return cell
        }
        
        if indexPath.row == 6{
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as! ButtonTableViewCell
            buttonCell.svc = self
            return buttonCell
        }
        
        if indexPath.row < 6{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            if indexPath.row == 1{
                fieldCell.field.placeholder = "First name"
            }
            if indexPath.row == 2{
                fieldCell.field.placeholder = "Last name"
            }
            if indexPath.row == 3{
                fieldCell.field.placeholder = "Email"
            }
            if indexPath.row == 4{
                fieldCell.field.placeholder = "Password"
                fieldCell.field.enablePasswordToggle()
            }
            if indexPath.row == 5{
                fieldCell.field.placeholder = "Re Enter password"
                fieldCell.field.enablePasswordToggle()
            }
           return fieldCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
            for: indexPath)
        cell.textLabel?.text = "Check"
        return cell
    }

}
