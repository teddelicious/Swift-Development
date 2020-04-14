//
//  PatientList.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-12.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class PatientProcessor {
    var queue: [Patient] = []
    var cleared: [Patient] = []
    var tested: [Patient] = []
    
    //static var
    let AGE_THRESHOLD = 65
    let PRIORITY_ZERO = 0
    let PRIORITY_ONE = 1
    let PRIORITY_TWO = 2
    let PRIORITY_THREE = 3
    
    //add patient to one of the list
    func registerPatient(patient: Patient) -> (priority: Int, position: Int?, patient: Patient) {
        let priority = checkPatientPriority(patient: patient)
        var position: Int?
        
        if priority != PRIORITY_ZERO {
            position = addPatientToQueue(priority: priority, patient: patient)
        }else{
            addPatientToCleared(patient: patient)
        }
        
        return (priority, position, patient)
    }
    
    func addPatientToQueue(priority: Int, patient: Patient) -> Int {
        //no item in queue
        if self.queue.count == 0 {
            self.queue.append(patient)
            return 1
        }
        
        var position = 0
        for (index, p) in self.queue.enumerated() {
            if priority > checkPatientPriority(patient: p) {
                self.queue.insert(patient, at: index)
                print("inserting")
                break
            }else if index == self.queue.count - 1 {
                self.queue.append(patient)
                break
            }
            //position of user, not index
            position = index + 1
        }
        return position
    }
    
    func addPatientToCleared(patient: Patient) {
        //no item in cleared
        if self.cleared.count == 0 {
            self.cleared.append(patient)
        }else {
            for (index, p) in self.cleared.enumerated() {
                if patient < p {
                    //insert somewhere in the list
                    self.cleared.insert(patient, at: index)
                    break
                }else if index == self.cleared.count - 1 {
                    //append to the end if last element
                    self.cleared.append(patient)
                    break
                }
            }
        }
    }
    
    //determine patient priority
    func checkPatientPriority(patient: Patient) -> Int {
        
        if patient.getAge() > AGE_THRESHOLD && patient.recentlyTraveled {
            //over 65 & traveled
            return PRIORITY_THREE
        }else if patient.getAge() > AGE_THRESHOLD {
            //over 65
            return PRIORITY_TWO
        }else if patient.recentlyTraveled {
            //traveled
            return PRIORITY_ONE
        }
        
        //others .. less or equal age 65 & not traveled
        return PRIORITY_ZERO
    }
    
    //move patient from queue to cleared
    func clearPatientByIndex(index: Int) {
        let patient = self.queue.remove(at: index)
        self.tested.append(patient)
    }
    
}
