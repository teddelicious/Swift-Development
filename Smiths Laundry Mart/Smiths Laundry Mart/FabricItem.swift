//
//  FabricItem.swift
//  Smiths Laundry Mart
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class FabricItem {
    let type: String
    let weight: Double
    let costPerLB: [String: Double] = ["Cotton": 1.00, "Denim": 2.75, "Other": 0.65 ]
    
    init (type: String, weight: Double) {
        self.type = type
        self.weight = weight
    }
    
    func getWashCost() -> (unit: Double, total: Double) {
        let val = self.costPerLB[self.type]
        let unit: Double
        if (val == nil){
            unit = costPerLB["Other"]!
        }else{
            unit = val!
        }
        
        return (unit, unit * self.weight)
    }
    
    func getDryerCost() -> (unit: Double, total: Double) {
        if (self.weight < 7) {
            return (2.50, 2.50 * self.weight)
        }else if (self.weight >= 7 && self.weight < 12) {
            return (1.50, 1.50 * self.weight)
        }else{
            return (0.55, 0.55 * self.weight)
        }
    }
}
