//
//  Notes+CoreDataProperties.swift
//  SimpleNote
//
//  Created by Mphrx. on 24/12/21.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var noteAuthor: String?
    @NSManaged public var noteDate: Date?
    @NSManaged public var noteDesc: String?
    @NSManaged public var noteId: String?
    @NSManaged public var noteImportance: String?
    @NSManaged public var noteTitle: String?

}

extension Notes : Identifiable {

}
