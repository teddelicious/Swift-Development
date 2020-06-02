//
//  User+CoreDataProperties.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var date_created: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var phone_number: String?
    @NSManaged public var photo: NSData?

}
