//
//  LaunchScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 25/11/21.
//

import UIKit
import Firebase

class LaunchScreenViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserExists()
    }
    private func checkIfUserExists() {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            NavigationHelper.shared.navigateToCleanStack(to: HomeViewController.self, identifier: Constants.Storyboard.homeViewController, storyboard: storyboard!)
        } else {
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginViewController, storyboard: storyboard!)
        }
    }
}
