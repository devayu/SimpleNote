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
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        if !isViewExpanded {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let bStackMaximumY = bottomStackView.frame.maxY
            let keyboardFrameMinimumY = keyboardFrame.cgRectValue.minY
            let keyboardHeight = keyboardFrame.cgRectValue.height
            if bStackMaximumY > keyboardFrameMinimumY {
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
