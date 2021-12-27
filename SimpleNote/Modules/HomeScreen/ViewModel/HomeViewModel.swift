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

let notesRepository = NotesRepository()

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
    func getData(typeOfList: ListTypes, fetchMoreData: Bool) {
        switch typeOfList {
        case .notes:
            FirebaseCRUD.shared.readNotesFromFirebase(fetchMoreData: fetchMoreData) { notes, error in
                self.delegate?.didRecieveData(data: notes, error: error)
                print(notes)
            }
        case .drafts:
//            notesRepository.getAll() {NotesDict in
//                //self.delegate?.didRecieveData(data: NotesDict, error: nil)
//            }
            //Use this for inspecting the Core Data
            print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
            print("On drafts page ")
            
        }
    }
    func signOutUser() {
        FirebaseAuthentication.shared.signOutUser { isLogoutSuccess, error in
            self.delegate?.didLogoutUser(isLogoutSuccess: isLogoutSuccess, error: error)
        }
    }
}
