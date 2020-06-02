//
//  ViewController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-29.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class LoginController: CommonViewController {

    //MARK: Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: Variables
    let ERR_AUTH = "Invalid credentials, please check your email and password and try again"
    let ID_SEGUE_LOGIN = "segueLogin"
    var user: User?
    
    //MARK: Helper functions
    
    //MARK: Overridden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtEmail.text = nil
        txtPassword.text = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ID_SEGUE_LOGIN {
            let mainController = segue.destination as! MainController
            mainController.user = self.user
        }
    }

    //MARK: Actions
    @IBAction func onLoginPressed(_ sender: Any) {
        guard let email = txtEmail.text.unwrapped else {
            showMessage(message: ERR_NO_EMAIL, buttonHandler: nil)
            return
        }
        
        guard let password = txtPassword.text.unwrapped else {
            showMessage(message: ERR_NO_PASSWORD, buttonHandler: nil)
            return
        }
        
        if !isValidEmail(email) {
            showMessage(message: ERR_INVALID_EMAIL, buttonHandler: nil)
            return
        }
        
        //if email is valid, perform search and auth
        print("email: \(email), password: \(password)")
        if let user = fetchUserByEmail(email) {
            if user.password.unwrapped == password {
                self.user = user
                performSegue(withIdentifier: "segueLogin", sender: self)
                return
            }
        }
        
        showMessage(message: ERR_AUTH, buttonHandler: nil)
    }
    

}

