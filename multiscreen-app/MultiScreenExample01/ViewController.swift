//
//  ViewController.swift
//  MultiScreenExample01
//
//  Created by Parrot on 2020-03-31.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

// MULTISCREEN APP CHECKLIST:
// If you are passing data between screens:
// 1. Do you have 1 Viewcontroller.swift file per storyboard?
// 2. Do your sender screens have a prepare() function?
// 3. Do your receiving screens have variables to receive the data?


class ViewController: UIViewController {

    @IBOutlet weak var tfUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let page2 = segue.destination as! SecondPageController
        page2.username = tfUsername.text == nil ? "" : tfUsername.text!
    }


}

