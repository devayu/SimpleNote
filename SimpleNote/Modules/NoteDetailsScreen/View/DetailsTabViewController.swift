//
//  DetailsTabViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 29/12/21.
//

import UIKit

class DetailsTabViewController: UIViewController {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var importanceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var note: SingleNote!
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    
    private func initVC() {
        if let noteDetails = note {
            authorLabel.text = noteDetails.noteAuthor
            dateLabel.text = noteDetails.noteDate.dateValue().formatted(date: .abbreviated, time: .shortened)
            importanceLabel.text = noteDetails.noteImportance
            descriptionLabel.text = noteDetails.noteDescription
            descriptionLabel.numberOfLines = 0
        }
    }

}
