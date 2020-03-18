//
//  Square.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Square: Rectangle {
    
    init(side: Double, color: String?) {
        super.init(length: side, width: side, color: color)
    }
 
    public override var description: String {
        return "Square[\(super.length)]: \(calculateArea())"
    }
    
}
