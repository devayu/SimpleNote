//
//  HomeVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 24/11/21.
//

import Foundation
import Firebase
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleTxt.text = noteList[indexPath.row]["noteTitle"] as? String
        cell.authorTxt.text = noteList[indexPath.row]["noteAuthor"] as? String
        if let noteDate = noteList[indexPath.row]["noteDate"] as? Timestamp {
            cell.dateTxt.text = noteDate.dateValue().formatted(date: .abbreviated, time: .shortened)
        }
        cell.importanceTxt.text = noteList[indexPath.row]["noteImportance"] as? String
        cell.descTxt.text = (noteList[indexPath.row]["noteDesc"] as! String)
        return cell
    }
}
