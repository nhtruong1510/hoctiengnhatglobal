//
//  QuizModel.swift
//  hoctiengnhatglobal
//
//  Created by Huu Truong Nguyen on 11/3/21.
//

import Foundation

class DetailQuiz {
    var id: Int = 0
    var level: String = ""
    var question: String = ""
    var division: Int = 0
    var answer1: String = ""
    var answer2: String = ""
    var answer3: String = ""
    var answer4: String = ""
    var correctAnswer: String = ""
    var idDescription: Int = 0
    var doHoanThanh: Int = 0
    
    init(id: Int, level: String, question: String, division: Int, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: String, idDescription: Int, doHoanThanh: Int){
        self.id = id
        self.level = level
        self.question = question
        self.division = division
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAnswer = correctAnswer
        self.idDescription = idDescription
        self.doHoanThanh = doHoanThanh
    }
}

class HeaderQuiz {
    var id: Int = 0
    var level: String = ""
    var description: String = ""
    var idDescription: Int = 0
    var division: Int = 0
    
    init(id: Int, level: String, division: Int, description: String, idDescription: Int){
        self.id = id
        self.level = level
        self.division = division
        self.description = description
        self.idDescription = idDescription
    }
}

