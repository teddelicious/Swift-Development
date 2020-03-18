//
//  HourlyWorker.swift
//  ABC Manufacturing Ltd
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class HourlyWorker: Worker {
    var rate: Double
    var hours: Double
    let maximumHours: Double = 120.0
    
    init(id: String, firstName: String, lastName: String, rate: Double, hours: Double) {
        self.rate = rate
        self.hours = hours
        super.init(id: id, firstName: firstName, lastName: lastName)
    }
    
    override func getMonthlySalary() -> Double {
        if (self.hours > self.maximumHours) {
            return self.rate * 1.5 * (self.hours - self.maximumHours) + rate * self.maximumHours
        }
        
        return self.rate * self.hours
    }
    
    override func toString() -> String {
        return super.toString() + "\n Hourly worker\n Rate: \(round(self.rate * 100) / 100)\n Hours Worked: \(round(self.hours * 100) / 100)"
    }
}
