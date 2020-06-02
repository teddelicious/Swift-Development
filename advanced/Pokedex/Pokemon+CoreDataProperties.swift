//
//  Pokemon+CoreDataProperties.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var baseExpPoints: Int64
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var type: String?
    @NSManaged public var battles: Battle?

}
