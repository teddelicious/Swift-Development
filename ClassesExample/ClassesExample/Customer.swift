//
//  Customer.swift
//  ClassesExample
//
//  Created by John Lin on 2020-03-04.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Customer {
    var firstName: String
    var lastName: String
    var middleName: String?
    
    init(firstName: String, lastName: String, middleName: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.middleName = middleName
    }
    
    func getFullName() -> String {
        var fullName: String = ""
        fullName += self.firstName
        if let x = self.middleName {
            fullName += " \(x)"
        }
        fullName += " \(self.lastName)"
        return fullName
    }
    
}
