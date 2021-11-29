//
//  CustomTableViewCell.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorLabelTxt: UILabel!
    @IBOutlet weak var dateLabelTxt: UILabel!
    @IBOutlet weak var importanceLabelTxt: UILabel!
    @IBOutlet weak var descLabelTxt: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
