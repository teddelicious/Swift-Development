//
//  Classroom.swift
//  POOP
//
//  Created by John Lin on 2020-03-07.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Classroom: AreaProtocol {
    var name: String
    var building: String
    
    convenience init() {
        self.init(name: "223", building: "D")
    }
    
    init(name: String, building: String) {
        self.name = name
        self.building = building
    }
    
    func getArea() -> Double {
        return 0.00
    }
}
