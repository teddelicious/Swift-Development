//
//  QuestionSet.swift
//  who wants to be a millionaire
//
//  Created by John Lin on 2020-03-16.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class QuestionSet {
    let question: Question
    let correctAnswerNum: Int
    let choices:[Int]
    var selectedChoice: Int? = nil
    
    init(num: Int) {
        self.question = Question.allCases[num]
        let setIndex = 4 * num
        self.correctAnswerNum = setIndex
        //4 options per question set; randomized order
        self.choices = [setIndex, setIndex+1, setIndex+2, setIndex+3].shuffled()
        print("num: \(num); question: \(self.question); answer: \(Answer.allCases[self.correctAnswerNum]); choices: \(self.choices)")
    }
    
    
    func prompt() {
        var input: String? = nil
        while true {
            print(self.question.rawValue)
            print(getChoiceString())
            input = readLine()
            if let x = input {
                switch (x.uppercased()) {
                case "A":
                    setSelectedChoice(selected: 0)
                    return
                case "B":
                    setSelectedChoice(selected: 1)
                    return
                case "C":
                    setSelectedChoice(selected: 2)
                    return
                case "D":
                    setSelectedChoice(selected: 3)
                    return
                default:
                    print("Invalid option. Please select a valid choice.")
                    setSelectedChoice(selected: nil)
                }
            }
        }
    }
    
    func setSelectedChoice(selected: Int?) {
        if let value = selected {
            self.selectedChoice = self.choices[value]
        }
    }
    
    func getChoiceString() -> String {
        return "A. \(Answer.allCases[choices[0]].rawValue)\tB. \(Answer.allCases[choices[1]].rawValue)\nC. \(Answer.allCases[choices[2]].rawValue)\tD. \(Answer.allCases[choices[3]].rawValue)"
    }
    
    func isAnswerCorrect() -> Bool {
//        print("correct answer num: \(self.correctAnswerNum); selectedChoice: \(self.selectedChoice)")
        return self.correctAnswerNum == self.selectedChoice!
    }
    
    func confirmAnswer() -> Bool {
        print("is '\(Answer.allCases[self.correctAnswerNum].rawValue)' your final answer?")
        print("(Y)es or (N)o")
        var input: String? = nil
        while true {
            input = readLine()
            if let x = input {
                switch (x.uppercased()) {
                case "Y":
                    return true
                case "N":
                    return false
                default:
                    print("Invalid option. Please indicate (Y)es or (N)o.")
                }
            }
        }
    }
}
