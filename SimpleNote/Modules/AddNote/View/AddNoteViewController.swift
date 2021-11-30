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
    @IBOutlet weak var importanceDropdown: UIButton!
    @IBOutlet weak var selectedImgTxt: UILabel!
    @IBOutlet weak var selectedFileTxt: UILabel!
    private let addNoteVM = AddNoteViewModel()
    var imgUrl: URL?
    var fileUrl: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        initAddNoteVC()
    }
    private let importanceMenuItems = [
        [
            "importance": Importance.low,
            "text": Importance.low.rawValue,
            "color": UIColor.systemGreen
        ],
        [
            "importance": Importance.medium,
            "text": Importance.medium.rawValue,
            "color": UIColor.systemOrange
        ],
        [
            "importance": Importance.high,
            "text": Importance.high.rawValue,
            "color": UIColor.systemRed
        ]
    ]
    @IBAction func addBtnTapped(_ sender: Any) {
        FirebaseCRUD.shared.uploadFiles(fileUrl: imgUrl!)
        FirebaseCRUD.shared.uploadFiles(fileUrl: fileUrl!)
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
    }
    @IBAction func selectImgBtnTapped(_ sender: Any) {
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.sourceType = .photoLibrary
        imgPickerVC.delegate = self
        imgPickerVC.allowsEditing = true
        imgPickerVC.mediaTypes = ["public.image"]
        present(imgPickerVC, animated: true)
    }
    @IBAction func selectFileBtnTapped(_ sender: Any) {
        let docPickerVC = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text])
        docPickerVC.delegate = self
        docPickerVC.allowsMultipleSelection = false
        present(docPickerVC, animated: true)
    }
    private func initAddNoteVC() {
        self.navigationItem.title = "Add a Note"
        descriptionTxt.layer.cornerRadius = 5.0
        descriptionTxt.clipsToBounds = true
        titleTxt.becomeFirstResponder()
        self.importanceDropdown.menu = createMenu()
        self.importanceDropdown.showsMenuAsPrimaryAction = true
        self.selectedImgTxt.isHidden = true
        self.selectedFileTxt.isHidden = true
    }
    private func createMenu() -> UIMenu {
        let menuItems = importanceMenuItems.map { item in
            return UIAction(title: item["text"] as! String, image: nil, handler: { _ in
                self.importanceTxt.text = (item["text"] as! String)
                self.importanceTxt.textColor = (item["color"] as! UIColor)
            })
        }
        return UIMenu(title: "", image: nil, identifier: nil, options: .singleSelection, children: menuItems)
    }
}
