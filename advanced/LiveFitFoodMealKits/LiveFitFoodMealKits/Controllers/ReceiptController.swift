//
//  RecieptController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ReceiptController: CommonViewController {

    //MARK: Outlets
    //mealkit data
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSKU: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    //order data
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelSubtotal: UILabel!
    @IBOutlet weak var labelTax: UILabel!
    @IBOutlet weak var labelTips: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    
    //MARK: Variables
    var name: String?
    var sku: String?
    var price: String?
    var img: UIImage?
    var qty: String?
    var subtotal: String?
    var tax: String?
    var tips: String?
    var total: String?
    
    //MARK: Helper functions
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelName.text = self.name
        labelSKU.text = self.sku
        labelPrice.text = self.price
        image.image = self.img
        labelQty.text = self.qty
        labelSubtotal.text = self.subtotal
        labelTax.text = self.tax
        labelTips.text = self.tips
        labelTotal.text = self.total
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isBeingDismissed {
            
        }
    }
    
    //MARK: Actions
}
