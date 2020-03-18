//
//  Customer.swift
//  Smiths Laundry Mart
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Customer {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func printGreetings() {
        print("Hello \(firstName) \(lastName)")
    }
}
