//
//  CustomTableViewCell.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorTxt: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var importanceTxt: UILabel!
    @IBOutlet weak var descTxt: UILabel!
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
