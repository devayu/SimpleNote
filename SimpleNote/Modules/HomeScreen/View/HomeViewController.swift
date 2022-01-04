//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    func didRecieveDatafromCD(data: [SingleNote], error: Error?) {
        print("Home Vc")
    }
    
    enum TabIndex: Int {
            case firstChildTab = 0
            case secondChildTab = 1
        }
    //var noteList: [NSDictionary] = []
    var myNotesView: UIView!
    var myDraftsView: UIView!
    var myDraftsVC: UIViewController!
    var noteList: [SingleNote] = []
    private var loader: UIAlertController!
    private let refreshControl = UIRefreshControl()
    private var homeVM = HomeViewModel()
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func addNoteBtnTapped(_ sender: Any) {
        NavigationHelper.shared.navigateToScreen(to: AddNoteViewController.self, navigationController: navigationController!, identifier: Constants.Storyboard.addNoteVC, storyboard: storyboard!)
    }
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            addNoteBtn.isHidden = true
        } else {
            addNoteBtn.isHidden = false
        }
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    var currentViewController: UIViewController?
        lazy var firstChildTabVC: UIViewController? = {
            let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DraftsViewController") as? DraftsViewController
            firstChildTabVC?.segmentIndex = 0
            return firstChildTabVC
        }()
        lazy var secondChildTabVC: UIViewController? = {
            let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DraftsViewController") as? DraftsViewController
            secondChildTabVC?.segmentIndex = 1
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
        homeVM.delegate = self
        segmentedController.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutUser))
        self.navigationItem.rightBarButtonItem = logOutButton
        // initHomeVC()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FirebaseCRUD.shared.reachedEndOfDocument = false
        if FirebaseCRUD.shared.didAddNewNote {
            noteList.removeAll()
            //fetchDataForTable()
            FirebaseCRUD.shared.didAddNewNote = false
        }
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
    private func initHomeVC() {
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        homeVM.delegate = self
        FirebaseCRUD.shared.getAllDocumentsSnapshot()
        //fetchDataForTable()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        //segementedControllerHandler()
        navigationController?.navigationBar.prefersLargeTitles = true
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutUser))
        self.navigationItem.rightBarButtonItem = logOutButton
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addNoteBtn.frame.size.height, right: 0)
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
    }
    @objc private func pullToRefresh() {
        noteList.removeAll()
        //fetchDataForTable()
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
    @IBAction func signoutBtnTapped(_ sender: Any) {
        homeVM.signOutUser()
    }
//    private func fetchDataForTable() {
//        loader = Alerts.shared.showAlertWithSpinner(message: "", title: "Fetching Data")
//        self.present(loader, animated: true, completion: nil)
//        homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!, fetchMoreData: false)
//    }
//    private func segementedControllerHandler() {
//        segmentedController.addTarget(self, action: #selector(changeTableDataSource), for: .valueChanged)
//    }
//    @objc func changeTableDataSource() {
//        noteList.removeAll()
//        homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!, fetchMoreData: false)
//    }
    private func updateTableUI() {
        DispatchQueue.main.async {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func didRecieveData(data: [SingleNote], error: Error?) {
//        if error == nil && !data.isEmpty {
//            noteList.append(contentsOf: data)
//            updateTableUI()
//        } else {
//            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
//            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "error placeholder", title: "")
//            Alerts.shared.dismissAlert(alert: alert, completion: nil)
//        }
        
    }
    let notesRepo = NotesRepository()
    
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?) {
        if isLogoutSuccess {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginVC, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
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
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.y
//        if position > (tableView.contentSize.height - 200 - scrollView.frame.size.height) {
//            guard !FirebaseCRUD.shared.isDataPaginating else {
//                return
//            }
//            guard !FirebaseCRUD.shared.reachedEndOfDocument else {
//                DispatchQueue.main.async {
//                    self.tableView.tableFooterView = nil
//                }
//                return
//            }
//            self.tableView.tableFooterView = tableViewFooterSpinner()
//            homeVM.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex) ?? .notes, fetchMoreData: true)
//        }
//    }
}
