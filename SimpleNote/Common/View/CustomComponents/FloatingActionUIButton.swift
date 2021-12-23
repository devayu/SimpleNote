//
//  FloatingActionUIButton.swift
//  SimpleNote
//
//  Created by Mphrx on 25/11/21.
//

import UIKit

class FloatingActionUIButton: UIButton {
    override func draw(_ rect: CGRect) {
    }
    func createFloatingActionButton(color: UIColor, imageToSet: UIImage?) {
        self.layer.cornerRadius = frame.height / 2
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        if imageToSet == nil {
            let defaultImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration.init(pointSize: 18, weight: .regular))
            self.setImage(defaultImage, for: .normal)
        } else {
            self.setImage(imageToSet, for: .normal)
        }
        self.tintColor = .white
        self.setTitleColor(.white, for: .normal)
        self.layer.backgroundColor = color.cgColor
    }
}
