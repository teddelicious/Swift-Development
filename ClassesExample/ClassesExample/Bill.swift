//
//  Bill.swift
//  ClassesExample
//
//  Created by John Lin on 2020-03-04.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Bill {
    var customer: Customer
    var products: [String: (qty: Int, product: Product)]
    
    init(customer: Customer) {
        self.customer = customer
        self.products = [:]
    }
    
    func addProduct(product: Product, qty: Int) {
        self.products[product.itemCode] = (qty, product)
    }
    
    func addProducts(products: [(product: Product, qty: Int)]) {
        for (product, qty) in products {
            self.products[product.itemCode] = (qty, product)
        }
        
    }
    
    func printBill() {
        print(customer.getFullName() + "\n")
        var total = 0.00
        
        for entry in products {
            let product = entry.1.product
            let qty = entry.1.qty
            
            print(product.getProductDetail())
            let extendedPrice = product.price * Double(qty)
            total += extendedPrice
            print("extendedPrice: \(extendedPrice) \n")
        }
        print("Total: \(round(total * 100) / 100)")
    }

}
