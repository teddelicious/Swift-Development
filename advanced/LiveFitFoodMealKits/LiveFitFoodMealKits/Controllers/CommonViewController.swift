//
//  CommonViewController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-30.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

//extension to get nil / proper non-empty value
extension Optional where Wrapped == String {
    var unwrapped: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}

class CommonViewController: UIViewController {

    //MARK: Variables
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let ERR_NO_EMAIL = "Please enter an email"
    let ERR_NO_PASSWORD = "Please enter a password"
    let ERR_INVALID_EMAIL = "Email entered must be in the format of example@email.com"
    let ERR_DB_COMMUNICATION = "There was a problem communicating with the database, please try again later."
    let ERR_USER_EXISTS = "User already exists, please use another email"
    let DEFAULT_MK_INITIALIZED = "default_mk_initialized"
    let DEFAULT_MK_FILE = "MealKits"
    let DEFAULT_MK_FILE_EXT = "json"
    
    //MARK: Helper functions
    
    //MARK: Helper functions
    //generic message handling
    func showMessage(message: String, buttonHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonHandler))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //fetch user by email
    func fetchUserByEmail(_ email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        var user: User?
        do {
            let results = try self.db.fetch(request)
            //there should not be any duplicate emails in the database
            if results.count > 0 {
                user = results[0]
            }
        }catch {
            showMessage(message: ERR_DB_COMMUNICATION, buttonHandler: nil)
        }
        
        return user
    }
    
    //email format validation using regex:
    //ref: https://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //initial mealKits data population
    func initMealKits() {
        let defaults = UserDefaults.standard
        if let _ = UserDefaults.standard.object(forKey: DEFAULT_MK_INITIALIZED) {
            if defaults.bool(forKey: DEFAULT_MK_INITIALIZED) {
                //mealkit not initialized
                return
            }
        }
        
        // load the json file here
        guard let file = Bundle.main.path(forResource: self.DEFAULT_MK_FILE, ofType: self.DEFAULT_MK_FILE_EXT) else {
            print("Cannot find file")
            return
        }
        
        let mealKitDtos = getMealKitDtos(file: file)
        
        for m in mealKitDtos {
            let newMealKit = NSEntityDescription.insertNewObject(forEntityName: "MealKit", into: self.db)
            newMealKit.setValue(m.sku, forKey: "sku")
            newMealKit.setValue(m.name, forKey: "name")
            newMealKit.setValue(m.desc, forKey: "desc")
            newMealKit.setValue(m.price, forKey: "price")
            newMealKit.setValue(Int64(m.calorie_count), forKey: "calorie_count")
            newMealKit.setValue(m.image_path, forKey: "image_path")
            newMealKit.setValue(NSDate(), forKey: "date_created")
        }
        //attempt save
        do {
            try self.db.save()
            defaults.set(true, forKey: DEFAULT_MK_INITIALIZED)
        } catch {
            print("Error saving: \(error)")
        }
        
    }
    
    func getMealKitDtos(file: String) -> [MealKitDTO] {
        var mealKitDtos: [MealKitDTO] = []
        do {
            let jsonData = try String(contentsOfFile: file).data(using: .utf8)
            mealKitDtos =
                try JSONDecoder().decode([MealKitDTO].self, from: jsonData!)
            dump(mealKitDtos)
        } catch  {
            print("Error: file content can't be loaded")
        }
        
        return mealKitDtos
    }
    
    //MARK: Overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initMealKits()
        
    }

}
