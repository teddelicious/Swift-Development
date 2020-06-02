//
//  CommonViewController.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    //MARK: Variables
    let ERR_SAVE_FAILED = "Failed to save to database, please try again later."
    let ERR_READ_FAILED = "Failed to communicate with database, please try again later."
    let ERR_UNKNOWN = "Unknown error."
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showMessage(message: String, buttonHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonHandler))
        
        self.present(alert, animated: true, completion: nil)
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
