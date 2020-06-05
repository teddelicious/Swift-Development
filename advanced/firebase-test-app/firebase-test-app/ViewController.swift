//
//  ViewController.swift
//  firebase-test-app
//
//  Created by John Lin on 2020-05-29.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onLoginPressed(_ sender: Any) {
        guard let email = txtEmail.text else {
            print("error")
            return
        }
        
        guard let password = txtPassword.text else {
            print("error")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {
            (res, err) in
            if let _ = err {
                print(err.debugDescription)
                Auth.auth().createUser(withEmail: email, password: password) {
                    (res, err) in
                    if let _ = err {
                        print(err.debugDescription)
                        return
                    }
                }
            }
            
            self.email = email
            self.performSegue(withIdentifier: "segueLogin", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueLogin" {
            let secondController = SecondViewController()
            secondController.email = self.email
        }
    }
    
}

