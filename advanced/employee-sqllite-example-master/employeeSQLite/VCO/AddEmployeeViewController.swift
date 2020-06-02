//
//  ViewController.swift
//  employeeSQLite
//
//  Created by Kadeem Best on 2020-05-20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var db = DAO();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func saveEmployee(_ sender: Any)
    {
        
        db.addEmployee(employee: Employee(firstName: txtFirstName.text!, lastName: txtLastName.text!, email: txtEmail.text!));
        print("Employee Added");
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.destination is EmployeeDisplayViewController
        {
            let edvc = segue.destination as? EmployeeDisplayViewController;
            
            edvc?.employee = Employee(firstName: txtFirstName.text!, lastName: txtLastName.text!, email: txtEmail.text!);
            
            print("Segue generated");
            
            
        }
    }

}

