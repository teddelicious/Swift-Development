//
//  Rectangle.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Rectangle: Shape {
    
    var length: Double
    var width: Double
    
    init(length: Double, width: Double, color: String?) {
        self.length = length
        self.width = width
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return self.length * self.width
    }
    
    public override var description: String {
        return "Rectangle[\(self.length), \(self.width)]: \(calculateArea())"
    }
}
