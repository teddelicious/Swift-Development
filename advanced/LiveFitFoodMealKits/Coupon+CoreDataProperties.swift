//
//  Coupon+CoreDataProperties.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Coupon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coupon> {
        return NSFetchRequest<Coupon>(entityName: "Coupon")
    }

    @NSManaged public var applied: Bool
    @NSManaged public var code: String?
    @NSManaged public var date_created: NSDate?
    @NSManaged public var discount: Int64
    @NSManaged public var used_in_order: Order?
    @NSManaged public var owned_by_user: User?

}
