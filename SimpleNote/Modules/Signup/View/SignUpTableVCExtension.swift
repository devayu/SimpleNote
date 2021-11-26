//
//  SignUpTableVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx. on 26/11/21.
//

import Foundation
import UIKit

extension SignUpTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellsType.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6{
            return 200
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellsType[indexPath.row] == Label.self{
            let cell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Sign Up")
                return cell
            }
            
        if cellsType[indexPath.row] == Button.self{
                let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as! ButtonTableViewCell
                buttonCell.onButtonTapped = { [weak self] in
                    self!.signUpTap2()
                }
                return buttonCell
            }
            
        if cellsType[indexPath.row] == Fname.self {
                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "First Name")
                return fieldCell
            }
            
        if cellsType[indexPath.row] == Lname.self {
                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Last Name")
                return fieldCell
            }
        if cellsType[indexPath.row] == Email.self {
                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Email")
                return fieldCell
            }
        if cellsType[indexPath.row] == Pass.self {
                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Password")
                return fieldCell
            }
        if cellsType[indexPath.row] == Repass.self {
                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Re Enter Password")
                return fieldCell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                for: indexPath)
            cell.textLabel?.text = "Check"
            return cell
        }
}
