//
//  HomeScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, HomeViewModelDelegate {
    func didRecieveDatafromCD(data: [SingleNote], error: Error?) {
        print("Home Vc")
    }
    
    enum TabIndex: Int {
            case firstChildTab = 0
            case secondChildTab = 1
        }
    var myNotesView: UIView!
    var myDraftsView: UIView!
    var myDraftsVC: UIViewController!
    var noteList: [SingleNote] = []
    private var loader: UIAlertController!
    private let refreshControl = UIRefreshControl()
    private var homeVM = HomeViewModel()
    @IBOutlet var viewContainer: UIView!
    @IBOutlet weak var addNoteBtn: FloatingActionUIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func addNoteBtnTapped(_ sender: Any) {
        NavigationHelper.shared.navigateToScreen(to: AddNoteViewController.self, navigationController: navigationController!, identifier: Constants.Storyboard.addNoteVC, storyboard: storyboard!)
    }
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            addNoteBtn.isHidden = true
        } else {
            addNoteBtn.isHidden = false
        }
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    var currentViewController: UIViewController?
        lazy var firstChildTabVC: UIViewController? = {
            let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DraftsViewController") as? DraftsViewController
            firstChildTabVC?.segmentIndex = 0
            return firstChildTabVC
        }()
        lazy var secondChildTabVC: UIViewController? = {
            let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DraftsViewController") as? DraftsViewController
            secondChildTabVC?.segmentIndex = 1
            return secondChildTabVC
        }()
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
            var vc: UIViewController?
            switch index {
            case TabIndex.firstChildTab.rawValue :
                vc = firstChildTabVC
            case TabIndex.secondChildTab.rawValue :
                vc = secondChildTabVC
            default:
            return nil
            }
        
            return vc
        }
    func displayCurrentTab(_ tabIndex: Int) {
            if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
                self.addChild(vc)
                vc.didMove(toParent: self)
                vc.view.frame = self.viewContainer.bounds
                self.viewContainer.addSubview(vc.view)
                self.currentViewController = vc
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVM.delegate = self
        segmentedController.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutUser))
        self.navigationItem.rightBarButtonItem = logOutButton
        // initHomeVC()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    private func initHomeVC() {
        addNoteBtn.createFloatingActionButton(color: .systemBlue, imageToSet: nil)
        homeVM.delegate = self
        FirebaseCRUD.shared.getAllDocumentsSnapshot()
        navigationController?.navigationBar.prefersLargeTitles = true
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutUser))
        self.navigationItem.rightBarButtonItem = logOutButton
    }
    @objc private func logOutUser() {
        let alert = Alerts.shared.showAlert(message: "Are you sure you want to log out?", title: "Log out")
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            self.homeVM.signOutUser()
        }
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func signoutBtnTapped(_ sender: Any) {
        homeVM.signOutUser()
    }
    func didRecieveData(data: [SingleNote], error: Error?) {
        print("delegate pattern")
    }
    let notesRepo = NotesRepository()
    
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?) {
        if isLogoutSuccess {
            Alerts.shared.dismissAnyLoadingAlertsIfPresent()
            NavigationHelper.shared.navigateToCleanStack(to: LoginViewController.self, identifier: Constants.Storyboard.loginVC, storyboard: storyboard!)
        } else {
            let alert = Alerts.shared.showAlert(message: error?.localizedDescription ?? "", title: "")
            Alerts.shared.dismissAlert(alert: alert, completion: nil)
        }
    }
}
