//
//  HomeViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit
protocol HomeViewModelDelegate: AnyObject {
    func didRecieveData(data: NSArray)
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?)
}
enum ListTypes: Int {
    case notes = 0
    case drafts = 1
}
class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
//    var myNotes = ["test1", "test1", "test1", "test1testesteteteteetetetetetetetetetetettetetetete", "test1", "test1", "test1", "test1", "test1", "test1", "test1", "test1"]
    var myDrafts = ["test2", "test2", "test2"]
    func getData(typeOfList: ListTypes) {
        switch typeOfList {
        case .notes:
            FirebaseCRUD.shared.readData { notes, error in
                guard error == nil else {
                    self.delegate?.didRecieveData(data: notes)
                    return
                }
                self.delegate?.didRecieveData(data: notes)
            }
        case .drafts:
            delegate?.didRecieveData(data: myDrafts as NSArray)
        }
    }
    func signOutUser() {
        FirebaseAuthentication.shared.signOutUser { isLogoutSuccess, error in
            self.delegate?.didLogoutUser(isLogoutSuccess: isLogoutSuccess, error: error)
        }
    }
}
