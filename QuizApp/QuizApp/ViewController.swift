//
//  ViewController.swift
//  QuizApp
//
//  Created by Parrot on 2020-03-31.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit


// 1. Display a question
// 2. Detect what button was pressed (TRUE/FALSE)
// 3. Check if answer is correct / incorrect
// 4. Update the score
// 5. Show next question
// 6. Repeat until all questions are asked
// 7. At end of game, show game over in popup box


class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var questionBank: [Question] = []
    var questionIndex: Int = 0
    var score: Int = 0
    
    // MARK: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadQuestions()
        loadCurrentQuestion()
        
        // sets up word wrapping on the question label
        questionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    
    func loadQuestions() {
        self.questionBank = []
        self.questionBank.append(
            Question(question: "Buying toilet paper prevents COVID-19", answer: false))
        self.questionBank.append(
            Question(question: "Wearing a mask protects you from COVID-19", answer: false))
        self.questionBank.append(
            Question(question: "United States has the most cases of COVID-19", answer: true))
        self.questionBank.append(
            Question(question: "It is easy to get a COVID-19 test", answer: false))
        
        self.questionBank.shuffle()
    }
    
    func loadCurrentQuestion() {
        if (self.questionIndex < self.questionBank.count) {
            self.questionNumberLabel.text = "Question \(self.questionIndex + 1)"
            self.questionLabel.text = self.questionBank[self.questionIndex].question
        }else{
            //game over
            let alert = UIAlertController(title: "Game Over", message: "You have a score of \(self.score) out of \(self.questionBank.count). Restart?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
                self.loadQuestions()
                self.questionIndex = 0
                self.score = 0
                self.loadCurrentQuestion()}))
            self.present(alert, animated: true)
        }
    }
    
    // MARK: Actions
    
    @IBAction func buttonPressed(_ sender: Any) {
        let answer: Bool?
        switch((sender as AnyObject).tag) {
        case 0:
            answer = false
        case 1:
            answer = true
        default:
            answer = nil
        }
        
        
        if self.questionIndex < self.questionBank.count {
            if self.questionBank[self.questionIndex].answer == answer! {
                self.answerLabel.text = "Correct"
                self.score += 1
            }else {
                self.answerLabel.text = "Wrong"
            }
            
            self.scoreLabel.text = "Score: \(self.score)"
            self.questionIndex += 1
            loadCurrentQuestion()
        }
    }
}

