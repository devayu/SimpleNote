//
//  HomeViewModel.swift
//  SimpleNote
//
//  Created by Mphrx on 23/11/21.
//

import Foundation
import Firebase
protocol HomeViewModelDelegate: AnyObject {
    func didRecieveData(data: [String])
    func didLogoutUser(isLogoutSuccess: Bool, error: Error?)
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var dummyDataSource = ["test1", "test1", "test1"]
    var dummyDataSource2 = ["test2", "test2", "test2"]
    func getData(for index: Int) {
        delegate?.didRecieveData(data: dummyDataSource)
    }
    func signOutUser() {
        FirebaseAuthentication.shared.signOutUser { isLogoutSuccess, error in
            switch isLogoutSuccess {
            case true:
                self.delegate?.didLogoutUser(isLogoutSuccess: true, error: nil)
            case false:
                self.delegate?.didLogoutUser(isLogoutSuccess: false, error: error)
            }
        }
    }
}
