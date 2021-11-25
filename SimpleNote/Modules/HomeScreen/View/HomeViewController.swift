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
    private let launchVC = LaunchScreenViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        addNoteBtn.createFloatingActionButton(color: .systemBlue)
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

//    private func segementedControllerHandler (){
//        segmentedController.addTarget(self, action: #selector(<#T##@objc method#>), for:.valueChanged)
//    }
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
            transitionToLoginScreen()
            launchVC.navigateToScreen(to: LoginViewController.self, identifier: Constants.Storyboard.loginViewController, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert)
        }
    }
    private func transitionToLoginScreen() {
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}
