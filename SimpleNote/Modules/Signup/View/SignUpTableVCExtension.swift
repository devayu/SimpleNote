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
        types.count 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if tableView.cellForRow(at: indexPath)?.textLabel?.text == "Sign Up"{
//            return 200
//        }
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if types[indexPath.row]["type"] as! String != "button"{
            return CellRow.create(tableView, type: types[indexPath.row]["type"] as! String, index: indexPath, text: types[indexPath.row]["text"] as! String, tag: types[indexPath.row]["tag"] as! Int, passwordToggle: types[indexPath.row]["passwordToggle"] as! Bool)
            }
//        if types[indexPath.row]["type"] as! String == "text"{
//            return Text.self.create(tableView, index: indexPath, text: types[indexPath.row]["text"] as! String, tag: types[indexPath.row]["tag"] as! Int)
//            }
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as! ButtonTableViewCell
            buttonCell.onButtonTapped = { [weak self] in
                self!.signUpTap2()
            }
            return buttonCell
        }

//        return Label.self.create(tableView, index: indexPath, text: types[indexPath.row]["text"] as! String, tag: types[indexPath.row]["tag"] as! Int)
//    }
        
//        if cellsType[indexPath.row] == Label.self{
//            let cell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Sign Up")
//                return cell
//            }
//
//                let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: indexPath) as! ButtonTableViewCell
//                buttonCell.onButtonTapped = { [weak self] in
//                    self!.signUpTap2()
//                }
//                return buttonCell
//            }
//
//        if cellsType[indexPath.row] == Fname.self {
//                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "First Name")
//                return fieldCell
//            }
//
//        if cellsType[indexPath.row] == Lname.self {
//                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Last Name")
//                return fieldCell
//            }
//        if cellsType[indexPath.row] == Email.self {
//                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Email")
//                return fieldCell
//            }
//        if cellsType[indexPath.row] == Pass.self {
//                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Password")
//                return fieldCell
//            }
//        if cellsType[indexPath.row] == Repass.self {
//                let fieldCell = cellsType[indexPath.row].create(tableView, index: indexPath, text: "Re Enter Password")
//                return fieldCell
//            }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
//                for: indexPath)
//            cell.textLabel?.text = "Check"
//            return cell
        }


