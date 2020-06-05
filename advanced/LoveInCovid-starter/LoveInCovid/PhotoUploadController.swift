//
//  PhotoUploadController.swift
//  LoveInCovid
//
//  Created by John Lin on 2020-06-02.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices
import AVKit

class PhotoUploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
            print("No photo selected")
            return
        }
        picker.dismiss(animated: true)
        if mediaType == String(kUTTypeImage) {
            self.imageView.image = info[.originalImage] as? UIImage
        }
    }
    

    //MARK: Actions
    @IBAction func onChoosePressed(_ sender: Any) {
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
                            print("denied")
                        }
                    }
                case .authorized:
                    self.openGallery()
                default:
                    print("denied")
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
                            print("denied")
                        }
                    }
                case .authorized:
                    self.openCamera()
                default:
                    print("denied")
                }
            })
        }
        
        if alert.actions.count == 0 {
            print("no image option")
        }else {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSendPressed(_ sender: Any) {
        guard let _ = self.imageView.image else {
            print("no image chosen")
            return
        }
        print("dismissing...")
        let alert = UIAlertController(title: nil, message: "Photo sent!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            _ in self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Functions
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
    
}
