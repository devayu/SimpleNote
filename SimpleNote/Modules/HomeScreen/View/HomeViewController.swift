//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    var dataPoints: [String] = []
    private let homeViewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    @IBAction func signoutBtnTapped(_ sender: Any) {
        homeViewModel.signOutUser()
    }
    private func setupTable(index: Int) {
        homeViewModel.getData(for: index)
    }

    private func segementedControllerHandler() {
        segmentedController.addTarget(self, action: #selector(changeTableDataSource), for: .valueChanged)
    }
    @objc func changeTableDataSource() {
    }
    func didRecieveData(data: [String]) {
        dataPoints = data
        tableView.reloadData()
//        if !data.isEmpty {
//            dataPoints = data
//            tableView.reloadData()
//        }
    }
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?) {
        if isLogoutSuccess {
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginViewController, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert)
        }
    }
}
