//
//  DraftsViewController.swift
//  SimpleNote
//
//  Created by Mphrx. on 29/12/21.
//

import UIKit

class DraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var noteList: [SingleNote] = []
    var notesDict: [SingleNoteCD] = []
    private var homeVm = HomeViewModel()
    let addNoteVM = AddNoteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableData()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleTxt.text = notesDict[indexPath.row].noteTitle
        cell.authorTxt.text = notesDict[indexPath.row].noteAuthor
        let noteDate = notesDict[indexPath.row].noteDate
        cell.dateTxt.text = noteDate.formatted(date: .abbreviated, time: .shortened)
        cell.importanceTxt.text = notesDict[indexPath.row].noteImportance
        cell.descTxt.text = (notesDict[indexPath.row].noteDescription)
        
        return cell
    }
    
    func loadTableData() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
        notesRepository.getAll() { notesDict2 in
            self.notesDict = notesDict2
            print(self.notesDict, "THIS IS THE FILE FETCHED FROM CD", self.notesDict.count)
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
            {
                let deleteAction = UIContextualAction(style: .destructive, title: "Save Note") { (action, view, completionHandler) in
                    print("Upload data at row \(indexPath.row)")
                    let noteToBeAdded = self.addNoteVM.singleNotetoAddNoteModel(noteConvert: self.notesDict[indexPath.row])
                    self.addNoteVM.addNote(addRequest: noteToBeAdded)
                    completionHandler(true)
                }
                deleteAction.backgroundColor = .systemTeal
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                return configuration
            }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let deleteMessage = homeVm.deleteEntryFromCD(noteId: notesDict[indexPath.row].noteId)
                tableView.beginUpdates()
                notesDict.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                let alert = Alerts.shared.showAlert(message: deleteMessage, title: "")
                self.present(alert, animated: true, completion: nil)
                Alerts.shared.dismissAlert(alert: alert, completion: nil)
                print("Deleted")
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
