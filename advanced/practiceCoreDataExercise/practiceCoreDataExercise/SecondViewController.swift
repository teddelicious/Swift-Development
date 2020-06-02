//
//  SecondViewController.swift
//  practiceCoreDataExercise
//
//  Created by John Lin on 2020-05-21.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var txtResult: UITextView!
    
    var result: String?
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.result!)
        self.txtResult.text = self.result!
        // Do any additional setup after loading the view.
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
