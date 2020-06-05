//
//  OrderHistoryController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-06-01.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class OrderHistoryController: CommonViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    @IBOutlet weak var orderHistoryTableView: UITableView!
    
    //MARK: Variables
    var orders: [Order] = []
    
    //MARK: Helper functions
    func fetchData() {
        let mainController = tabBarController as? MainController
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        request.predicate = NSPredicate(format: "ordered_by == %@", mainController!.user!)
        do {
            let results = try self.db.fetch(request)
            print(results)
            self.orders = results
            self.orderHistoryTableView.reloadData()
        }catch {
            showMessage(message: self.ERR_DB_COMMUNICATION, buttonHandler: nil)
        }
    }

    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderHistoryTableView.delegate = self
        self.orderHistoryTableView.dataSource = self
        self.orderHistoryTableView.rowHeight = 130

        // Do any additional setup after loading the view.
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderHistoryCell") as? OrderHistoryCell
        
        let row = indexPath.row
        cell?.labelName.text = ((self.orders[row].has_order_item!.allObjects) as? [OrderItem])![0].ordered_meal_kit!.name
        cell?.labelStatus.text = self.orders[row].status
        cell?.labelTotal.text = String(format: "$%.02f", self.orders[row].total)
        
        if let date = self.orders[row].date_created! as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm a"
            cell?.labelDate.text = dateFormatter.string(from: date)
        }
        
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    //MARK: Actions
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
