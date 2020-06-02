//
//  Battle+CoreDataProperties.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//
//

import Foundation
import CoreData


extension Battle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Battle> {
        return NSFetchRequest<Battle>(entityName: "Battle")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var winningPokemon: Pokemon?

}
