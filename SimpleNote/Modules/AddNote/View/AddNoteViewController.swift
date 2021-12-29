//
//  AddNoteViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 29/11/21.
//
import UIKit
class AddNoteViewController: UIViewController, AddNoteViewModelDelegate {
    @IBOutlet weak var authorTxt: CustomTextField!
    @IBOutlet weak var importanceTxt: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTxt: CustomTextView!
    @IBOutlet weak var titleTxt: CustomTextField!
    @IBOutlet weak var importanceDropdown: UIButton!
    @IBOutlet weak var selectedImgTxt: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var selectedFileTxt: UILabel!
    lazy var addNoteVM: AddNoteViewModel = {
        return AddNoteViewModel()
    }()
    override func viewDidLoad() {
        cdNotesRepository.getAll()
        super.viewDidLoad()
        initAddNoteVC()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    func checkForUnsavedChanges() {
        if let authorTxt = authorTxt.text, let titleTxt = titleTxt.text, let descTxt = descriptionTxt.text {
            if !authorTxt.isEmpty || !titleTxt.isEmpty || !descTxt.isEmpty {
                let alert = Alerts.shared.showAlert(message: "Are you sure you want to go back?", title: "You have unsaved changes")
                let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                    alert.dismiss(animated: true, completion: nil)
                    self.navigationController?.popToRootViewController(animated: true)
                }
                let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
                alert.addAction(noAction)
                alert.addAction(yesAction)
                present(alert, animated: true, completion: nil)
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    @IBAction func addBtnTapped(_ sender: Any) {
        let noteId = UUID().uuidString
        let request = AddNoteModel(noteId: noteId, title: titleTxt.text ?? "", author: authorTxt.text ?? "", date: datePicker.date, importance: importanceTxt.text!, description: descriptionTxt.text ?? "")
        let validationResult =  addNoteVM.validateFields(title: request.title, author: request.author, description: request.description)
        if !validationResult.success {
            switch validationResult.forField {
            case .title:
                self.titleTxt.setError(errorMessage: validationResult.error!)
            case .author:
                self.authorTxt.setError(errorMessage: validationResult.error!)
            case .description:
                self.descriptionTxt.setError(errorMessage: validationResult.error!)
            case .none:
                break
            }
        } else {
            if NetworkMonitor.shared.isConnected {
            addNoteVM.addNote(addRequest: request)
                }
            else {
                let alert = Alerts.shared.showAlert(message: "", title: "No internet detected. Do you want to save to drafts?")
                let deleteAction = UIAlertAction(title: "Delete Note", style: .destructive) { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
                let addToDraftAction = UIAlertAction(title: "Save as Draft", style: .default) { _ in
                    print("add to draft")
                    cdNotesRepository.create(request: request)
//                    self.didAddNote(success: false, error: "Added note to Drafts ")
                    self.navigationController?.popToRootViewController(animated: true)
                }
                let continueAction = UIAlertAction(title: "Continue writing", style: .default, handler: nil)
                alert.addAction(deleteAction)
                alert.addAction(addToDraftAction)
                alert.addAction(continueAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    @IBAction func cancelBtnTapped(_ sender: Any) {
        let alert = Alerts.shared.showAlert(message: "", title: "Are you sure you want to cancel?")
        let deleteAction = UIAlertAction(title: "Delete Note", style: .destructive) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        let addToDraftAction = UIAlertAction(title: "Save as Draft", style: .default) { _ in
            print("add to draft")
        }
        let continueAction = UIAlertAction(title: "Continue writing", style: .default, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(addToDraftAction)
        alert.addAction(continueAction)
        self.present(alert, animated: true, completion: nil)
    }
    func didAddNote(success: Bool, error: String?) {
        if success {
            clearFields()
            let alert = Alerts.shared.showAlert(message: "Note Added Successfully", title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert, completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            let alert = Alerts.shared.showAlert(message: error ?? "error placeholder", title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    private func clearFields() {
        titleTxt.text = ""
        authorTxt.text = ""
        descriptionTxt.text = ""
    }
    private func initAddNoteVC() {
        initSwipeRightGesture()
        self.navigationItem.title = "Add a Note"
        self.navigationItem.hidesBackButton = true
        descriptionTxt.layer.cornerRadius = 5.0
        descriptionTxt.clipsToBounds = true
        titleTxt.becomeFirstResponder()
        self.importanceDropdown.menu = createMenu()
        self.importanceDropdown.showsMenuAsPrimaryAction = true
        self.selectedImgTxt.isHidden = true
        self.selectedFileTxt.isHidden = true
        self.addNoteVM.delegate = self
        self.descriptionTxt.delegate = self
        self.descriptionTxt.isScrollEnabled = false
        let addImageBtn = UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(imgSelector))
        let addFileBtn = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(fileSelector))
        navigationItem.rightBarButtonItems = [addFileBtn, addImageBtn]
        let newBackButton = UIBarButtonItem(title: " Go Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtnTapped))
        self.navigationItem.leftBarButtonItem = newBackButton
        //        let keyboardToolbar = UIToolbar()
//        keyboardToolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
//        keyboardToolbar.barStyle = .default
//        keyboardToolbar.items = [
//            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(hideKey))
//        ]
//        keyboardToolbar.sizeToFit()
//        titleTxt.inputAccessoryView = keyboardToolbar
//        authorTxt.inputAccessoryView = keyboardToolbar
//        descriptionTxt.inputAccessoryView = keyboardToolbar
    }
    @objc private func backBtnTapped() {
        checkForUnsavedChanges()
    }
    @objc private func hideKey() {
        self.view.endEditing(true)    }
    @objc private func imgSelector() {
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.sourceType = .photoLibrary
        imgPickerVC.delegate = self
        imgPickerVC.allowsEditing = true
        imgPickerVC.mediaTypes = ["public.image"]
        present(imgPickerVC, animated: true)
    }
    @objc private func fileSelector() {
        let docPickerVC = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf, .text])
        docPickerVC.delegate = self
        docPickerVC.allowsMultipleSelection = false
        present(docPickerVC, animated: true)
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
