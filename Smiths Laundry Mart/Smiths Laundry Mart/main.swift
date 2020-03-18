//
//  main.swift
//  Smiths Laundry Mart
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

print("Hello, World!")

let customer: Customer = Customer(firstName: "john", lastName: "lin")
let fabricItem1: FabricItem = FabricItem(type: "Cotton", weight: 10.0)
let fabricItem2: FabricItem = FabricItem(type: "Wool", weight: 5.0)
let fabricItem3: FabricItem = FabricItem(type: "Denim", weight: 15.0)

let bill: Bill = Bill(customer: customer, items: [fabricItem1, fabricItem2, fabricItem3])


