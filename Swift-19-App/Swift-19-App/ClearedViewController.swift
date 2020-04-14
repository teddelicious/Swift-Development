//
//  ClearedViewController.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-13.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ClearedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PatientCellDelegate {

    //MARK: protocol stub
    func patientRowSelected(index: Int) {
        //what to do when function is triggered
        print(index)
    }
    
    //MARK: outlets
    @IBOutlet weak var clearedTableView: UITableView!
    
    //MARK: variables
    var data: [Patient] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = clearedTableView.dequeueReusableCell(withIdentifier: "patientCell") as? PatientTableViewCell
        
        let row = indexPath.row
        cell?.labelName.text = self.data[row].name
        cell?.labelAge.text = "Age: \(self.data[row].getAge())"
        cell?.labelRecentlyTraveled.text = "Recently traveled: \(self.data[row].recentlyTraveled ? "Yes" : "No")"
        
        if (cell == nil) {
            cell = PatientTableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: "patientCell")
        }
        
        //setup delegate
        cell?.delegate = self
        cell?.index = indexPath
        
        return cell!
    }
    
    //row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        patientRowSelected(index: indexPath.row)
        return
    }
    
    //total number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load testing")
        // Do any additional setup after loading the view.
        self.clearedTableView.delegate = self
        self.clearedTableView.dataSource = self
        self.clearedTableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view appear testing")
        
        //tabbar controller
        let tabBar = tabBarController as! MainTabController
        
        self.data = tabBar.patientProcessor.cleared
        self.clearedTableView.reloadData()
        print(self.data)
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
