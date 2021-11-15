//
//  Alerts.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation
import UIKit

class Alerts : UIAlertController {
    
    static let shared = Alerts()
    
    func showAlert(message: String, title: String?)-> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alert
    }
    func dismissAlert(alert: UIAlertController){
        alert.dismiss(animated: true, completion: nil)
    }
}
