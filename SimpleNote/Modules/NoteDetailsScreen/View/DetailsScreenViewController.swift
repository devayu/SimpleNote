//
//  DetailsScreenViewController.swift
//  SimpleNote
//
//  Created by Mphrx on 28/12/21.
//

import UIKit

class DetailsScreenViewController: UIViewController {
    var note: SingleNote!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var viewContainer: UIView!
    var currentViewController: UIViewController?
    lazy var detailsTabVC: UIViewController = {
        let detailsTabVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.detailsTabVC) as! DetailsTabViewController
        return detailsTabVC
    }()
    lazy var filesTabVC: UIViewController = {
        let filesTabVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.filesTabVC) as! FilesTabViewController
        filesTabVC.note = note
        return filesTabVC
    }()
    enum Tabs: Int {
        case detailsTab = 0
        case filesTab = 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    private func initVC() {
        self.navigationItem.title = note.noteTitle
        segmentedController.selectedSegmentIndex = Tabs.detailsTab.rawValue
        displayViewForCurrentTab(tabIndex: segmentedController.selectedSegmentIndex)
    }
    @IBAction func switchViews(_ sender: UISegmentedControl) {
            self.currentViewController!.view.removeFromSuperview()
            self.currentViewController!.removeFromParent()
            displayViewForCurrentTab(tabIndex: sender.selectedSegmentIndex)
        }
    private func displayViewForCurrentTab(tabIndex: Int) {
        if let vcToDisplay = viewControllerForSelectedTab(tabIndex: tabIndex) {
            self.addChild(vcToDisplay)
            vcToDisplay.didMove(toParent: self)
            vcToDisplay.view.frame = self.viewContainer.bounds
            self.viewContainer.addSubview(vcToDisplay.view)
            self.currentViewController = vcToDisplay
        }
    }
    private func viewControllerForSelectedTab(tabIndex: Int) -> UIViewController? {
        var currentVC: UIViewController?
        switch tabIndex {
        case Tabs.detailsTab.rawValue:
            currentVC = detailsTabVC
        case Tabs.filesTab.rawValue:
            currentVC = filesTabVC
        default:
            return nil
        }
        return currentVC
    }
}
