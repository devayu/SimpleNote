//
//  ViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    @IBAction func didTapSignUp(){
        let su = storyboard?.instantiateViewController(withIdentifier: "signup_vc") as! SignUpViewController
        
        print("Tapped button")
        navigationController?.pushViewController(su, animated: true)
        
    }

}




