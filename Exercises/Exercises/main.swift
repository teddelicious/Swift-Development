//
//  main.swift
//  Exercises
//
//  Created by John Lin on 2020-03-03.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

func priceAfterTax(amount: Double) -> Double {
    return round(amount * 1.13 * 100) / 100
}

//print(priceAfterTax(amount: 5.00))


let cities: [String] = ["Toronto", "Barcelona", "Santiago"]
//print(cities)

var nums: [Int] = []
for i in 0...20{
    if i % 2 == 0 {
        nums.append(i)
    }
}
//print(nums)


func sum(arr: [Int]) {
    var result = 0
    for i in arr {
        result += i
    }
    print(result)
}

let x = [7, 10, -1, 5]
//sum(arr: x)

func calculator(x: Int, y:Int) -> (sum: Int, difference: Int, product: Int, quotient: Int) {
    return (x + y, x - y, x * y, x / y)
}

let result = calculator(x: 10, y: 5)
//print(result)

func job(hours: Int, rate: Double) -> (status: String, salary: Double) {
    var result: (String, Double)
    if (hours < 20) {
        result.0 = "Part time status"
    }else{
        result.0 = "Full time status"
    }
    
    result.1 = round(rate * Double(hours) * 0.85 * 100) / 100
    return result
}

//print(job(hours: 15, rate: 10))

func createCourses(course: String, semester: String) -> [String: String] {
    return ["course": course, "term": semester]
}

//print(createCourses(course: "android fundamentals", semester: "spring"))


var emptyDict: [String: [String]] = [:]

func isPerfect(num: Int) -> Bool {
    var total = num
    for i in 1..<num {
        if num % i == 0 {
            total -= i
        }
    }
    return total == 0
}
print("isPerfect of 6 is: \(isPerfect(num: 6))")
print("isPerfect of 24 is: \(isPerfect(num: 24))")
