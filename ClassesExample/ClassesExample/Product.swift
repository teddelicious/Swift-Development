//
//  Product.swift
//  ClassesExample
//
//  Created by John Lin on 2020-03-04.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Product {
    var itemCode: String
    var description: String
    var price: Double
    
    init(itemCode: String, description: String, price: Double) {
        self.itemCode = itemCode
        self.description = description
        self.price = price
    }
    
    func getProductDetail() -> String {
        return "itemCode: \(self.itemCode)\ndescription: \(self.description)\nprice: \(self.price)"
    }
}
