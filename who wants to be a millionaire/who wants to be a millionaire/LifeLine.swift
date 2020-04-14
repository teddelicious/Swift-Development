//
//  LifeLine.swift
//  who wants to be a millionaire
//
//  Created by John Lin on 2020-03-18.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class LifeLine {
    var availableLifeLines: [String: Bool] = [:]
    var lifeLineStrings: [String: String] = [:]
    let FIFTY_FIFTY = "F"
    let CALL_FRIEND = "C"
    let ASK_AUDIENCE = "A"
    
    init() {
        self.availableLifeLines[FIFTY_FIFTY] = true
        self.availableLifeLines[CALL_FRIEND] = true
        self.availableLifeLines[ASK_AUDIENCE] = true
        
        self.lifeLineStrings[FIFTY_FIFTY] = "Fifty-fifty"
        self.lifeLineStrings[CALL_FRIEND] = "Call A Friend"
        self.lifeLineStrings[ASK_AUDIENCE] = "Ask Audience"
    }
    
    func getAvailableLifeLines() -> String? {
        var output: String? = nil
        for key in self.availableLifeLines.keys {
            if self.availableLifeLines[key]! {
                if (output == nil) {
                    output = "\(key). \(self.lifeLineStrings[key]!)"
                }else{
                    output = output! + "\t\(key). \(self.lifeLineStrings[key]!)"
                }
            }
        }
        
        return output
    }
    
    func prompt(correctAnswerNum: Int, choices: [Int]) -> String?{
        print("You've chosen to use a lifeline.")
        if let x = getAvailableLifeLines() {
            print(x)
        }else{
            print("But you have no more life lines.")
            return nil
        }
        var input: String? = nil
        while true {
            input = readLine()
            if let x = input {
                let xUpper = x.uppercased()
                switch (xUpper) {
                case "F":
                    if self.availableLifeLines[xUpper]! {
                        self.availableLifeLines[xUpper] = false
                        return getFiftyFifty(correctAnswerNum: correctAnswerNum, choices: choices)
                    }
                case "C":
                    if self.availableLifeLines[xUpper]! {
                        self.availableLifeLines[xUpper] = false
                        return getCallFriend(correctAnswerNum: correctAnswerNum, choices: choices)
                    }
                case "A":
                    if self.availableLifeLines[xUpper]! {
                        self.availableLifeLines[xUpper] = false
                        return getAskAudience(correctAnswerNum: correctAnswerNum, choices: choices)
                    }
                default:
                    print("Invalid option. Please select a valid choice.")
                }
            }
        }
    }
    
    func getFiftyFifty(correctAnswerNum: Int, choices: [Int]) -> String {
        var newChoices = choices
        newChoices.remove(at: newChoices.firstIndex(of: correctAnswerNum)!)
        newChoices.shuffle()
        newChoices.removeFirst()
        newChoices.removeFirst()
        newChoices.append(correctAnswerNum)
        
        let output = "The correct answer is either \(Answer.allCases[newChoices[0]].rawValue) or \(Answer.allCases[newChoices[1]].rawValue)"
        return output
    }
    
    func getCallFriend(correctAnswerNum: Int, choices: [Int]) -> String {
        let output = "Your friend says the answer is \(Answer.allCases[correctAnswerNum].rawValue)"
        return output
    }
    
    func getAskAudience(correctAnswerNum: Int, choices: [Int]) -> String {
        let newChoices = choices.shuffled()
        let output = "The audience thinks the answer is \(Answer.allCases[newChoices[0]].rawValue)"
        return output
    }
    
}
