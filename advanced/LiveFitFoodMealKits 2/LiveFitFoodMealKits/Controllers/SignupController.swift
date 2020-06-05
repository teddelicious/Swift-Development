//
//  SignupController.swift
//  LiveFitFoodMealKits
//
//  Created by John Lin on 2020-05-29.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import Photos
import AVKit
import MobileCoreServices
import CoreData

class SignupController: CommonViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK: Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonImage: UIButton!
    
    //MARK: Variables
    let ERR_NO_PHONE = "Please enter a phone number"
    let ERR_NO_PHOTO = "Please choose a profile photo"
    let ERR_PASSWORD_MISMATCH = "The passwords don't match"
    let ERR_INVALID_PHONE = "Phone number must be a valid North American phone number i.e. 416-123-5678"
    let ERR_NO_IMAGE_OPTION = "This device does not support this functionality"
    let ERR_DB_SAVE = "Failed to save user, please try again later."
    let PERM_DENIED = "No permission to access this feature"
    var imagePicker: UIImagePickerController!
    
    //MARK: Helper functions
    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "[0-9]{10}"
        
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    func openGallery() {
        print("gallery")
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.delegate = self
        self.present(self.imagePicker, animated: true)
    }
    
    func openCamera() {
        print("camera")
        self.imagePicker.sourceType = .camera
        self.imagePicker.delegate = self
        self.present(self.imagePicker, animated: true)
    }
    
    func saveUser(_ email: String, _ password: String, _ phone: String, _ photoData: Data?) {
        let user = User(context: db)
        user.email = email
        user.password = password
        user.phone_number = phone
        user.photo = photoData! as NSData
        user.date_created = NSDate()
        do {
            try self.db.save()
            performSegue(withIdentifier: "segueRedirectLogin", sender: self)
        }catch {
            showMessage(message: ERR_DB_SAVE, buttonHandler: nil)
        }
    }
    
    //MARK: Overridden & implemented functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
            print("No photo selected")
            return
        }
        picker.dismiss(animated: true)
        if mediaType == String(kUTTypeImage) {
            self.imageView.image = info[.originalImage] as? UIImage
            self.buttonImage.setImage(nil, for: UIControl.State.normal)
        }
    }
    
    //MARK: Actions
    @IBAction func onPhotoSelectionPressed(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        let alert = UIAlertController(title: "Choose a photo", message: nil, preferredStyle: .actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default){ _ in
                switch PHPhotoLibrary.authorizationStatus() {
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization() {
                        status in
                        if status == .authorized {
                            self.openGallery()
                        }else {
                            self.showMessage(message: self.PERM_DENIED, buttonHandler: nil)
                        }
                    }
                case .authorized:
                    self.openGallery()
                default:
                    self.showMessage(message: self.PERM_DENIED, buttonHandler: nil)
                }
                })
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default){ _ in
                switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) {
                        granted in
                        if granted {
                            self.openCamera()
                        }else {
                            self.showMessage(message: self.PERM_DENIED, buttonHandler: nil)
                        }
                    }
                case .authorized:
                    self.openCamera()
                default:
                    self.showMessage(message: self.PERM_DENIED, buttonHandler: nil)
                }
            })
        }
        
        if alert.actions.count == 0 {
            showMessage(message: ERR_NO_IMAGE_OPTION, buttonHandler: nil)
        }else {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func onSignupPressed(_ sender: Any) {
        guard let email = txtEmail.text.unwrapped else {
            showMessage(message: ERR_NO_EMAIL, buttonHandler: nil)
            return
        }
        
        guard let password = txtPassword.text.unwrapped else {
            showMessage(message: ERR_NO_PASSWORD, buttonHandler: nil)
            return
        }
        
        if password != txtPassword2.text.unwrapped {
            showMessage(message: ERR_PASSWORD_MISMATCH, buttonHandler: nil)
            return
        }
        
        guard let phone = txtPhoneNumber.text.unwrapped else {
            showMessage(message: ERR_NO_PHONE, buttonHandler: nil)
            return
        }
        
        if !isValidPhone(phone) {
            showMessage(message: ERR_INVALID_PHONE, buttonHandler: nil)
            return
        }
        
        guard let _ = imageView.image else {
            showMessage(message: ERR_NO_PHOTO, buttonHandler: nil)
            return
        }
        
        //if phone is valid, attempt to sign up
        print("email: \(email), password: \(password), phone: \(phone)")
        guard let _ = fetchUserByEmail(email) else {
            //no user exist in db, email available for signup
            saveUser(email, password, phone, imageView.image?.pngData())
            return
        }
        
        showMessage(message: ERR_USER_EXISTS, buttonHandler: nil)
    }
    
}
