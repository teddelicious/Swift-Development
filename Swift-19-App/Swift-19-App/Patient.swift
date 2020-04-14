//
//  Patient.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-11.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

//referenced off of stackoverflow
extension Date {
    var age: Int {
        //years between current & self
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}

struct Patient: Comparable {
    var name: String
    var dob: Date
    var recentlyTraveled: Bool
    
    init(name: String, dob: Date, recentlyTraveled: Bool) {
        self.name = name
        self.dob = dob
        self.recentlyTraveled = recentlyTraveled
    }
    
    func getAge() -> Int{
        return self.dob.age
    }
    
    static func <(lhs: Patient, rhs: Patient) -> Bool {
        return lhs.name < rhs.name
    }
}
