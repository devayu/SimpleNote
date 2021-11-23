//
//  FieldTableViewCell.swift
//  tableViewTest
//
//  Created by Mphrx. on 18/11/21.
//

import UIKit

class FieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FieldTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "FieldTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var field: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        field.delegate = self
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print(textField.text ?? "")
//        return true
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
