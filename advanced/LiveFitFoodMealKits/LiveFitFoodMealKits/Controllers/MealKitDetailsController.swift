//
//  MealKitDetailsController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class MealKitDetailsController: CommonViewController {

    //MARK: Outlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSKU: UILabel!
    @IBOutlet weak var labelCalories: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelDesc: UITextView!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var stepQty: UIStepper!
    
    //MARK: Variables
    var mealKit: MealKit?
    
    //MARK: Helper functions
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelName.text = self.mealKit!.name
        labelSKU.text = "SKU: \(self.mealKit!.sku)"
        labelCalories.text = "\(self.mealKit!.calorie_count) Calories"
        image.image = UIImage(named: self.mealKit!.image_path!)
        labelDesc.text = self.mealKit!.desc
        labelPrice.text = String(format: "$%.02f", self.mealKit!.price)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueConfirmOrder" {
            let ocController = segue.destination as! OrderConfirmationController
            ocController.mealKit = self.mealKit
            ocController.qty = Int(stepQty.value)
        }
    }
    
    //MARK: Actions
    @IBAction func onQtyChanged(_ sender: UIStepper) {
        self.labelQty.text = Int(self.stepQty.value).description
    }
    
    @IBAction func onPurchasePressed(_ sender: Any) {
        performSegue(withIdentifier: "segueConfirmOrder", sender: self)
    }
    
    
}
