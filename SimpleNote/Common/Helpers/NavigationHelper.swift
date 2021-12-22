//
//  NavigationHelper.swift
//  SimpleNote
//
//  Created by Mphrx on 26/11/21.
//

import Foundation
import UIKit
class NavigationHelper {
    static let shared = NavigationHelper()
    func navigateToCleanStack<T: UIViewController>(to screen: T.Type, identifier: String, storyboard: UIStoryboard) {
        let viewController = (storyboard.instantiateViewController(withIdentifier: identifier) as? T)!
        let navigationController = UINavigationController(rootViewController: viewController)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
