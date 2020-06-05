//
//  OrderConfirmationController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class OrderConfirmationController: CommonViewController {

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
    @IBOutlet weak var scTips: UISegmentedControl!
    @IBOutlet weak var txtCoupon: UITextField!
    
    
    //MARK: Variables
    var mealKit: MealKit?
    var qty = 0
    var price: Double = 0
    var subtotal: Double = 0
    var tax: Double = 0
    var tips: Double = 0
    var total: Double = 0
    var selectedTipOption = 0
    var couponUsed: Coupon?
    let TAX_PERCENTAGE = 13
    let CUSTOM_TIP_OPTION = 3
    let TIPS_PERCENTAGE = [10, 15, 20, 0]
    let MSG_COUPON_APPLIED = "Coupon applied to order"
    let MSG_COUPON_INVALID = "Coupon entered is invalid"
    let MSG_ORDER_PLACED = "Your order has been placed"
    let ERR_ORDER_FAILED = "Something went wrong, failed to place order"
    
    //MARK: Helper functions
    func calculateSubtotal() {
        self.subtotal = Double(self.qty) * self.price
        labelSubtotal.text = String(format: "$%.02f", self.subtotal)
    }
    
    func calculateTax() {
        self.tax = self.subtotal * Double(self.TAX_PERCENTAGE) / 100.00
        labelTax.text = String(format: "$%.02f", self.tax)
    }
    
    func calculateTips() {
        if self.selectedTipOption != self.CUSTOM_TIP_OPTION {
            self.tips = self.subtotal * Double(self.TIPS_PERCENTAGE[self.selectedTipOption]) / 100.00
        }
        labelTips.text = String(format: "$%.02f", self.tips)
    }
    
    func calculateTotal() {
        self.total = self.subtotal + self.tax + self.tips
        labelTotal.text = String(format: "$%.02f", self.total)
    }
    
    func calculateNumbers() {
        calculateSubtotal()
        calculateTax()
        calculateTips()
        calculateTotal()
    }
    
    func applyCoupon() {
        guard let coupon = self.couponUsed else {
            return
        }
        self.price = self.price * (100.00 - Double(coupon.discount)) / 100.00
        labelPrice.text = String(format: "$%.02f", self.price)
        calculateNumbers()
    }
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.price = self.mealKit!.price
        labelName.text = self.mealKit!.name
        labelSKU.text = "SKU: \(self.mealKit!.sku!)"
        labelPrice.text = String(format: "$%.02f", self.price)
        image.image = UIImage(named: self.mealKit!.image_path!)
        labelQty.text = self.qty.description
        calculateNumbers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueReceipt" {
            let receiptController = segue.destination as? ReceiptController
            receiptController!.name = self.labelName.text
            receiptController!.sku = self.labelSKU.text
            receiptController!.price = self.labelPrice.text
            receiptController!.img = self.image.image
            receiptController!.qty = self.labelQty.text
            receiptController!.subtotal = self.labelSubtotal.text
            receiptController!.tax = self.labelTax.text
            receiptController!.tips = self.labelTips.text
            receiptController!.total = self.labelTotal.text
        }
    }
    
    //MARK: Actions
    @IBAction func onTipsSelected(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        self.selectedTipOption = sender.selectedSegmentIndex
        if self.selectedTipOption == self.CUSTOM_TIP_OPTION {
            let alert = UIAlertController(title: "Custom Tip", message: "", preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "$0.00"
                textField.keyboardType = .decimalPad
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default) {
                _ in
                sender.selectedSegmentIndex = 0
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) {
                _ in
                let textField = alert.textFields![0]
                if let text = textField.text {
                    if let tips = Double(text) {
                        self.tips = tips
                        self.calculateNumbers()
                        return
                    }
                }
                self.tips = 0
            })
            
            self.present(alert, animated: true, completion: nil)
        }
        calculateNumbers()
    }
    
    
    @IBAction func onApplyCouponPressed(_ sender: Any) {
        guard let coupon = txtCoupon.text else {
            return
        }
        
        let mainController = tabBarController as? MainController
        let request: NSFetchRequest<Coupon> = Coupon.fetchRequest()
        print(mainController!.user!)
        let predicate1 = NSPredicate(format: "owned_by_user == %@", mainController!.user!)
        let predicate2 = NSPredicate(format: "applied == %@", NSNumber(value: false))
        let predicate3 = NSPredicate(format: "code == %@", coupon)
//        request.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate2])
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2, predicate3])
        
        request.predicate = predicate
        do {
            let results = try self.db.fetch(request)
            if results.count > 0 {
                print(results)
                //apply coupon
                self.couponUsed = results[0]
                applyCoupon()
                showMessage(message: MSG_COUPON_APPLIED, buttonHandler: nil)
            }else {
                showMessage(message: MSG_COUPON_INVALID, buttonHandler: nil)
            }
        }catch {
            showMessage(message: self.ERR_DB_COMMUNICATION, buttonHandler: nil)
        }
    }
    
    @IBAction func onPlaceOrderPressed(_ sender: Any) {
        let mainController = tabBarController as? MainController
        print(mainController?.user)
        let newOrder = NSEntityDescription.insertNewObject(forEntityName: "Order", into: self.db)
        let newOrderItem = NSEntityDescription.insertNewObject(forEntityName: "OrderItem", into: self.db)
        newOrderItem.setValue(self.qty, forKey: "qty")
        newOrderItem.setValue(self.mealKit!, forKey: "ordered_meal_kit")
        newOrderItem.setValue(newOrder, forKey: "order")
        newOrder.setValue(mainController?.user, forKey: "ordered_by")
        newOrder.setValue(self.total, forKey: "total")
        newOrder.setValue(self.tips, forKey: "tip")
        newOrder.setValue(NSDate(), forKey: "date_created")
        newOrder.setValue(OrderStatus.CONFIRMED.rawValue, forKey: "status")
        if let coupon = self.couponUsed as? NSManagedObject {
            newOrder.setValue(coupon, forKey: "coupon_applied")
            newOrder.setValue(NSSet(array: [newOrderItem]), forKey: "has_order_item")
            coupon.setValue(true, forKey: "applied")
            coupon.setValue(newOrder, forKey: "used_in_order")
        }
        do {
            try self.db.save()
            print("saved successfully")
            showMessage(message: self.MSG_ORDER_PLACED) {
                _ in
                self.performSegue(withIdentifier: "segueReceipt", sender: self)
            }
        }catch {
            print(error)
            showMessage(message: self.ERR_ORDER_FAILED, buttonHandler: nil)
        }
    }

}
