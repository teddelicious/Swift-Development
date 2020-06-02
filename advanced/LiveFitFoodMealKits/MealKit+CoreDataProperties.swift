//
//  MealKit+CoreDataProperties.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension MealKit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MealKit> {
        return NSFetchRequest<MealKit>(entityName: "MealKit")
    }

    @NSManaged public var calorie_count: Int64
    @NSManaged public var date_created: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var image_path: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var sku: String?
    @NSManaged public var ordered_in: NSSet?

}

// MARK: Generated accessors for ordered_in
extension MealKit {

    @objc(addOrdered_inObject:)
    @NSManaged public func addToOrdered_in(_ value: OrderItem)

    @objc(removeOrdered_inObject:)
    @NSManaged public func removeFromOrdered_in(_ value: OrderItem)

    @objc(addOrdered_in:)
    @NSManaged public func addToOrdered_in(_ values: NSSet)

    @objc(removeOrdered_in:)
    @NSManaged public func removeFromOrdered_in(_ values: NSSet)

}
