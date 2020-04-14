//
//  main.swift
//  who wants to be a millionaire
//
//  Created by John Lin on 2020-03-06.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

print("Welcome to Who wants to be a Millionaire!")
print("Please enter your name: ")
var input: String? = nil
var name: String? = nil
var difficulty: Int? = nil
while true {
    input = readLine()
    if let x = input {
        if (x != ""){
            name = x
            break
        } else {
            print("please enter a valid name!")
        }
    }else {
        print("please enter a valid name!")
    }
}

print("Please choose a difficulty: ")
print("(E)asy or (H)ard")
while difficulty == nil {
    input = readLine()
    if let x = input {
        switch (x.uppercased()) {
        case "E":
            difficulty = 0
            break
        case "H":
            difficulty = 1
            break
        default:
            print("Please choose a valid difficulty")
        }
    }
}

let game = Game(difficulty: difficulty!, name: name!)
game.start()
