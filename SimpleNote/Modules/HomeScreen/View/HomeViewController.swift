//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    var dataPoints: [NSDictionary] = []
    private let homeViewModel = HomeViewModel()
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
        print("did appear")
        setupTable()
    }
    private func initHomeVC() {
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        segementedControllerHandler()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: addNoteBtn.frame.size.height, right: 0)
    }
    @IBAction func signoutBtnTapped(_ sender: Any) {
        homeViewModel.signOutUser()
    }
    private func setupTable() {
        homeViewModel.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!)
    }
    private func segementedControllerHandler() {
        segmentedController.addTarget(self, action: #selector(changeTableDataSource), for: .valueChanged)
    }
    @objc func changeTableDataSource() {
        homeViewModel.getData(typeOfList: ListTypes(rawValue: segmentedController.selectedSegmentIndex)!)
    }
    func didRecieveData(data: NSArray) {
        if  data.count > 0 {
            dataPoints = data as! [NSDictionary]
            tableView.reloadData()
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
}
