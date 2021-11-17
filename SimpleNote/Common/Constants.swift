//
//  Constants.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
class Constants {
    
    static let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    
    static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
}
