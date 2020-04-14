//
//  Question.swift
//  QuizApp
//
//  Created by John Lin on 2020-03-31.
//  Copyright © 2020 Parrot. All rights reserved.
//

import Foundation

class Question {
    var question: String = ""
    var answer: Bool = true
    
    init(question: String, answer: Bool) {
        self.question = question
        self.answer = answer
    }
}
