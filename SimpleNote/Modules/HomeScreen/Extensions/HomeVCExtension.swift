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
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPoints.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleTxt.text = dataPoints[indexPath.row]["noteTitle"] as? String
        cell.authorTxt.text = dataPoints[indexPath.row]["noteAuthor"] as? String
        let noteDate = dataPoints[indexPath.row]["noteDate"] as? Date
        cell.dateTxt.text = noteDate?.formatted(date: .abbreviated, time: .shortened)
        cell.importanceTxt.text = dataPoints[indexPath.row]["noteImportance"] as? String
        cell.descTxt.text = (dataPoints[indexPath.row]["noteDesc"] as! String)
        return cell
    }
}
