//
//  DraftsViewController.swift
//  SimpleNote
//
//  Created by Mphrx. on 29/12/21.
//

import UIKit

class DraftsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var loader: UIAlertController!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    var noteList: [SingleNote] = []
    var notesDict: [SingleNote] = []
    private var homeVM = HomeViewModel()
    let addNoteVM = AddNoteViewModel()
    var segmentIndex: Int = 0
    @IBAction func addNoteBtnTapped(_ sender: Any) {
        NavigationHelper.shared.navigateToScreen(to: AddNoteViewController.self, navigationController: navigationController!, identifier: Constants.Storyboard.addNoteVC, storyboard: storyboard!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableData()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDataForTable()
        FirebaseCRUD.shared.reachedEndOfDocument = false
        if FirebaseCRUD.shared.didAddNewNote {
            noteList.removeAll()
            fetchDataForTable()
            FirebaseCRUD.shared.didAddNewNote = false
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        notesDict.removeAll()
        DataFetchHelper.shared.isPaginating = false
        DataFetchHelper.shared.reachedEndOfDocument = false
        self.tableView.tableFooterView = nil
    }
    @objc private func pullToRefresh() {
        noteList.removeAll()
        fetchDataForTable()
    }
    private func fetchDataForTable() {
        loader = Alerts.shared.showAlertWithSpinner(message: "", title: "Fetching Data")
        self.present(loader, animated: true, completion: nil)
        homeVM.getData(typeOfList: ListTypes(rawValue: segmentIndex)!, fetchMoreData: false, offsetSize: notesDict.count, limitSize: 5)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesDict.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if segmentIndex == 0{
//            notesDict.removeAll()
//            notesDict = noteList
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.titleTxt.text = notesDict[indexPath.row].noteTitle
        cell.authorTxt.text = notesDict[indexPath.row].noteAuthor
        let noteDate = notesDict[indexPath.row].noteDate
        //cell.dateTxt.text = noteDate.formatted(date: .abbreviated, time: .shortened)
        cell.importanceTxt.text = notesDict[indexPath.row].noteImportance
        cell.descTxt.text = (notesDict[indexPath.row].noteDescription)
        return cell
    }
    func loadTableData() {
        FirebaseCRUD.shared.getAllDocumentsSnapshot()
        NotesRepository.shared.getNumberOfData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        navigationController?.navigationBar.prefersLargeTitles = true
        homeVM.delegate = self
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutUser))
        if segmentIndex == 0{
            addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        }
        self.navigationItem.rightBarButtonItem = logOutButton
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addNoteBtn.frame.size.height, right: 0)
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
        
        
//        if segmentIndex == 1 {
////            notesRepository.getAll() { notesDict2 in
////
////                self.notesDict = notesDict2
////                self.tableView.reloadData()
////            }
//            print("On drafts")
//        }
//        if segmentIndex == 0 {
//            FirebaseCRUD.shared.getAllDocumentsSnapshot()
//            fetchDataForTable()
//        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
            {
                if segmentIndex == 1 {
                    let deleteAction = UIContextualAction(style: .destructive, title: "Save Note") { (action, view, completionHandler) in
                        print("Upload data at row \(indexPath.row)")
                        if NetworkMonitor.shared.isConnected == true {
                            let noteToBeAdded = self.addNoteVM.singleNotetoAddNoteModel(noteConvert: self.notesDict[indexPath.row])
                            self.addNoteVM.addNote(addRequest: noteToBeAdded)
                            let deleteMessage = self.homeVM.deleteEntryFromCD(noteId: self.notesDict[indexPath.row].noteId)
                                let alert = Alerts.shared.showAlert(message: "Note Uploaded ", title: "")
                                self.present(alert, animated: true, completion: nil)
                                Alerts.shared.dismissAlert(alert: alert, completion: nil)
                            tableView.beginUpdates()
                            self.notesDict.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.endUpdates()
                        } else {
                            print("Error in uploading note ")
                            let alert = Alerts.shared.showAlert(message: "Error in uploading note, no internet available", title: "")
                            self.present(alert, animated: true, completion: nil)
                            Alerts.shared.dismissAlert(alert: alert, completion: nil)
                        }
                        completionHandler(true)
                    }
                    deleteAction.backgroundColor = .systemTeal
                    let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                    return configuration
                }
                else {
                    return nil
                }
            }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                if segmentIndex == 1 {
                let deleteMessage = homeVM.deleteEntryFromCD(noteId: notesDict[indexPath.row].noteId)
                    let alert = Alerts.shared.showAlert(message: deleteMessage, title: "")
                    self.present(alert, animated: true, completion: nil)
                    Alerts.shared.dismissAlert(alert: alert, completion: nil)
                }
                if segmentIndex == 0 {
                    //delete from firebase
                }
                tableView.beginUpdates()
                notesDict.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                print("Deleted")
            }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentIndex == 0 {
            let note = noteList[indexPath.row]
            let detailsVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.detailsVC) as? DetailsScreenViewController
            detailsVC?.note = note
            navigationController?.pushViewController(detailsVC!, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if segmentIndex == 1 {
            let addNoteVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNoteVC") as? AddNoteViewController
            addNoteVC?.titleData = notesDict[indexPath.row].noteTitle
            addNoteVC?.descData = notesDict[indexPath.row].noteDescription
            addNoteVC?.authorData = notesDict[indexPath.row].noteAuthor
            navigationController?.pushViewController(addNoteVC!, animated: true)
        }
    }
    @objc private func logOutUser() {
        let alert = Alerts.shared.showAlert(message: "Are you sure you want to log out?", title: "Log out")
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.homeVM.signOutUser()
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?) {
        if isLogoutSuccess {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginVC, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    func didRecieveDatafromCD(data: [SingleNote], error: Error?) {
        if error == nil {
           // notesDict.removeAll()
            print(data, "appendeddata")
            notesDict.append(contentsOf: data)
            //noteList.append(data[0])
            updateTableUI()
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "error placeholder", title: "")
            self.present(alert, animated: true, completion: nil)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    func didRecieveData(data: [SingleNote], error: Error?) {
        if error == nil && !data.isEmpty {
            notesDict.append(contentsOf: data)
            print(data, "delegate")
            //notesDict = noteList
            updateTableUI()
        } else {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "error placeholder", title: "")
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    private func tableViewFooterSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.center = footerView.center
        spinner.startAnimating()
        footerView.addSubview(spinner)
        return footerView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 200 - scrollView.frame.size.height) {
            guard !DataFetchHelper.shared.isPaginating else {
                return
            }
            guard !DataFetchHelper.shared.reachedEndOfDocument else {
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                return
            }
//            guard !FirebaseCRUD.shared.isDataPaginating else {
//                return
//            }
//            guard !FirebaseCRUD.shared.reachedEndOfDocument else {
//                DispatchQueue.main.async {
//                    self.tableView.tableFooterView = nil
//                }
//                return
//            }
            print("Paginating")
            self.tableView.tableFooterView = tableViewFooterSpinner()
            homeVM.getData(typeOfList: ListTypes(rawValue: segmentIndex) ?? .notes, fetchMoreData: true, offsetSize: notesDict.count, limitSize: 5)
        }
    }
    private func updateTableUI() {
        DispatchQueue.main.async {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
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
