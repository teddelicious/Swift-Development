//
//  TabBarController.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-12.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    var patientProcessor: PatientProcessor = PatientProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("viewdidload in maintabcontroller")
        
        //testing data
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        patientProcessor.registerPatient(patient: Patient(name: "John1", dob: formatter.date(from: "2020/04/20")!, recentlyTraveled: false))
//        patientProcessor.registerPatient(patient: Patient(name: "John2", dob: formatter.date(from: "2000/04/20")!, recentlyTraveled: true))
//        patientProcessor.registerPatient(patient: Patient(name: "John3", dob: formatter.date(from: "1990/04/20")!, recentlyTraveled: true))
//        patientProcessor.registerPatient(patient: Patient(name: "John4", dob: formatter.date(from: "1980/04/20")!, recentlyTraveled: true))
//        patientProcessor.registerPatient(patient: Patient(name: "John5", dob: formatter.date(from: "1970/04/20")!, recentlyTraveled: false))
//        patientProcessor.registerPatient(patient: Patient(name: "John6", dob: formatter.date(from: "1960/04/20")!, recentlyTraveled: true))
//        patientProcessor.registerPatient(patient: Patient(name: "John7", dob: formatter.date(from: "1950/04/20")!, recentlyTraveled: false))
//        patientProcessor.registerPatient(patient: Patient(name: "John8", dob: formatter.date(from: "1940/04/20")!, recentlyTraveled: true))
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
