//
//  ViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 12/11/21.
//

import UIKit
import Firebase
class LoginViewController: UIViewController, LoginViewModelDelegate {
    // Outlets
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passTextField: CustomTextField!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    var isViewExpanded: Bool = false
    private let loginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoginVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Login"
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        navigationController?.navigationBar.isHidden = false
    }
    private func initLoginVC() {
        loginViewModel.delegate = self
        passTextField.enablePasswordToggle()
        setupKeyboardObservers()
        passTextField.addBottomBorder()
        emailTextField.addBottomBorder()
    }
    @IBAction func signInBtnTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let request = LoginRequest(email: email, password: password)
        let validationRes = loginViewModel.validateLoginFields(for: request)
        if !validationRes.success {
            switch validationRes.forField {
            case .email:
                self.emailTextField.setError(errorMessage: validationRes.error!)
            case .password:
                self.passTextField.setError(errorMessage: validationRes.error!)
            case .none:
                break
            }
        } else {
            emailTextField.resignFirstResponder()
            passTextField.resignFirstResponder()
            loginViewModel.loginUser(request: request)
        }
    }
    func didRecieveUser(user: User?, error: Error?) {
        if user != nil {
            NavigationHelper.shared.navigateToCleanStack(to: HomeViewController.self, identifier: Constants.Storyboard.homeVC, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error!.localizedDescription, title: "")
            self.present(alert, animated: true)
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
    @IBAction func didTapSignUp() {
        NavigationHelper.shared.navigateToScreen(to: SignUpTableViewController.self, navigationController: navigationController!, identifier: Constants.Storyboard.signupVC, storyboard: storyboard!)
        }
}
