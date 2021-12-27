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
        return noteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleTxt.text = noteList[indexPath.row]["noteTitle"] as? String
        cell.authorTxt.text = noteList[indexPath.row]["noteAuthor"] as? String
        let noteDate = noteList[indexPath.row]["noteDate"] as? Date
        cell.dateTxt.text = noteDate?.formatted(date: .abbreviated, time: .shortened)
        cell.importanceTxt.text = noteList[indexPath.row]["noteImportance"] as? String
        cell.descTxt.text = (noteList[indexPath.row]["noteDesc"] as! String)
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
            {
                let deleteAction = UIContextualAction(style: .destructive, title: "Save Note") { (action, view, completionHandler) in
                    print("Upload data at row \(indexPath.row)")
                    completionHandler(true)
                }
                deleteAction.backgroundColor = .systemTeal
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                return configuration
            }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                tableView.beginUpdates()
                noteList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                print("Deleted")
            }
            
        }
}
