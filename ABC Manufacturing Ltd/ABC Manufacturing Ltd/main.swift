//
//  main.swift
//  ABC Manufacturing Ltd
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

let fixedWorker: FixedWorker = FixedWorker(id: "0001", firstName: "jon", lastName: "snow", monthlySalary: 3000.00)
let comissionWorker: ComissionWorker = ComissionWorker(id: "0002", firstName: "arya", lastName: "stark", fixedSalary: 1500.00, totalSale: 39999.50)
let hourlyWorker: HourlyWorker = HourlyWorker(id: "0003", firstName: "ghost", lastName: "dire wolf", rate: 15.0, hours: 200.0)

let workers: [Worker] = [fixedWorker, comissionWorker, hourlyWorker]

print("Given the list of following employees: ")
var bestWorker: Worker? = nil
var worstWorker: Worker? = nil
for (index, worker) in workers.enumerated() {
    print("worker \(index+1):\n \(worker.toString())\n \(worker.getIncomeSummary())")
    if bestWorker == nil || worker.getMonthlySalary() > bestWorker!.getMonthlySalary() {
        bestWorker = worker
    }
    
    if worstWorker == nil || worker.getMonthlySalary() < worstWorker!.getMonthlySalary() {
        worstWorker = worker
    }
}

print("\(bestWorker!.firstName + " " + bestWorker!.lastName) has the highest income with a net salary of \(round(bestWorker!.getMonthlySalary() - bestWorker!.calcDeduction(income: bestWorker!.getMonthlySalary() * 100) / 100))")

print("\(worstWorker!.firstName + " " + worstWorker!.lastName) has the lowest income with a net salary of \(round(worstWorker!.getMonthlySalary() - worstWorker!.calcDeduction(income: worstWorker!.getMonthlySalary() * 100) / 100))")


