//
//  HomeVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 24/11/21.
//

import Foundation
import UIKit
extension HomeViewController:  UITableViewDelegate, UITableViewDataSource {
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
