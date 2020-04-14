//
//  ViewController.swift
//  PickerViewsExample
//
//  Created by Parrot on 2020-03-27.
//  Copyright © 2020 Parrot. All rights reserved.
//

// CHECKLIST: Did you remember to:
// - Create an outlet for your PickerView
// - Make a data souce?
// - Add PickerView protocols to the class?
// - Setup the protocols in the viewDidLoad()?
// - Add mandatory PickerView functions?
//      - numcomponents
//      - pickerView(numRowsInComponent)
//      - pickerView(titleForRow)
// - Customize functions to use your data source?

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let Countries = ["USA", "China", "Iran", "Germany", "Italy", "France", "Canada", "Spain"]
    
    //num columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //num rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Countries.count
    }
    
    // what to show in pickerview
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Countries[row]
    }
    

    // MARK: Outlets
    // put outlets here
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    // MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
    }
    
    // MARK: Actions
    // put your actions here
    
    @IBAction func buttonPressed(_ sender: Any) {
        let selectedIndex = countryPickerView.selectedRow(inComponent: 0)
        self.resultsLabel.text = Countries[selectedIndex]
    }
}

