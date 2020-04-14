//
//  SecondPageController.swift
//  MultiScreenExample01
//
//  Created by John Lin on 2020-03-31.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

class SecondPageController: UIViewController {

    var username: String = ""
    
    @IBOutlet weak var usernameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("i am on page 2")
        // Do any additional setup after loading the view.
        print(username)
        usernameLabel.text = username
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
