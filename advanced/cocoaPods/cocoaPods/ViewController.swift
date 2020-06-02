//
//  ViewController.swift
//  cocoaPods
//
//  Created by John Lin on 2020-05-26.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let URL = "https://api.exchangeratesapi.io/latest"
        Alamofire.request(URL).responseJSON {
            (response)
            in
            
            print(response.data)
        }
    }


}

