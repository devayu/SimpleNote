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
        cell.titleTxt.text = noteList[indexPath.row].noteTitle
        cell.authorTxt.text = noteList[indexPath.row].noteAuthor
        cell.dateTxt.text = noteList[indexPath.row].noteDate.dateValue().formatted(date: .abbreviated, time: .shortened)
        cell.importanceTxt.text = noteList[indexPath.row].noteImportance
        cell.descTxt.text = noteList[indexPath.row].noteDescription
        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                if segmentedController.selectedSegmentIndex == ListTypes.notes.rawValue {
                    return nil
                }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = noteList[indexPath.row]
        let detailsVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.detailsVC) as? DetailsScreenViewController
        detailsVC?.note = note
        navigationController?.pushViewController(detailsVC!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
