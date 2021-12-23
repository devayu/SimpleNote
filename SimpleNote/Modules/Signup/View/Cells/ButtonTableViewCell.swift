//
//  ButtonTableViewCell.swift
//  tableViewTest
//
//  Created by Mphrx. on 18/11/21.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var svc = SignUpTableViewController()
    
    static let identifier = "ButtonTableViewCell"
    @IBOutlet var button: UIButton!
    
    var onButtonTapped: (() -> Void)?
    
    @IBAction func signUpTap(_ sender: Any) {
        self.onButtonTapped?()
        //svc.signUpTap2()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ButtonTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
