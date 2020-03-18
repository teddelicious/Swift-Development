//
//  main.swift
//  inheritanceExample
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

let square: Square = Square(side: 6.0, color: "Blue")
let rectangle: Rectangle = Rectangle(length: 6.0, width: 5.0, color: "Yellow")
let triangle: Triangle = Triangle(base: 3.0, height: 5.0, color: nil)
let circle: Circle = Circle(radius: 5.5, color: nil)
let shapes: [Shape] = [square, rectangle, triangle, circle]

for (index, shape) in shapes.enumerated() {
    print("Item \(index + 1): \(shape.description)")
}

//as? casts the variable to ClassName
//if let x = variable as? ClassName <=> variable instanceof ClassName

//while true {
//    print("Enter input code: \n1. Triangle \n2. Square \n3. Rectangle \n4. Exit")
//    let input: String? = readLine()
//    if let code = input {
//        if let inputCode = Int(code) {
//            switch inputCode {
//            case 1:
//                print("")
//                // triangle
//            case 2:
//                print("")
//                // square
//            case 3:
//                print("")
//                // rectangle
//            case 4:
//                print("")
//                // circle
//            case 5:
//                break
//            default:
//                print("invalid code, please try again")
//            }
//        }
//    }
//}
