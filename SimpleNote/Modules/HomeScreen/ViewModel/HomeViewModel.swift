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
}

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var dummyDataSource = ["test1", "test1", "test1"]
    var dummyDataSource2 = ["test2", "test2", "test2"]
    func getData(for index: Int) {
        delegate?.didRecieveData(data: dummyDataSource)
        
        //        if index == 0 {
        //            delegate?.didRecieveData(data: dummyDataSource)
        //        } else {
        //            delegate?.didRecieveData(data: dummyDataSource2)
        //        }
    }
}
