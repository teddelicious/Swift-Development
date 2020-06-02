//
//  EmployeeDisplayViewController.swift
//  employeeSQLite
//
//  Created by Kadeem Best on 2020-05-20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit;

class EmployeeDisplayViewController: UIViewController {
    
    

    @IBOutlet weak var lblName: UILabel!
    
    var employee:Employee = Employee();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = "Welcome \(employee.firstName) \(employee.lastName)"
    }
    

}
