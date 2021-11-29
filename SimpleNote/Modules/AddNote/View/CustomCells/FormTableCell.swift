//
//  FormTableCell.swift
//  SimpleNote
//
//  Created by Mphrx on 29/11/21.
//

import UIKit

class FormTableCell: UITableViewCell {

    @IBOutlet weak var formLabel: CustomTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
