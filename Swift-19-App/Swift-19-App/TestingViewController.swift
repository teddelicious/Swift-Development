//
//  TestingViewController.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-13.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PatientCellDelegate {
    
    //MARK: protocol stub
    func patientRowSelected(index: Int) {
        //what to do when function is triggered
        print(index)
        let box = UIAlertController(title: "Test Confirmation", message: "Is the patient test complete?", preferredStyle: .alert)
        box.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        box.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            self.movePatient(index: index)
        }))
        self.present(box, animated: true, completion: nil)
    }
    
    //MARK: outlets
    @IBOutlet weak var patientTableView: UITableView!
    
    //MARK: variables
    var data: [Patient] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = patientTableView.dequeueReusableCell(withIdentifier: "patientCell") as? PatientTableViewCell
        
        let row = indexPath.row
        let processor = PatientProcessor()
        let priority = processor.checkPatientPriority(patient:  self.data[row])
        cell?.labelName.text = self.data[row].name
        cell?.labelAge.text = "Age: \(self.data[row].getAge())"
        cell?.labelPriority.text = "Priority: \(priority)"
        
        //set text colors
        switch (priority) {
        case processor.PRIORITY_THREE:
            cell?.labelName.textColor = UIColor.red
            cell?.labelAge.textColor = UIColor.red
            cell?.labelPriority.textColor = UIColor.red
        case processor.PRIORITY_TWO:
            //yellow is not really visible
            cell?.labelName.textColor = UIColor.orange
            cell?.labelAge.textColor = UIColor.orange
            cell?.labelPriority.textColor = UIColor.orange
        default:
            cell?.labelName.textColor = UIColor.green
            cell?.labelAge.textColor = UIColor.green
            cell?.labelPriority.textColor = UIColor.green
        }
        
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
        self.patientTableView.delegate = self
        self.patientTableView.dataSource = self
        self.patientTableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view appear testing")
        
        //tabbar controller
        let tabBar = tabBarController as! MainTabController
        
        self.data = tabBar.patientProcessor.queue
        self.patientTableView.reloadData()
        print(self.data)
    }
    
    func movePatient(index: Int) {
        //tabbar controller
        let tabBar = tabBarController as! MainTabController
        tabBar.patientProcessor.clearPatientByIndex(index: index)
        self.data = tabBar.patientProcessor.queue
        self.patientTableView.reloadData()
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
