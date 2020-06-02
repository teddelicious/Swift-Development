//
//  Screen2ControllerViewController.swift
//  EmployeeUserDefaults
//
//  Created by parrot on 2020-05-20.
//  Copyright © 2020 peacock. All rights reserved.
//

import UIKit

class Screen2ControllerViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var resultsLabel: UILabel!
    
    // MARK: Variables
    var defaults:UserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. get user defaults
        self.defaults = UserDefaults.standard
        
        // 2. pull data from user defaults
        
        // if personName key exists, return it. Otherwise, return nil
        let name = defaults.string(forKey:"personName")
        if (name == nil) {
            print("No name found")
        }
    
        // if age key exists, return value. Otherwise, return nil
        let age = defaults.integer(forKey:"personAge")
        
        // if pet key exists, return value. Otherwise return false.
        let hasPet = defaults.bool(forKey:"pet")
        
        
        resultsLabel.text = "\(name) is \(age) years old. Has Pet? \(hasPet)"
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
