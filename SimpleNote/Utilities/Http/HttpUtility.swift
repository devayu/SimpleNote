//
//  HttpUtility.swift
//  SimpleNote
//
//  Created by Mphrx on 01/12/21.
//

import Foundation
import UIKit
class HttpUtility {
    static let shared = HttpUtility()
    func downloadDataFromUrl(url: URL, completion: @escaping (Result<Data,Error>)->Void){
        let task = URLSession.shared.dataTask(with: url) { data, urlRes, error in
            guard let resData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(resData))
        }
        task.resume()
    }
}
