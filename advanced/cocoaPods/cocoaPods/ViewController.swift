//
//  ViewController.swift
//  cocoaPods
//
//  Created by John Lin on 2020-05-26.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let path = Bundle.main.path(forResource: "person", ofType: "json") else {
            print("cannot find file path")
            return
        }
        let url2 = URL(fileURLWithPath: path)
        let url = "https://api.exchangeratesapi.io/latest"
        Alamofire.request(url).responseJSON {
            (response)
            in
            
            print(response.data)
            let data = response.data
            print(String(data: data!, encoding: String.Encoding.utf8))
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(json)
                    let firstName = json["firstName"] as? String ?? "N/A" // give it a default N/A value if not exist
                    if let age = json["age"] as? Int {
                        //do something with age
                    }
                    let interests = json["interests"] as? [String]
                }
            }catch {
                print(error)
            }
        }
    }


}

