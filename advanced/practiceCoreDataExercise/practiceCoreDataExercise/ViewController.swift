//
//  ViewController.swift
//  practiceCoreDataExercise
//
//  Created by John Lin on 2020-05-21.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var result: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: handlers
    @IBAction func onAddClicked(_ sender: Any) {
        
        let user = User(context: db)
        user.firstName = txtFirstName.text
        user.lastName = txtLastName.text
        user.email = txtEmail.text
        
        var result = "Successfully added User(\(txtFirstName.text!) \(txtLastName.text!): \(txtEmail.text!)) to database"
        
        do {
            print("do")
            try db.save()
        } catch {
            print("cannot save to db")
            result = "Failed to add User(\(txtFirstName.text!) \(txtLastName.text!): \(txtEmail.text!)) to database"
        }
        self.result = result
        self.performSegue(withIdentifier: "segueSecondPage", sender: self)
    }
    
    @IBAction func onClearClicked(_ sender: Any) {
        self.txtFirstName.text = nil
        self.txtLastName.text = nil
        self.txtEmail.text = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing...")
        let secondView = segue.destination as! SecondViewController
        secondView.result = self.result
    }

}

