//
//  User+CoreDataProperties.swift
//  practiceCoreDataExercise
//
//  Created by John Lin on 2020-05-21.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

}
