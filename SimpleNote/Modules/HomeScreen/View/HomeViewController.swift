//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeViewModelDelegate {
    var user: User?
    var dataPoints: [String] = []
    private let homeViewModel = HomeViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentedControllerIndex = segmentedController.selectedSegmentIndex
        setupTable(index: segmentedControllerIndex)
        print(user?.metadata.lastSignInDate)
        tableView.delegate = self
        tableView.dataSource = self
        homeViewModel.delegate = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    private func setupTable(index: Int) {
        homeViewModel.getData(for: index)
    }
    func didRecieveData(data: [String]) {
        dataPoints = data
        tableView.reloadData()
//        if !data.isEmpty {
//            dataPoints = data
//            tableView.reloadData()
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataPoints.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = dataPoints[indexPath.row]
        return cell
    }
}
