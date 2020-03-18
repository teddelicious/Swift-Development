//
//  Circle.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Circle: Shape {
    
    var radius: Double
    
    init(radius: Double, color: String?) {
        self.radius = radius
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return Double.pi * self.radius * self.radius
    }
    
    public override var description: String {
        return "Circle(\(self.radius)): \(calculateArea())"
    }
}
