//
//  ViewController.swift
//  GesturesTest
//
//  Created by John Lin on 2020-05-27.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var txtResult: UITextView!
    @IBOutlet weak var lastView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapHandler(sender:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        lastView.isUserInteractionEnabled = true
        lastView.addGestureRecognizer(doubleTapRecognizer)
    }
    @objc
    func doubleTapHandler(sender: UIGestureRecognizer) {
        let debugMsg = "double tap recognized"
        print(debugMsg)
        txtResult.text = debugMsg
    }
    
    @IBAction func onTapHandler(_ sender: Any) {
        let debugMsg = "tap recognized"
        print(debugMsg)
        txtResult.text = debugMsg
    }
    
    @IBAction func onSwipeHandler(_ sender: Any) {
        let debugMsg = "swipe recognized"
        print(debugMsg)
        txtResult.text = debugMsg
    }
    
    
    @IBAction func onPinchHandler(_ sender: Any) {
        let debugMsg = "pinch recognized"
        print(debugMsg)
        txtResult.text = debugMsg
    }
    
    //MARK: Shake detector
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        let debugMsg = "start shaking"
        print(debugMsg)
        txtResult.text = debugMsg
        let i = Double(Int.random(in: 0...255))
        let j = Double(Int.random(in: 0...255))
        let k = Double(Int.random(in: 0...255))
        let color = UIColor(red: CGFloat(i/255.0), green: CGFloat(j/255.0), blue: CGFloat(k/255.0), alpha: 1.0)
        self.lastView.backgroundColor = color
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        let debugMsg = "done shaking"
        print(debugMsg)
        txtResult.text = debugMsg
    }
    

}

