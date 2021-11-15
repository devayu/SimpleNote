//
//  UIVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
