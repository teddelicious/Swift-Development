//
//  ViewController.swift
//  Swift-19-App
//
//  Created by John Lin on 2020-04-11.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {

    //MARK: Outlet
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputDoB: UITextField!
    @IBOutlet weak var switchTraveled: UISwitch!
    
    
    //MARK: Instance Variables
    var tabBar: MainTabController?
    private var datePicker: UIDatePicker?
    var selectedDate: Date?
    var result: (Int, Int?, Patient)?
    let err_name = "Please enter your name"
    let err_date = "Please select your date of birth"
    
    //MARK: Default function
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidLoad Main")
        // Do any additional setup after loading the view, typically from a nib.
        
        //tabbar controller
        self.tabBar = tabBarController as! MainTabController
        
        //sets input for DoB as a date picker
        self.datePicker = UIDatePicker()
        self.datePicker?.datePickerMode = .date
        self.datePicker?.addTarget(self, action: #selector(onDateChanged(datePicker:)), for: .valueChanged)
        
        //add toolbar with done button
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePicker))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        inputDoB.inputView = self.datePicker
        inputDoB.inputAccessoryView = toolBar
    }
    
    //clearForm for the entire form
    func clearForm() {
        self.inputName.text = nil
        self.inputDoB.text = nil
        self.switchTraveled.setOn(false, animated: false)
        self.datePicker?.setDate(Date(), animated: false)
    }
    
    //cancelButton for date picker
    @objc func cancelPicker() {
        view.endEditing(true)
    }
    
    //doneButton for date picker
    @objc func donePicker() {
        setDate()
        view.endEditing(true)
    }
    
    //sets date for date picker
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.inputDoB.text = dateFormatter.string(from: self.datePicker!.date)
        self.selectedDate = self.datePicker?.date
    }
    
    //handles date change
    @objc func onDateChanged(datePicker: UIDatePicker) {
        setDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultView = segue.destination as! ResultController
        resultView.result = self.result
    }

    //MARK: Action
    @IBAction func onPressSubmit(_ sender: Any) {
        print(self.inputName.text)
        print(self.selectedDate)
        print(self.switchTraveled.isOn)
        if validInputs() {
            let patient = Patient(name: self.inputName.text!, dob: self.selectedDate!, recentlyTraveled: self.switchTraveled.isOn)
            print(patient.getAge())
            self.result = self.tabBar!.patientProcessor.registerPatient(patient: patient)
            self.clearForm()
            performSegue(withIdentifier: "Result", sender: sender)
        }else {
            showAlertBox(message: (self.inputName.text ?? "").isEmpty ? err_name : err_date)
        }
    }
    
    func showAlertBox(message: String) {
        let box = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        //order of the buttons added is the order they show up
        //on the screen, in IOS its NO -> yes; android YES -> NO
        //use "self" inside the handler (scoping)
        
        box.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(box, animated: true)
    }
    
    func validInputs() -> Bool{
        if !(self.inputName.text ?? "").isEmpty &&
            self.selectedDate != nil {
            return true
        }
        return false
    }
    
}

