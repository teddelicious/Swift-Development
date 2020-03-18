//
//  ComissionWorker.swift
//  ABC Manufacturing Ltd
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class ComissionWorker: Worker {
    var fixedSalary: Double
    var totalSale: Double
    
    init(id: String, firstName: String, lastName: String, fixedSalary: Double, totalSale: Double) {
        self.fixedSalary = fixedSalary
        self.totalSale = totalSale
        super.init(id: id, firstName: firstName, lastName: lastName)
    }
    
    override func getMonthlySalary() -> Double {
        return self.fixedSalary + totalSale * 0.05
    }
    
    override func toString() -> String {
        return super.toString() + "\n Comission worker\n Fixed salary: \(round(self.fixedSalary * 100) / 100)\n Total Sale: \(round(self.totalSale * 100) / 100) at 5%"
    }
}
