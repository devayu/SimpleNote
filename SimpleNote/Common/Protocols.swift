//
//  protocols.swift
//  SimpleNote
//
//  Created by Mphrx. on 26/11/21.
//

import Foundation
import Firebase
import UIKit

protocol RecievedUserFromFirebase: AnyObject {
    func didRecieveUser(data: User?, error: Error?)
    
}
protocol TypesOfCells {
    static func create(_ tableView: UITableView, index: IndexPath, text: String) -> UITableViewCell
}
