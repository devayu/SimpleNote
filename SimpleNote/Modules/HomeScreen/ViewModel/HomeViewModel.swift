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
    func didRecieveData(data: [NSDictionary], error: Error?)
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?)
}
enum ListTypes: Int {
    case notes = 0
    case drafts = 1
}
class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var isDataPaginating: Bool = false
    func getData(typeOfList: ListTypes, paginateData: Bool) {
        isDataPaginating = paginateData
        switch typeOfList {
        case .notes:
            FirebaseCRUD.shared.readNotesFromFirebase(paginateData: paginateData) { notes, error in
                self.delegate?.didRecieveData(data: notes, error: error)
            }
        case .drafts:
            FirebaseCRUD.shared.readNotesFromFirebase(paginateData: paginateData) { notes, error in
                self.delegate?.didRecieveData(data: notes, error: error)
            }
        }
    }
    func signOutUser() {
        FirebaseAuthentication.shared.signOutUser { isLogoutSuccess, error in
            self.delegate?.didLogoutUser(isLogoutSuccess: isLogoutSuccess, error: error)
        }
    }
}
