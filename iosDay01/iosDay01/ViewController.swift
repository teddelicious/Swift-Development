//
//  ViewController.swift
//  iosDay01
//
//  Created by John Lin on 2020-03-23.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var labelGreeting: UILabel!
    
    
    //MARK: Default function
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: Actions
    @IBAction func buttonClick(_ sender: Any) {
        labelGreeting.text = "Hello"
    }
    
}

