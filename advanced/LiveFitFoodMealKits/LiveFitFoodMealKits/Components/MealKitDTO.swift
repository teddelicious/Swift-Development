//
//  MealKitDTO.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

struct MealKitDTO: Codable {
    var sku: String?
    var name: String?
    var desc: String?
    var price: Double
    var calorie_count: Int
    var image_path: String?
}
