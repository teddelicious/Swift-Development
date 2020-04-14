//
//  ResultController.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-12.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ResultController: UIViewController {

    
    @IBOutlet weak var textPriorityNumber: UITextView!
    @IBOutlet weak var textResult: UITextView!
    @IBOutlet weak var textName: UITextView!
    
    var result: (priority: Int, position: Int?, patient: Patient)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad Result")
        // Do any additional setup after loading the view.
        if let data = self.result {
            self.textName.text = data.patient.name
            self.textPriorityNumber.text = data.priority.description
            if let position = data.position {
                self.textResult.text = "You are currently number \(position) in line to be tested."
            }else{
                self.textResult.text = "No test required."
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func opnPressGoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
