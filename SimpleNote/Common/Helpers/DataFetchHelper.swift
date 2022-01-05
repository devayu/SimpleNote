//
//  PaginationHelper.swift
//  SimpleNote
//
//  Created by Mphrx. on 03/01/22.
//

import Foundation

class DataFetchHelper {
    static let shared = DataFetchHelper()
    var isPaginating: Bool = false
    var reachedEndOfDocument: Bool = false
    
    func getData(typeOfList: ListTypes, fetchMoreData: Bool, offsetSize: Int, limitSize: Int, completion: @escaping ([SingleNote], Error?) -> Void) {
        switch typeOfList {
        case .notes:
            FirebaseCRUD.shared.readNotesFromFirebase(limitSize: limitSize, fetchMoreData: fetchMoreData) { notes, error in
                guard error==nil else{
                    completion([], error)
                    return
                }
                completion(notes, nil)
            }
            
        case .drafts:
            NotesRepository.shared.getDataFromCD(offsetInt: offsetSize, limitSize: limitSize, fetchMore: fetchMoreData) { noteToBeAppended in
                completion(noteToBeAppended, nil)
            
           }
        }
    }
}
