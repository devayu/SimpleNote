//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    var noteList: [NSDictionary] = []
    private var homeVM = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func addNoteBtnTapped(_ sender: Any) {
        let addNoteVC = (storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.addNoteVC) as? AddNoteViewController)!
        self.navigationController?.pushViewController(addNoteVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initHomeVC()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FirebaseCRUD.shared.reachedEndOfDocument = false
        noteList.removeAll()
        setupTable()
    }
    private func initHomeVC() {
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        tableView.delegate = self
        tableView.dataSource = self
        homeVM.delegate = self
        FirebaseCRUD.shared.getAllDocumentsSnapshot()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        segementedControllerHandler()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addNoteBtn.frame.size.height, right: 0)
        self.tableView.layer.cornerRadius = 10
        self.tableView.layer.masksToBounds = true
    }
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
