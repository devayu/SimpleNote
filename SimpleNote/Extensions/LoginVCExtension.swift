//
//  LoginVCExtension.swift
//  SimpleNote
//
//  Created by Mphrx on 22/11/21.
//

import Foundation
import UIKit
extension LoginViewController {
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        let screenSize = UIScreen.main.bounds.height
        let scrollSize = loginScrollView.contentSize.height
        if !isViewExpanded {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if screenSize < scrollSize {
                self.view.frame.origin.y -= keyboardHeight
            } else {
                self.view.frame.origin.y -= signupBtn.frame.height
            }
            isViewExpanded = true
        }
        } else {
            return
        }
    }
    @objc private func keyboardWillHide() {
        self.view.frame.origin.y = 0
        isViewExpanded = false
    }
}
