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
        self.questionNums = Array(0...(GAME_OVER*getDiffRoundCount()-1)).shuffled()
        print(self.questionNums)
    }
    
    func start() {
        while(self.currentRound < self.GAME_OVER) {
            //handle question prompt & answer
            let index = self.currentQuestion + getDiffRoundCount() * self.currentRound
            print("Round: \(self.currentRound + 1), Question: \(self.currentQuestion + 1)")
            let questionSet = QuestionSet(num: self.questionNums[index])
            
            //prompt question & check for correct answer
            repeat {
                questionSet.prompt()
            }while (!questionSet.confirmAnswer())
            if (questionSet.isAnswerCorrect()) {
                print("You are correct!")
                print("You currently hold a total of $\(getCurrentMoney())")
                self.currentQuestion += 1
            }else{
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
                }
                
                self.currentRound += 1
                self.currentQuestion = 0
            }
            self.correctCount += 1
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
    
    func getCurrentMoney() -> Double {
        if (self.difficulty == 0) {
            return EasyMoney.allCases[self.correctCount].rawValue
        }
        return HardMoney.allCases[self.correctCount].rawValue
        
    }
    
}
