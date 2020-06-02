//
//  Entity+CoreDataProperties.swift
//  testingCoreData
//
//  Created by John Lin on 2020-05-21.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?

}
