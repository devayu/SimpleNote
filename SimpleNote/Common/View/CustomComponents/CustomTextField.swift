//
//  CustomTextField.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import UIKit

class CustomTextField: UITextField {
    private let borderBottom = CALayer()
    private let errorLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBottomBorder()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addBottomBorder()
    }
    func addBottomBorder() {
        let width = CGFloat(1.0)
        borderBottom.borderColor = UIColor.lightGray.cgColor
        borderBottom.frame = CGRect(x: 0, y: self.frame.size.height - width,
                                    width: self.frame.size.width, height: self.frame.size.height)
        borderBottom.borderWidth = width
        self.borderStyle = .none
        self.layer.addSublayer(borderBottom)
        self.layer.masksToBounds = true
    }
    func setError(errorMessage: String) {
        errorLabel.text = errorMessage
        errorLabel.textColor = UIColor.red
        errorLabel.numberOfLines = 0
        errorLabel.font = UIFont.systemFont(ofSize: 12)
        errorLabel.frame = CGRect(x: self.frame.minX, y: self.frame.maxY,
                                  width: self.frame.width, height: self.frame.height/2)
        errorLabel.sizeToFit()
        errorLabel.isHidden = false
        self.superview?.addSubview(errorLabel)
        self.becomeFirstResponder()
        clearError()
    }
    func clearError() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.errorLabel.text = ""
            self.errorLabel.isHidden = true
        }
    }

}
