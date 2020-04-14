//
//  Game.swift
//  who wants to be a millionaire
//
//  Created by John Lin on 2020-03-12.
//  Copyright © 2020 John Lin. All rights reserved.
//

import Foundation

class Game {
    
    //instance constants
    let name: String
    let difficulty: Int
    var questionNums: [Int] = []
    
    //instance variables
    var currentRound: Int
    var currentQuestion: Int
    var correctCount: Int
    var lifeLines: LifeLine
    var isLifeLineAvailable: Bool
    
    //predefined constants
    let GAME_OVER: Int = 3
    let EASY_QUESTION_COUNT: Int = 3
    let HARD_QUESTION_COUNT: Int = 5
    
    init(difficulty: Int, name: String) {
        self.name = name
        self.difficulty = difficulty
        self.currentRound = 0
        self.currentQuestion = 0
        self.correctCount = 0
        if (difficulty == 0) {
            self.isLifeLineAvailable = true
        }else{
            self.isLifeLineAvailable = false
        }
        self.lifeLines = LifeLine()
        self.questionNums = Array(0...(GAME_OVER*getDiffRoundCount()-1)).shuffled()
//        print(self.questionNums)
    }
    
    func start() {
        print("Hello \(self.name), welcome to who wants to be a millionaire!")
        while(self.currentRound < self.GAME_OVER) {
            //handle question prompt & answer
            let index = self.currentQuestion + getDiffRoundCount() * self.currentRound
            print("Round: \(self.currentRound + 1), Question: \(self.currentQuestion + 1)")
            if (self.isLifeLineAvailable) {
                print("Life lines are available. You may press (L) at any time to use a life line.")
            }
            let questionSet = QuestionSet(num: self.questionNums[index])
            
            //prompt question & check for correct answer
            repeat {
                questionSet.prompt()
                if self.isLifeLineAvailable && questionSet.requestHelp {
                    questionSet.setHint(hint: self.lifeLines.prompt(correctAnswerNum: questionSet.correctAnswerNum, choices: questionSet.choices))
                }else if !self.isLifeLineAvailable && questionSet.requestHelp {
                    print("Life line unavailable.")
                    questionSet.requestHelp = false
                }
            }while (!questionSet.confirmAnswer())
            if (!questionSet.requestHelp && questionSet.isAnswerCorrect()) {
                print("You are correct!")
                print("You currently hold a total of $\(getCurrentMoney())")
                self.currentQuestion += 1
            }else if (!questionSet.requestHelp){
                print("You are incorrect! Game Over.")
                return
            }
            
            //check if round needs to be incremented
            if (isRoundOver()) {
                
                //prompt safety (to walk away)
                if (self.currentRound == self.GAME_OVER - 1) {
                    print("Congratulations! You are a millionaire!")
                    return
                } else if (promptWalkAway()) {
                    print("Congratulations! You've walked away with $\(getCurrentMoney())")
                    return
                }
                
                self.currentRound += 1
                self.currentQuestion = 0
                self.isLifeLineAvailable = true
            }
            
            if (!questionSet.requestHelp) {
                self.correctCount += 1
            }
        }
    }

    func getDiffRoundCount() -> Int {
        if (self.difficulty == 0) {
            return self.EASY_QUESTION_COUNT
        }
        return self.HARD_QUESTION_COUNT
    }
    
    
    func isRoundOver() -> Bool {
        return self.currentQuestion > 0 && self.currentQuestion % getDiffRoundCount() == 0
    }
    
    func promptWalkAway() -> Bool {
        print("Would you like to walk away with $\(getCurrentMoney())?")
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
    
    func getCurrentMoney() -> String {
        if (self.difficulty == 0) {
            return String(format: "%.2f", EasyMoney.allCases[self.correctCount].rawValue)
        }
        return String(format: "%.2f", HardMoney.allCases[self.correctCount].rawValue)
        
    }
    
}
