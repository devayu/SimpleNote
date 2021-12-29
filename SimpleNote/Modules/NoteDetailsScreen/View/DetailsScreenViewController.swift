//
//  DetailsScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 28/12/21.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    var note: SingleNote!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("details page")
        initVC()
    }
    private func initVC() {
        self.navigationItem.title = note.noteTitle
    }

}
