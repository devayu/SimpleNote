//
//  Constants.swift
//  SimpleNote
//
//  Created by Mphrx on 16/11/21.
//

import Foundation
struct Constants {
    static let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
    struct Storyboard {
        static let homeVC = "HomeVC"
        static let loginVC = "LoginVC"
        static let addNoteVC = "AddNoteVC"
        static let signupVC = "SignupVC"
    }
    struct Cells {
        static let formCell = "FormTableCell"
    }
}
