//
//  HomeVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 24/11/21.
//

import Foundation
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPoints.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.authorLabelTxt.text = dataPoints[indexPath.row]["noteAuthor"] as? String
        cell.dateLabelTxt.text = dataPoints[indexPath.row]["noteDate"] as? String
        cell.importanceLabelTxt.text = dataPoints[indexPath.row]["noteImportance"] as? String
        cell.descLabelTxt.text = (dataPoints[indexPath.row]["noteDesc"] as! String)
        return cell
    }
}
