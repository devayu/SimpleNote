//
//  Alerts.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation
import UIKit

class Alerts: UIAlertController {
    static let shared = Alerts()
    private var overlay = UIView()
    func showAlert(message: String, title: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    func showAlertWithSpinner(message: String, title: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        alert.view.addSubview(indicator	)
        return alert
    }
    func showOverlay(view: UIView) -> UIView {
        overlay.frame = view.frame
        overlay.center = view.center
        overlay.backgroundColor = .black
        overlay.alpha = 0.5
        return overlay
    }
    func hideOverlay() {
        self.overlay.removeFromSuperview()
    }
    func dismissAlert(alert: UIAlertController, completion: (() -> Void)?) {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            alert.dismiss(animated: true, completion: completion)
        }
    }
}
