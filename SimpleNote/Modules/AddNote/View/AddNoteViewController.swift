//
//  AddNoteViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 29/11/21.
//

import UIKit
class AddNoteViewController: UIViewController {
    @IBOutlet weak var authorTxt: UITextField!
    @IBOutlet weak var importanceTxt: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var titleTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initAddNoteVC()
    }
    @IBAction func addBtnTapped(_ sender: Any) {
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
    }
    private func initAddNoteVC() {
        self.navigationItem.title = "Add a Note"
        descriptionTxt.layer.cornerRadius = 5.0
        descriptionTxt.clipsToBounds = true
        titleTxt.becomeFirstResponder()
    }
}
