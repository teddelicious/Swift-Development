//
//  main.swift
//  OptionalsExample
//
//  Created by John Lin on 2020-03-02.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Person{
    var name: String?
    var age: Int?
}

let person = Person()
person.name = "john"
person.age = 20

print(person.name! + " " + String(person.age!))
if let x = person.name {
    print("nil")
}
