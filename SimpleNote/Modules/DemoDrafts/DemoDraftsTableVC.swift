//
//  DemoDraftsTableVC.swift
//  SimpleNote
//
//  Created by Mphrx. on 02/12/21.
//

import Foundation

import UIKit

class DemoDraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var DemoTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DemoTable.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        DemoTable.dataSource = self
        DemoTable.delegate = self
    }
    
    var models = ["One", "Two", "Three", "Four", "Five"]
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
        {
            let deleteAction = UIContextualAction(style: .destructive, title: "Save Note") { (action, view, CompletionHandler) in
                print("Upload data at row \(indexPath.row)")
                CompletionHandler(true)
            }
            deleteAction.backgroundColor = .systemTeal
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DemoTable.beginUpdates()
            models.remove(at: indexPath.row)
            DemoTable.deleteRows(at: [indexPath], with: .fade)
            DemoTable.endUpdates()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = DemoTable.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
        Cell.field.text = models[indexPath.row]
            return Cell
    }
    
}
