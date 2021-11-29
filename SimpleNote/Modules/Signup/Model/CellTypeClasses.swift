//
//  CellTypeClasses.swift
//  SimpleNote
//
//  Created by Mphrx. on 26/11/21.
//

import Foundation
import UIKit

class CellRow {
    static func create(_ tableView: UITableView, type: String, index: IndexPath, text: String, tag: Int, passwordToggle: Bool) -> UITableViewCell{
        if type == "Label"{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
            for: index)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.text = text
        cell.textLabel?.font.withSize(60)
        cell.tag = 1011
        return cell
        }
        else{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
            fieldCell.field.placeholder = text
            fieldCell.tag = tag
            print("tag of cell is ", fieldCell.tag)
            if passwordToggle{
                fieldCell.field.enablePasswordToggle()
            }
            return fieldCell
        }
    }
}

//class Text : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String, tag: Int) -> UITableViewCell{
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
//        fieldCell.field.placeholder = text
//        fieldCell.tag = tag
//        return fieldCell
//    }
//}
//
//enum TypeOfCell {
//    case Label
//    case TextField
//}

//class Lname : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell{
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
//        fieldCell.field.placeholder = text
//        fieldCell.tag = 1013
//        return fieldCell
//    }
//}
//
//class Email : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell{
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
//        fieldCell.field.placeholder = text
//        fieldCell.tag = 1014
//        return fieldCell
//    }
//}
//
//class Pass : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell{
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
//        fieldCell.field.placeholder = text
//        fieldCell.tag = 1015
//        return fieldCell
//    }
//}
//
//class Repass : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell{
//        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: index) as! FieldTableViewCell
//        fieldCell.field.placeholder = text
//        fieldCell.tag = 1016
//        return fieldCell
//    }
//}
//
//class Button : TypesOfCells {
//    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell{
//        let buttonCell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.identifier, for: index) as! ButtonTableViewCell
//        return buttonCell
//    }
//}
