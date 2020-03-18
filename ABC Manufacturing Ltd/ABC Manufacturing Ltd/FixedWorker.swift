//
//  FixedWorker.swift
//  ABC Manufacturing Ltd
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class FixedWorker: Worker {
    var monthlySalary: Double
    
    init(id: String, firstName: String, lastName: String, monthlySalary: Double) {
        self.monthlySalary = monthlySalary
        super.init(id: id, firstName: firstName, lastName: lastName)
    }
    
    override func getMonthlySalary() -> Double {
        return self.monthlySalary
    }
    
    override func toString() -> String {
        return super.toString() + "\n Fixed monthly worker\n Monthly salary: \(round(self.monthlySalary * 100) / 100)"
    }
}
