//
//  ViewController.swift
//  EmployeeUserDefaults
//
//  Created by parrot on 2020-05-20.
//  Copyright © 2020 peacock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var switchPet: UISwitch!
    @IBOutlet weak var resultsTextView: UITextView!
    
    // MARK: Variables
    var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 1. Initialize the userdefaults
        self.defaults = UserDefaults.standard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    @IBAction func saveButtonPressed(_ sender: Any) {
        // 2. Get values from storyboard
        let name:String = txtName.text!
        let age:Int = Int(txtAge.text!) ?? 0        // if textbox is empty, make the age 0
        
        var hasPet = false;
        if (switchPet.isOn == true) {
            hasPet = true
        }
        else {
            hasPet = false
        }
        
        // 3. Save the values to userdefaults
        self.defaults.set(name, forKey: "personName")
        self.defaults.set(age, forKey: "personAge")
        self.defaults.set(hasPet, forKey: "petExists")

        print("Data saved to user defaults!")
    }
    
    @IBAction func loadButtonPressed(_ sender: Any) {
        // 4. get data from user defaults
        
        // get name
        let name = self.defaults.string(forKey: "personName")
        // get the age
        let age = self.defaults.integer(forKey: "personAge")
        // get the pet status
        let pet = self.defaults.bool(forKey: "petExists")
        
        // 5. output the data to the textview
        resultsTextView.text = """
            Name: \(name) \n
            Age:\(age) \n
            Has a Pet? \(pet) \n
        """
        
        
    }
    
}

