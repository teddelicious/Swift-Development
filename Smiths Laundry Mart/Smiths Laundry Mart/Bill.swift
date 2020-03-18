//
//  Bill.swift
//  Smiths Laundry Mart
//
//  Created by John Lin on 2020-03-05.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Bill {
    let customer: Customer
    let items: [FabricItem]
    
    init(customer: Customer, items: [FabricItem]) {
        self.customer = customer
        self.items = items
    }
}
