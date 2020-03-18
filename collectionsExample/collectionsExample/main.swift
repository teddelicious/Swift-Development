//
//  main.swift
//  collectionsExample
//
//  Created by John Lin on 2020-02-22.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

var grades = [55, 100, 23, 99, 85]

func printGrades(grades:Array<Int>) -> Void {
    for i in grades.indices {
        print("Student \(i+1)'s grade: \(grades[i])")
    }
}
grades.append(90)
grades.append(66)
grades.append(33)
grades += [22,44,66,88,100]
grades.remove(at: 0)
grades.remove(at: 2)
grades.removeLast()
//var empty: Array<Int> = Array<Int>()
//var empty2 = [Int]()
//empty.insert(0, at: 1)
//empty2.insert(0, at: 1)
//printGrades(grades: grades)
grades.insert(0, at: 33)
grades.insert(newElement: 0, at: 55)

var products = [String:Double]()

products["iphone"] = 1500.99
products["moto g"] = 400
products["video game"] = 80

//for (k,v) in products {
//    print("key: \(k), value: \(v)")
//}

var s1 = [String:Any]()
var s2 = [String:Any]()
var s3 = [String:Any]()

s1["name"] = "jon"
s1["age"] = 20
s1["email"] = "jon@gbc.ca"

s2["name"] = "sara"
s2["age"] = 21
s2["email"] = "sara@gbc.ca"

s3["name"] = "dan"
s3["age"] = 23
s3["email"] = "dan@gbc.ca"

var array = [[String:Any]]()

array.append(s1)
array.append(s2)
array.append(s3)

//print(array)

func printNames(names:[String]) {
    for name in names {
        print(name)
    }
}

//printNames(names: ["jon", "sara", "james", "dan"])

func weird() -> (id:Int, name:String, salary:Double) {
    return (1, "jon", 2999.99)
}

//let result = weird()
//print("id: \(result.id), name: \(result.name), salary: \(result.salary)")


func sum(of x: Int, and y: Int) -> Int {
    return x + y
}
print(sum(of: 5, and: 10))
