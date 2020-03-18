//
//  Triangle.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Triangle: Shape {
    
    var base: Double
    var height: Double
    
    init(base: Double, height: Double, color: String?) {
        self.base = base
        self.height = height
        super.init(color: color)
    }
    
    override func calculateArea() -> Double {
        return self.base * self.height * 0.5
    }
    
    public override var description: String {
        return "Triangle[\(self.base)/\(self.height)]: \(calculateArea())"
    }
}
