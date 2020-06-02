//
//  Employee.swift
//  employeeSQLite
//
//  Created by Kadeem Best on 2020-05-20.
//  Copyright © 2020 ios. All rights reserved.
//

import Foundation


class Employee
{
    
    var firstName:String
    var lastName:String
    var email:String
    
    init()
    {
        self.firstName=""
        self.lastName=""
        self.email=""
    }
    init(firstName:String, lastName:String, email:String)
    {
        self.firstName=firstName;
        self.lastName=lastName;
        self.email=email;
        
    }
    
    
}
