//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    
    enum TabIndex : Int {
            case firstChildTab = 0
            case secondChildTab = 1
        }
    
    var noteList: [NSDictionary] = []
    var myNotesView: UIView!
    var myDraftsView: UIView!
    var myDraftsVC: UIViewController!
    private var homeVM = HomeViewModel()
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func addNoteBtnTapped(_ sender: Any) {
        let addNoteVC = (storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.addNoteVC) as? AddNoteViewController)!
        self.navigationController?.pushViewController(addNoteVC, animated: true)
    }
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()

        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    var currentViewController: UIViewController?
        lazy var firstChildTabVC: UIViewController? = {
            let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
            return firstChildTabVC
        }()
        lazy var secondChildTabVC: UIViewController? = {
            let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DraftsViewController")
            return secondChildTabVC
        }()
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
            var vc: UIViewController?
            switch index {
            case TabIndex.firstChildTab.rawValue :
                vc = firstChildTabVC
            case TabIndex.secondChildTab.rawValue :
                vc = secondChildTabVC
            default:
            return nil
            }
        
            return vc
        }
    func displayCurrentTab(_ tabIndex: Int) {
            if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
                self.addChild(vc)
                vc.didMove(toParent: self)
                vc.view.frame = self.viewContainer.bounds
                self.viewContainer.addSubview(vc.view)
                self.currentViewController = vc
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedController.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        // initHomeVC()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FirebaseCRUD.shared.reachedEndOfDocument = false
        noteList.removeAll()
        setupTable()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
//    private func initHomeVC() {
//        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
//        tableView.delegate = self
//        tableView.dataSource = self
//        homeVM.delegate = self
//        FirebaseCRUD.shared.getAllDocumentsSnapshot()
//        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
//        segementedControllerHandler()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addNoteBtn.frame.size.height, right: 0)
//        self.tableView.layer.cornerRadius = 10
//        self.tableView.layer.masksToBounds = true
//    }
    @IBAction func signoutBtnTapped(_ sender: Any) {
        homeVM.signOutUser()
    }
    private func setupTable() {
        homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!, fetchMoreData: false)
    }
    private func segementedControllerHandler() {
        segmentedController.addTarget(self, action: #selector(changeTableDataSource), for: .valueChanged)
    }
    @objc func changeTableDataSource() {
        noteList.removeAll()
        homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!, fetchMoreData: false)
    }
    func didRecieveData(data: [NSDictionary], error: Error?) {
        if error == nil {
            noteList.append(contentsOf: data)
            tableView.reloadData()
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "error placeholder", title: "")
            self.present(alert, animated: true, completion: nil)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    
    let notesRepo = NotesRepository()
    
    func didRecieveDatafromCD(data: [AddNoteModel], error: Error?) {
        if error == nil {
            //noteList.append(data[0])
            tableView.reloadData()
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "error placeholder", title: "")
            self.present(alert, animated: true, completion: nil)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?) {
        if isLogoutSuccess {
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginVC, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 200 - scrollView.frame.size.height) {
            guard !FirebaseCRUD.shared.isDataPaginating && !FirebaseCRUD.shared.reachedEndOfDocument else {
                return
            }
            print("paginating")
            homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex) ?? .notes, fetchMoreData: true)
        }
    }
}
