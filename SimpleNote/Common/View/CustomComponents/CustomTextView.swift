//
//  CustomTextView.swift
//  SimpleNote
//
//  Created by Mphrx on 01/12/21.
//

import Foundation
import UIKit
class CustomTextView: UITextView, UITextViewDelegate {
    private let errorLabel = UILabel()
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 0.25
        self.layer.borderColor = UIColor.gray.cgColor
    }
    func setError(errorMessage: String) {
        errorLabel.text = errorMessage
        errorLabel.textColor = UIColor.red
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.frame = CGRect(x: self.frame.minX, y: self.frame.maxY,
                                  width: self.frame.width, height: self.frame.height)
        errorLabel.sizeToFit()
        errorLabel.isHidden = false
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2.0
        self.superview?.addSubview(errorLabel)
        self.becomeFirstResponder()
        clearError()
    }
    func clearError() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 0.20
        }
    }
}
