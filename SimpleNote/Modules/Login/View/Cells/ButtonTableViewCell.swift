//
//  ButtonTableViewCell.swift
//  tableViewTest
//
//  Created by Mphrx. on 18/11/21.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    var svc = ViewController()
    
    static let identifier = "ButtonTableViewCell"
    @IBOutlet var button: UIButton!
    
    @IBAction func signUpTap(_ sender: Any) {
        
        svc.signUpTap2()
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
