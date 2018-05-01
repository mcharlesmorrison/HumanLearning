//
//  User+CoreDataProperties.swift
//  
//
//  Created by Morrison on 4/29/18.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var readArticles: NSObject?
    @NSManaged public var savedArticles: NSObject?

}
