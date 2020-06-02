//
//  ViewController.swift
//  SensorInClass
//
//  Created by Parrot on 2020-05-27.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

// 1. Import the motion library


class ViewController: UIViewController {

    // ------------------------
    // MARK: Outlets
    // ------------------------
    @IBOutlet weak var xProgress: UIProgressView!
    @IBOutlet weak var yProgress: UIProgressView!
    @IBOutlet weak var zProgress: UIProgressView!
    
    
    // ------------------------
    // MARK: IOS Lifecycle functions
    // ------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBars()
        
    }

    // ------------------------
    // MARK: Motion Functions
    // ------------------------
    
    // ------------------------
    // MARK: Actions
    // ------------------------
    @IBAction func pushMePressed(_ sender: Any) {
        print("button pressed")
    }
    
    
    // ------------------------
    // MARK: Helper Functions
    // ------------------------
    
    // update size of progress bars
    func setupProgressBars() {
        // increase the height of progress bars so it's easier to see
        xProgress.transform = xProgress.transform.scaledBy(x: 1, y: 10)
        yProgress.transform = yProgress.transform.scaledBy(x: 1, y: 10)
        zProgress.transform = zProgress.transform.scaledBy(x: 1, y: 10)
        
        // set initial position of progress bars
        xProgress.progress = 0.8
        yProgress.progress = 0.1
        zProgress.progress = 0.5
    }
    
}

