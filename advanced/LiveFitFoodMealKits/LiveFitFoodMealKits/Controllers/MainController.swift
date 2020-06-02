//
//  MainController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-29.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class MainController: UITabBarController {

    //MARK: Outlets
    
    //MARK: Variables
    var user: User?
    
    //MARK: Overriden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.user!)
    }

}
