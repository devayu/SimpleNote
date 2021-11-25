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
            self.navigateToScreen(to: HomeViewController.self, identifier: Constants.Storyboard.homeViewController, storyboard: storyboard!)
        } else {
            self.navigateToScreen(to: LoginViewController.self, identifier: Constants.Storyboard.loginViewController, storyboard: storyboard!)
        }
    }
    func navigateToScreen<T: UIViewController>(to screen: T.Type, identifier: String, storyboard: UIStoryboard) {
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
