//
//  Shape.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Shape {
    var color: String?
    
    init(color: String?) {
        self.color = color
    }
    
    func calculateArea() -> Double {
        return 0.0
    }
    
    public var description: String {
        return "Shape: \(calculateArea())"
    }
}
