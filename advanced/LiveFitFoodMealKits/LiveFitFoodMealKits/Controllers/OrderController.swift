//
//  OrderController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class OrderController: CommonViewController, UITableViewDelegate, UITableViewDataSource, MealKitCellDelegate {

    //MARK: Outlets
    @IBOutlet var orderTableView: UITableView!
    
    //MARK: Variables
    var mealkits: [MealKit] = []
    var selectedMealKit: MealKit?
    
    //MARK: Helper functions
    func fetchData() {
        let request: NSFetchRequest<MealKit> = MealKit.fetchRequest()
        do {
            let results = try self.db.fetch(request)
            self.mealkits = results
        }catch {
            showMessage(message: self.ERR_DB_COMMUNICATION, buttonHandler: nil)
        }
    }
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        self.orderTableView.rowHeight = 400
    }
    
    func mealKitRowSelected(index: Int) {
        //what to do when function is triggered
        print(index)
        //redirect mealkit data to next page & segue
        self.selectedMealKit = self.mealkits[index]
        performSegue(withIdentifier: "segueMealKitDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mealKitRowSelected(index: indexPath.row)
        return
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.mealkits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealKitCell") as? MealKitCell
        
        let row = indexPath.row
        cell?.ivImage.image = UIImage(named: self.mealkits[row].image_path!)
        cell?.labelName.text = self.mealkits[row].name!
        cell?.labelPrice.text = String(format: "$%.02f", self.mealkits[row].price)
//        cell?.mealKit = self.mealkits[row]
        
        //setup delegate
        cell?.delegate = self
        cell?.index = indexPath
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMealKitDetails" {
            let mkdController = segue.destination as! MealKitDetailsController
            mkdController.mealKit = self.selectedMealKit
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToOrderController(segue: UIStoryboardSegue) {
        
    }

}
