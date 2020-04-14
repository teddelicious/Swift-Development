//
//  ViewController.swift
//  CoffeeShopApp
//
//  Created by John Lin on 2020-04-07.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var labelMilkCount: UILabel!
    @IBOutlet weak var labelSugarCount: UILabel!
    @IBOutlet weak var stepMilk: UIStepper!
    @IBOutlet weak var stepSugar: UIStepper!
    @IBOutlet weak var switchUseReward: UISwitch!
    @IBOutlet weak var textOrderSummary: UITextView!
    @IBOutlet weak var scPresets: UISegmentedControl!
    @IBOutlet weak var scSize: UISegmentedControl!
    @IBOutlet weak var labelSummaryTitle: UILabel!
    
    //MARK: VARIABLES
    let sizeLabel: [String] = ["Small", "Medium", "Large"]
    let cost: [Double] = [1.67, 1.89, 2.10]
    let taxRate: Double = 0.13
    var size: Int = 0
    
    //MARK: FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set default values
        setDefaultValues()
    }
    
    //sets default values
    func setDefaultValues() {
        size = 0
        stepMilk.value = 0
        stepSugar.value = 0
        labelMilkCount.text = stepMilk.value.description
        labelSugarCount.text = stepMilk.value.description
        labelSummaryTitle.isHidden = true
        textOrderSummary.text = ""
        switchUseReward.setOn(false, animated: false)
        scPresets.selectedSegmentIndex = UISegmentedControl.noSegment
        scSize.selectedSegmentIndex = 0
    }
    
    func calculateTax(amount: Double) -> Double{
        return round(amount * self.taxRate * 100) / 100
    }
    
    func getOrderSummary() -> String {
        let subtotal = cost[size]
        let tax = calculateTax(amount: subtotal)
        let usingRewards = switchUseReward.isOn ? "Yes" : "No"
        let total = switchUseReward.isOn ? "$0.00" : "$\(String(format: "%.2f", subtotal + tax))"
        return "Milk: \(stepMilk.value), Sugar: \(stepSugar.value)\nSize: \(sizeLabel[size])\nSubtotal: $\(String(format: "%.2f", subtotal))\nTax: $\(String(format: "%.2f", tax))\nReward Applied: \(usingRewards)\nTotal: \(total)"
    }
    
    //MARK: ACTIONS
    @IBAction func onMilkChange(_ sender: Any) {
        //remove preset selection during manual adjustment
        scPresets.selectedSegmentIndex = UISegmentedControl.noSegment
        labelMilkCount.text = stepMilk.value.description
    }
    @IBAction func onSugarChange(_ sender: Any) {
        //remove preset selection during manual adjustment
        scPresets.selectedSegmentIndex = UISegmentedControl.noSegment
        labelSugarCount.text = stepSugar.value.description
    }
    
    @IBAction func onPlaceOrderPressed(_ sender: Any) {
        //place order
        labelSummaryTitle.isHidden = false
        textOrderSummary.text = getOrderSummary()
    }
    
    @IBAction func onCancelOrderPressed(_ sender: Any) {
        //cancel order
        setDefaultValues()
    }
    
    @IBAction func onSelectPreset(_ sender: Any) {
        print(scPresets.selectedSegmentIndex.description)
        //preset sets the values
        switch scPresets.selectedSegmentIndex {
        case 0:
            stepMilk.setValue(0, forKey: "value")
            stepSugar.setValue(0, forKey: "value")
        case 1:
            stepMilk.setValue(1, forKey: "value")
            stepSugar.setValue(1, forKey: "value")
        case 2:
            stepMilk.setValue(2, forKey: "value")
            stepSugar.setValue(2, forKey: "value")
        default:
            return
        }
        //set label
        labelMilkCount.text = stepMilk.value.description
        labelSugarCount.text = stepSugar.value.description
        
    }
    
    @IBAction func onSelectSize(_ sender: Any) {
        //size selected could change
        switch scSize.selectedSegmentIndex {
        case 0:
            size = 0
        case 1:
            size = 1
        case 2:
            size = 2
        default:
            return
        }
    }
    
    
    
}

