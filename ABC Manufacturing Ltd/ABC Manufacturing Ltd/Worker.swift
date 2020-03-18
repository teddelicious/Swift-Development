//
//  Worker.swift
//  ABC Manufacturing Ltd
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Worker {
    var id: String
    var firstName: String
    var lastName: String
    let taxFreeAllowance: Double = 1000.00
    
    init(id: String, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func getMonthlySalary() -> Double {
        return 0.0
    }
    
    func getIncomeSummary() -> String {
        let gross = round(getMonthlySalary() * 100) / 100
        let deduction = round(calcDeduction(income: gross) * 100) / 100
        return "Gross Income: \(gross)\n Deduction: \(deduction)\n Net Pay: \(gross - deduction)\n\n"
    }
    
    func calcDeduction(income: Double) -> Double{
        if (income > self.taxFreeAllowance) {
            return round((income - self.taxFreeAllowance) * 0.15 * 100) / 100
        }
        return 0.00
    }
    
    func toString() -> String {
        return "Employee \(self.id): \(self.firstName) \(self.lastName)"
    }
    
}
