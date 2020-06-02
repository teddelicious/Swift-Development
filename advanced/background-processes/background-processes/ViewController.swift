//
//  ViewController.swift
//  background-processes
//
//  Created by John Lin on 2020-05-19.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var switchItem: UISwitch!
    
    //MARK: variable
    let NUMBER = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: functions
    @IBAction func onClickButton(_ sender: Any) {
        print("start counting")

        DispatchQueue.global().async {
            for i in 1...self.NUMBER {
                print(i)
                //shouldn't be called in background
//                self.labelCount.text = String(i)
            }
        }
//        print("final count: \(self.count)")
    }
    
    @IBAction func onChangeSwitch(_ sender: UISwitch) {
        if (sender.isOn == false) {
            labelResult.text = "Hello"
        }else {
            labelResult.text = "Goodbye"
        }
    }
    
    
}

