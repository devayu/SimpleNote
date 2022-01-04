//
//  ImageViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 30/12/21.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var image: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    private func initVC() {
        self.navigationItem.largeTitleDisplayMode = .never
        DispatchQueue.main.async {
            self.imgView.image = self.image
            self.imgView.contentMode = .scaleAspectFill

        }
    }
}
