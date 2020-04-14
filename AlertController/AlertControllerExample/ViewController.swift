//
//  ViewController.swift
//  AlertControllerExample
//
//  Created by Parrot on 2020-03-28.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

// ALERT BOX CHECKLIST:
// - Did you create a new UIAlertController object and save to variable? (abc)
// - Did you set the title and message parameters?
// - Did you choose the style of your Alert Box? (Alert vs. ActionSheet)
// - Did you add buttons? (.addAction)
// - Did you remember to SHOW the alert box? (self.present(abc, animated:true))
// OPTIONAL:
// - Do your buttons need "click handlers"?
// - Do you need to include text boxes? (.addTextField(....))


class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var labelResults: UILabel!
    
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func onAlertPressed(_ sender: Any) {
        let box = UIAlertController(
            title: "Toilet Paper Check",
            message: "Do we have enough toilet papers?",
            preferredStyle: .alert
        )
        
        //order of the buttons added is the order they show up
        //on the screen, in IOS its NO -> yes; android YES -> NO
        //use "self" inside the handler (scoping)
        
        box.addAction(UIAlertAction(title: "NO", style: .default, handler: {
            action in
            self.labelResults.text = "Please get more toilet paper!"
        }))
        
        box.addAction(UIAlertAction(title: "YES", style: .default, handler: {
            action in
            self.labelResults.text = "GREAT!"
        }))
        
        self.present(box, animated: true)
        
    }
    

}

