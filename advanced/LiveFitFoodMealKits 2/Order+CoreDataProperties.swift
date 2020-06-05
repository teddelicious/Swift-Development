//
//  Order+CoreDataProperties.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var date_created: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var tip: Double
    @NSManaged public var total: Double
    @NSManaged public var coupon_applied: Coupon?
    @NSManaged public var has_order_item: NSSet?
    @NSManaged public var ordered_by: User?

}

// MARK: Generated accessors for has_order_item
extension Order {

    @objc(addHas_order_itemObject:)
    @NSManaged public func addToHas_order_item(_ value: OrderItem)

    @objc(removeHas_order_itemObject:)
    @NSManaged public func removeFromHas_order_item(_ value: OrderItem)

    @objc(addHas_order_item:)
    @NSManaged public func addToHas_order_item(_ values: NSSet)

    @objc(removeHas_order_item:)
    @NSManaged public func removeFromHas_order_item(_ values: NSSet)

}
