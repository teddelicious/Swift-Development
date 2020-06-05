//
//  RandomPersonViewController.swift
//  LoveInCovid
//
//  Created by Parrot on 2020-06-02.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class RandomPersonViewController: UIViewController, AVAudioPlayerDelegate {
    
    // ----------
    // MARK: Outlets
    // ----------
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    //MARK: Variables
    var selectedGender: String?
    var matches: [Person] = []
    var matchIndex = 0
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var timer: Timer?
    var currentLeftSwipes = 0
    let MAX_LEFT_SWIPES = 3
    
    // ----------
    // MARK: IOS Lifecycle functions
    // ----------
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedGender)
//        showPerson()
        if self.matches.count == 0 {
            getRandomPerson() {
                self.getNextMatch()
            }
        }
    }
    
    // ----------
    // MARK: Actions
    // ----------
    @IBAction func chatDebugButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueChat", sender: self)
    }
    
    @IBAction func onSwipeRight(_ sender: Any) {
        print("interested")
        loadAudio(fileName: "swipe1")
        self.audioPlayer.play()
        notifyPerson()
    }
    
    @IBAction func onSwipeLeft(_ sender: Any) {
        if self.currentLeftSwipes < self.MAX_LEFT_SWIPES {
            print("no interested")
            loadAudio(fileName: "swipe2")
            self.audioPlayer.play()
            self.currentLeftSwipes += 1
            getNextMatch()
        }
        if self.currentLeftSwipes == self.MAX_LEFT_SWIPES {
            //start timer
            var count = 10
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                self.resultsLabel.isHidden = false
                self.resultsLabel.text = "\(count)s Left until you can swipe left"
                count = count - 1
                if count == 0 {
                    self.currentLeftSwipes = 0
                    self.resultsLabel.isHidden = true
                    timer.invalidate()
                }
            }
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToRandomPersonController(segue: UIStoryboardSegue) {
        print("unwinding")
    }
    
    // ----------
    // MARK: Helper Functions
    // ----------
    
    func loadAudio(fileName: String) {
        let path = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: path!)
            self.audioPlayer.delegate = self
        } catch {
            print("cannot open file")
            print(error)
        }
    }
    
    func notifyPerson() {
        //1 for like, -1 for dislike, 0 for maybe
        let responseProbability = [1, -1, 0]
        let response = responseProbability[Int.random(in: responseProbability.indices)]
        switch(response) {
        case 1:
            performSegue(withIdentifier: "segueChat", sender: self)
        case -1:
            //alert box
            let alert = UIAlertController(title: "Notice", message: "We are so sorry, you two were not a match. Loading a new match for you.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) {
                _ in
                self.getNextMatch()
            })
            self.present(alert, animated: true, completion: nil)
        default:
            //maybe - upload image
            performSegue(withIdentifier: "segueUploadPhoto", sender: self)
        }
    }
    
//    func showPerson() {
//        self.nameLabel.text = "Jane Smith"
//        self.ageLabel.text = "25"
//        self.photoImageView.image = UIImage(named:"41")
//    }

    func getRandomPerson(callback: @escaping () -> ()) {
        var url = "https://randomuser.me/api/?noinfo&results=5"
        if let gender = self.selectedGender {
            if gender != "Either" {
                url = "https://randomuser.me/api/?noinfo&gender=\(gender)&results=5"
            }
        }
        
        print(url)
        
        Alamofire.request(url).responseJSON {
            (response) in
            let data = response.data
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    print(json)
                    let results = json["results"] as? [[String: Any]] ?? []
                    for single in results {
                        let nameData = single["name"] as? [String: Any]
                        let dobData = single["dob"] as? [String: Any]
                        let pictureData = single["picture"] as? [String: Any]
                        print(nameData)
                        print(dobData)
                        print(pictureData)
                        let fullName = (nameData!["first"] as? String)! + " " + (nameData!["last"] as? String)!
                        let age = dobData!["age"] as? Int
                        let imgUrl = pictureData!["large"] as? String
                        self.matches.append(Person(name: fullName, age: age, photo: imgUrl))
                    }
                    callback()
                }
            }catch {
                print(error)
            }
        }
    }
    
    func getNextMatch() {
        //show person data
        self.nameLabel.text = self.matches[self.matchIndex].name
        self.ageLabel.text = self.matches[self.matchIndex].age?.description
        let data = try? Data(contentsOf: URL(string: self.matches[self.matchIndex].photo!)!)
        
        if let data = data {
            self.photoImageView.image = UIImage(data: data)
        }
        self.matchIndex += 1
        if self.matchIndex == self.matches.count {
            self.matches.removeAll()
            getRandomPerson() {}
            self.matchIndex = 0
        }

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
