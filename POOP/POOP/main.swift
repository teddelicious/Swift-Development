//
//  main.swift
//  POOP
//
//  Created by John Lin on 2020-03-07.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

let circle: Circle = Circle(radius: 5.0)
let classroom: Classroom = Classroom(name: "467", building: "C")
let classroom2: Classroom = Classroom()

print(classroom.building + " " + classroom.name)
print(classroom2.building + " " + classroom2.name)
