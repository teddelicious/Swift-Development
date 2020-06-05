//
//  ScratchCardController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class ScratchCardController: CommonViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    @IBOutlet weak var txtInstruction: UITextView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelPercentOff: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var shakeCount = 0
    var REQUIRED_SHAKE_COUNT = 3
    var canShake = true
    var SHAKE_TIME = ":shake_time"
    let CHANCES = [50, 10, 10, 10, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    let MSG_TRY_AGAIN = "Sorry you didn't win, please try again tomorrow!"
    let MSG_ALREADY_SHOOK = "You can shake again tomorrow."
    let MSG_INSTRUCTIONS = "Shake 3 times for a chance to win a coupon!"
    let MAX_CODE_LENGTH = 8
    let SPACING = "          "
    let defaults = UserDefaults.standard
    var coupon: Coupon?
    var coupons: [Coupon] = []
    var user: User?
    var userShakeTimeKey = ""
    
    //MARK: Helper functions
    func generateDiscount() -> Int {
        let shuffledChances = self.CHANCES.shuffled()
        return shuffledChances[Int.random(in: shuffledChances.indices)]
    }

    func initCouponGeneration() {
        validateShakeTime()
        if self.canShake {
            setShakeTime()
            let discount = generateDiscount()
            print(discount)
            if discount > 0 {
                print("discount > 0")
                var coupon = Coupon(context: self.db)
                coupon.owned_by_user = (self.tabBarController as? MainController)!.user
                coupon.code = generateCode()
                coupon.applied = false
                coupon.discount = Int64(discount)
                coupon.date_created = NSDate()
                do {
                    try self.db.save()
                    self.coupon = coupon
                    fetchData()
                    print("saved")
                }catch {
                    showMessage(message: self.ERR_DB_COMMUNICATION, buttonHandler: nil)
                }
            }
            showCoupon()
        }
    }
    
    func showCoupon() {
        guard let coupon = self.coupon else {
            print("coupon is nil")
            txtInstruction.text = self.MSG_TRY_AGAIN
            txtInstruction.isHidden = false
            labelCode.isHidden = true
            labelPercentOff.isHidden = true
            return
        }
        print("coupon exist")
        txtInstruction.isHidden = true
        labelCode.isHidden = false
        labelPercentOff.isHidden = false
        labelCode.text = coupon.code
        print("showing labels")
        labelPercentOff.text = "\(coupon.discount)% OFF"
    }
    
    func getShakeTime() -> Date? {
        if let _ = UserDefaults.standard.object(forKey: self.userShakeTimeKey) {
            return defaults.object(forKey: self.userShakeTimeKey) as? Date
        }
        return nil
    }
    
    func setShakeTime() {
        print("set time")
        defaults.set(Date(), forKey: self.userShakeTimeKey)
    }
    
    func validateShakeTime() {
        guard let shakeTime = getShakeTime() else {
            self.canShake = true
            print("no shaketime")
            return
        }
        print(shakeTime)
        
        let calendar = Calendar.current
        
        //is next day
        if calendar.component(.day, from: shakeTime) < calendar.component(.day, from: Date()) {
            //remove shake time from user default
            defaults.removeObject(forKey: userShakeTimeKey)
            self.canShake = true
            txtInstruction.text = self.MSG_INSTRUCTIONS
            return
        }else {
            txtInstruction.text = self.MSG_ALREADY_SHOOK
        }
        
        print("cannnnnt shake")
        self.canShake = false
    }
    
    //referenced from:
    //https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift
    func generateCode() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ..< self.MAX_CODE_LENGTH).map{ _ in letters.randomElement()! })
    }
    
    func fetchData() {
        let request: NSFetchRequest<Coupon> = Coupon.fetchRequest()
        request.predicate = NSPredicate(format: "owned_by_user == %@", self.user!)
        do {
            let results = try self.db.fetch(request)
            self.coupons = results
            self.tableView.reloadData()
            print("got results \(results.count)")
        }catch {
            showMessage(message: self.ERR_DB_COMMUNICATION, buttonHandler: nil)
        }
    }
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainController = tabBarController as? MainController
        self.user = mainController!.user
        self.userShakeTimeKey = self.user!.email! + self.SHAKE_TIME
        validateShakeTime()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        self.shakeCount = 0
        fetchData()
//        defaults.removeObject(forKey: SHAKE_TIME)
//        self.coupon = nil
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("shake start")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("shake end")
        if self.canShake {
            self.shakeCount += 1
            print("shaking")
            if self.shakeCount == REQUIRED_SHAKE_COUNT {
                initCouponGeneration()
            }
        }else {
            validateShakeTime()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coupons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (self.coupons[indexPath.row].applied) {
            cell.textLabel!.text = "\(self.coupons[indexPath.row].code!)\(self.SPACING)USED"
        }else {
            cell.textLabel!.text = "\(self.coupons[indexPath.row].code!)\(self.SPACING)\(self.coupons[indexPath.row].discount)% OFF"
        }
        
        return cell
    }

}
