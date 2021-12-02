//
//  DemoDraftsTableVC.swift
//  SimpleNote
//
//  Created by Mphrx. on 02/12/21.
//

import Foundation

import UIKit

class DemoDraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            return Cell
    }
    


}
