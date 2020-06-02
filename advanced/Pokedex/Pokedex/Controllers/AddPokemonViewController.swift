//
//  AddPokemonViewController.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-24.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class AddPokemonViewController: CommonViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Outlets
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtImage: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtBaseExp: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: Variables
    var TYPES = ["Normal", "Fire", "Water", "Grass", "Electric"]
    let MIN_EXP = 50
    let MAX_EXP = 250
    
    let ERR_EMPTY_NAME = "Name cannot be empty"
    let ERR_EMPTY_IMG = "Image cannot be empty"
    let ERR_EMPTY_EXP = "Base experience cannot be empty"
    let ERR_BAD_IMG = "Image not found"
    let ERR_BAD_TYPE = "Type not selected"
    let ERR_BAD_EXP = "Base experience has to be values between 50 - 250"
    let SUC_VALID = "Form is complete and valid"
    
    let typePickerView = UIPickerView()
    
    //MARK: Actions
    @IBAction func onPressReroll(_ sender: Any) {
        generateNewBaseExp()
    }
    
    @IBAction func onPressSave(_ sender: Any) {
        let validation = validateForm()
        if validation.valid{
           //save if pokemon don't already exist
            let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            let query = NSPredicate(format: "name == %@", txtName.text!)
            request.predicate = query
            
            //check if pokemon already exists in database
            do {
                let results = try db.fetch(request)
                if results.count != 0 {
                    showMessage(message: "Pokemon with the name \(txtName.text!) already exists, please enter another name.", buttonHandler: nil)
                }
            }catch {
                showMessage(message: ERR_READ_FAILED, buttonHandler: nil)
            }
            
            //attempt to save pokemon
            let pokemon = Pokemon(context: db)
            pokemon.name = txtName.text!
            pokemon.photo = txtImage.text!
            pokemon.type = txtType.text!
            pokemon.baseExpPoints = Int64(txtBaseExp.text!)!
            
            do {
                try db.save()
                showMessage(message: "Successfully added \(txtName.text!) to the pokedex.", buttonHandler: {
                    (UIAlertAction) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
            catch {
                showMessage(message: ERR_SAVE_FAILED, buttonHandler: nil)
            }
        }else {
            showMessage(message: validation.msg, buttonHandler: nil)
        }
    }
    
    @IBAction func onBeginEditType(_ sender: Any) {
        if let value = txtType.text {
            if value.isEmpty {
                txtType.text = self.TYPES[0]
            }
        }
    }
    
    @IBAction func onEndEditExp(_ sender: Any) {
        if let value = txtBaseExp.text {
            if !value.isEmpty {
                if let exp = Int(value) {
                    if exp < MIN_EXP {
                        txtBaseExp.text = String(MIN_EXP)
                    }else if exp > MAX_EXP {
                        txtBaseExp.text = String(MAX_EXP)
                    }
                }
               
            }
        }
    }
    
    //MARK: functions & helpers
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setPickerViewForType()
        generateNewBaseExp()
//        txtBaseExp.delegate = self
    }
    
    func validateForm() -> (valid: Bool, msg: String) {
        if let value = txtName.text {
            if value.isEmpty {
                return (false, ERR_EMPTY_NAME)
            }
        }
        
        if let value = txtImage.text {
            if value.isEmpty {
                return (false, ERR_EMPTY_IMG)
            }
            guard let _ = UIImage(named: value) else {return (false, ERR_BAD_IMG)}
        }
        
        if let value = txtType.text {
            if value.isEmpty {
                return (false, ERR_BAD_TYPE)
            }
        }
        
        if let value = txtBaseExp.text {
            if value.isEmpty {
                return (false, ERR_EMPTY_EXP)
            }
            guard let _ = Int(value) else {
                return (false, ERR_BAD_EXP)
            }
        }
        
        return (true, SUC_VALID)
    }
    
    func generateNewBaseExp() {
        txtBaseExp.text = String(Int.random(in: 50 ... 250))
    }
    
//    func showMessage(message: String, buttonHandler: ((UIAlertAction) -> Void)?) {
//        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: buttonHandler))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.TYPES.count
    }
    
    //sets the input type for "Type" as a picker view
    func setPickerViewForType() {
        typePickerView.delegate = self
        typePickerView.dataSource = self
        txtType.inputView = typePickerView
        setPickerViewToolBar()
    }
    
    //sets toolbar interaction for typePicker
    func setPickerViewToolBar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = btnSave.tintColor
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(closePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtType.inputAccessoryView = toolBar
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.TYPES[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtType.text = self.TYPES[row]
    }
    

    @objc func closePicker() {
        view.endEditing(true)
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
