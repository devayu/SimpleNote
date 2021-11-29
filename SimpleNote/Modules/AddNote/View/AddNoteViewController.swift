//
//  AddNoteViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 29/11/21.
//

import UIKit
enum TextFieldType {
    case multiline
    case singleline
}

class AddNoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var formTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAddNoteVC()
    }
    private func initAddNoteVC() {
        self.navigationItem.title = "Add a Note"
        formTable.delegate = self
        formTable.dataSource = self
        formTable.register(UINib(nibName: Constants.Cells.formCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.formCell)
    }
    var fields = ["Author", "Date", "Importance", "Description"]
    var formFields = [
    [
        "name": "Author",
        "type": TextFieldType.singleline
    ],
    [
        "name": "Date",
        "type": TextFieldType.singleline
    ],
    [
        "name": "Importace",
        "type": TextFieldType.singleline
    ],
    [
        "name": "Description",
        "type": TextFieldType.multiline
    ]
    ]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.formCell, for: indexPath) as! FormTableCell
        cell.formLabel.placeholder = formFields[indexPath.row]["name"] as! String
        return cell
    }
}
