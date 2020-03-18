//
//  main.swift
//  ClassesExample
//
//  Created by John Lin on 2020-03-04.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation
//
//class Student{
//    var firstName: String
//    var middleName: String?
//    var lastName: String
//
//    init(firstName: String, middleName: String?, lastName: String) {
//        self.firstName = firstName
//        self.middleName = middleName
//        self.lastName = lastName
//    }
//
//    func getFullName() -> String {
//        var fullName: String = ""
//        fullName += self.firstName
//        if let x = self.middleName {
//            fullName += " \(x)"
//        }
//        fullName += " \(self.lastName)"
//        return fullName
//    }
//}
//
//let s1 = Student(firstName: "john", middleName: nil, lastName: "lin")
//print(s1.getFullName())
//
//let customer: Customer = Customer(firstName: "john", lastName: "lin", middleName: nil)
//var bill: Bill = Bill(customer: customer)
//let product1 = Product(itemCode: "001", description: "Chips", price: 1.99)
//let product2 = Product(itemCode: "002", description: "Cookies", price: 0.99)
//let product3 = Product(itemCode: "003", description: "Bread", price: 2.99)
//
//bill.addProduct(product: product1, qty: 1)
//bill.addProduct(product: product2, qty: 1)
//bill.addProduct(product: product3, qty: 1)
//
//bill.printBill()

func getCustomer() -> Customer {
    var customerSteps: Int = 0
    var input: String?
    var firstName: String = ""
    var lastName: String = ""
    var middleName: String?
    while customerSteps < 3 {
        switch customerSteps {
        case 0:
            print("please enter first name: ")
            input = readLine()
            if let x = input {
                firstName = x
                customerSteps += 1
            }
        case 1:
            print("please enter middle name: ")
            middleName = readLine()
            customerSteps += 1
        case 2:
            print("please enter last name: ")
            input = readLine()
            if let x = input {
                lastName = x
                customerSteps += 1
            }
        default:
            print("Something went wrong, please try again.")
        }
    }
    
    return Customer(firstName: firstName, lastName: lastName, middleName: middleName)
}

func getProductsList(count: Int) -> [(Product, Int)] {
    var i: Int = 0
    var productStep: Int = 0
    
    var input: String?
    
    var itemCode: String = ""
    var description: String = ""
    var price: Double = 0.00
    var qty: Int = 0
    
    var products: [(Product, Int)] = []
    while (i < count) {
        switch productStep {
        case 0:
            print("enter the item code: ")
            input = readLine()
            if let x = input {
                itemCode = x
                productStep += 1
            }
        case 1:
            print("enter the item description: ")
            input = readLine()
            if let x = input {
                description = x
                productStep += 1
            }
        case 2:
            print("enter the item price: ")
            input = readLine()
            if let x = input {
                if let y = Double(x) {
                    price = y
                    productStep += 1
                }
            }
        case 3:
            print("enter the item qty: ")
            input = readLine()
            if let x = input {
                if let y = Int(x) {
                    qty = y
                    productStep += 1
                }
            }
        default:
            let product: Product = Product(itemCode: itemCode, description: description, price: price)
            products.append((product, qty))
            i += 1
            productStep = 0
        }
    }
    
    return products
}


let customer: Customer
let bill: Bill

customer = getCustomer()
bill = Bill(customer: customer)
while true {
    print("please enter the number of items to add to bill: ")
    let val = readLine()
    if let x = val {
        if let count = Int(x) {
            bill.addProducts(products: getProductsList(count: count))
            break
        }
    }
}

bill.printBill()
