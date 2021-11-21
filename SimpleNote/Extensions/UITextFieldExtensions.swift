//
//  UITextFieldExtensions.swift
//  SimpleNote
//
//  Created by Mphrx on 15/11/21.
//

import Foundation
import UIKit

extension UITextField {
    fileprivate func setPasswordToggleBtnImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(named: "ic_hide_password"), for: .normal)
        } else {
            button.setImage(UIImage(named: "ic_show_password"), for: .normal)
        }
    }
    func enablePasswordToggle() {
        var config = UIButton.Configuration.plain()
        config.imagePadding = CGFloat(1)
        let button = UIButton(configuration: config, primaryAction: nil)
        setPasswordToggleBtnImage(button)
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .whileEditing
    }
    @IBAction func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        let existingTintColor = self.tintColor
        self.tintColor = .clear
        if let existingText = self.text, self.isSecureTextEntry {
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        DispatchQueue.main.async {
            self.tintColor = existingTintColor
        }
        setPasswordToggleBtnImage(sender)
    }
}
