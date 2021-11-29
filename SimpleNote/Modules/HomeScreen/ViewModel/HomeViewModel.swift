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
    func didRecieveData(data: [String])
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?)
}
enum ListTypes: Int {
    case notes = 0
    case drafts = 1
}
class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var myNotes = ["test1", "test1", "test1", "test1testesteteteteetetetetetetetetetetettetetetete", "test1", "test1", "test1", "test1", "test1", "test1", "test1", "test1"]
    var myDrafts = ["test2", "test2", "test2"]
    func getData(typeOfList: ListTypes) {
        switch typeOfList {
        case .notes:
            delegate?.didRecieveData(data: myNotes)
        case .drafts:
            delegate?.didRecieveData(data: myDrafts)
        }
    }
    func signOutUser() {
        FirebaseAuthentication.shared.signOutUser { isLogoutSuccess, error in
            self.delegate?.didLogoutUser(isLogoutSuccess: isLogoutSuccess, error: error)
        }
    }
}
