//
//  MainController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-29.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class MainController: UITabBarController, CLLocationManagerDelegate {

    //MARK: Outlets
    
    //MARK: Variables
    var user: User?
    var locationManager: CLLocationManager?
    //set as george brown college
    let storeLocation = CLLocation(latitude: 43.6761, longitude: -79.4105)
    let PREPARATION_DISTANCE: Double = 100.00
    let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let TIME_TO_COMPLETE_ORDER = 60 * 15
    let MSG_ORDER_PREPARATION = "Your order is currently being compared. It will be ready in 15 minutes."
    let MSG_ORDER_COMPLETE = "Your order is complete and ready for pickup."
    var isInMealPreparation = false
    var timer: Timer?
    
    //MARK: Helper functions
    func fetchUserOrdersAsNSManagedObject(status: OrderStatus) -> [NSManagedObject] {
        var results:[NSManagedObject] = []
        let request: NSFetchRequest<Order> = Order.fetchRequest()
        let userPredicate = NSPredicate(format: "ordered_by == %@", self.user!)
        let statusPredicate = NSPredicate(format: "status == %@", status.rawValue)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [userPredicate, statusPredicate])
        request.predicate = predicate
        do {
            results = try db.fetch(request) as [NSManagedObject]
            print(results)
        }catch {
            print(error)
        }
        return results
    }
    
    func modifyUserOrdersStatus(status: OrderStatus, results: [NSManagedObject]) -> Bool {
        if results.count > 0 {
            print(results)
            //for each item, change value and prepare to save
            for obj in results {
                obj.setValue(status.rawValue, forKey: "status")
            }
            do {
                try db.save()
                print("save success")
                return true
            }catch {
                print("error")
                return false
            }
        }
        print("no result")
        return false
    }
    
    //MARK: Overriden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        print(CLLocationManager.authorizationStatus().rawValue)
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            print("always use")
            self.locationManager?.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("when in use")
            self.locationManager?.startUpdatingLocation()
        default:
            //popup box, then prompt permission
            self.locationManager?.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        print("new location is \(location.coordinate)")
        let distance = self.storeLocation.distance(from: location)
        if distance <= self.PREPARATION_DISTANCE && !self.isInMealPreparation {
            self.isInMealPreparation = true
            if (modifyUserOrdersStatus(status: OrderStatus.INTHEWORKS, results: fetchUserOrdersAsNSManagedObject(status: OrderStatus.CONFIRMED))) {
                //start timer to complete order
                var count = 0
                
                //alert box
                let alert = UIAlertController(title: "Alert", message: self.MSG_ORDER_PREPARATION, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) {
                    _ in
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                        print(count)
                        count += 1
                        if count >= self.TIME_TO_COMPLETE_ORDER {
                            timer.invalidate()
                            _ = self.modifyUserOrdersStatus(status: OrderStatus.COMPLETE, results: self.fetchUserOrdersAsNSManagedObject(status: OrderStatus.INTHEWORKS))
                            let alert2 = UIAlertController(title: "Alert", message: self.MSG_ORDER_COMPLETE, preferredStyle: UIAlertController.Style.alert)
                            alert2.addAction(UIAlertAction(title: "OK", style: .default) {_ in})
                            self.present(alert2, animated: true, completion: nil)
                            self.isInMealPreparation = false
                        }
                    }
                })
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            self.isInMealPreparation = false
        }
        
    }

}
