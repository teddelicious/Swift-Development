//
//  ViewController.swift
//  LoveInCovid
//
//  Created by Parrot on 2020-06-02.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Variables
    var responses: [String] = []
    var responseIndex = 0
    var chatMessages:[String] = []
    
    // ----------
    // MARK: Outlets
    // ----------
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var chatbox: UITextField!
    
    // ----------
    // MARK: IOS Lifecycle Functions
    // ----------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        loadResponses()
    }
    
    //MARK: Functions
    func loadResponses() {
        // load the json file here
        guard let file = Bundle.main.path(forResource: "responses", ofType: "json") else {
            print("Cannot find file")
            return
        }
        
        let url = URL(fileURLWithPath: file)
        Alamofire.request(url).responseJSON {
            (response) in
            let data = response.data
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                    for item in json {
                        let response = item["response"] as? String ?? ""
                        let alternate = item["alternate"] as? String ?? ""
                        if alternate.isEmpty {
                            self.responses.append(response)
                        }else {
                            self.responses.append([response, alternate][Int.random(in: 0...1)])
                        }
                    }
                    print(self.responses)
                    self.loadNextResponse()
                }
            }catch {
                print(error)
            }
        }

    }
    
    func loadNextResponse() {
        if self.responseIndex < self.responses.count {
            self.chatMessages.append(self.responses[self.responseIndex])
            self.responseIndex += 1
            tableview.reloadData()
        }
    }
    
    // ----------
    // MARK: Actions
    // ----------
    @IBAction func sendMessage(_ sender: Any) {
        print("mesage sent")
        if let text = chatbox.text {
            if !text.isEmpty {
                self.chatMessages.append(text)
                tableview.reloadData()
                loadNextResponse()
            }
        }
        
    }
    
    
    
    // ----------
    // MARK: Table View Functions
    // ----------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cellName = self.chatMessages.count % 2 == 0 ? "personCell" : "userCell"
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
//        if indexPath.row % 2 == 0 {
//            var cell = tableView.dequeueReusableCell(withIdentifier: "personCell") as? PersonCell
//            cell?.textLabel?.text = self.chatMessages[indexPath.row]
//            return cell!
//        }
//        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell
//        cell?.textLabel?.text = self.chatMessages[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        if indexPath.row % 2 == 0 {
            cell.textLabel?.textAlignment = .left
        }else {
            cell.textLabel?.textAlignment = .right
        }
        
        cell.textLabel?.text = self.chatMessages[indexPath.row]
        
        return cell
    }

}

