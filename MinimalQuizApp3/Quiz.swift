//
//  Quiz.swift
//  MinimalQuizApp3
//
//  Created by 竹村信一 on 2021/02/24.
//

import Foundation

struct Quiz:Hashable{
    var question:String
    var choices:[String]
    var answer:Int
    var quizList:Set<Quiz>
    
    static var defQuizzes:Set<Quiz>{
        var q = "富士山の標高は？"
        var c = ["3776m","3190m","3193m"]
        var a = 0
        var quiz = Quiz(question: q, choices: c, answer: a)
        quiz.add(quiz: quiz)
        
        q = "渋沢栄一は何円札？"
        c = ["1000円札","5000円札","10000円札"]
        a = 2
        quiz.add(quiz: Quiz(question: q, choices: c, answer: a))
        
        return quiz.quizList
    }
    
    init(question:String,choices:[String],answer:Int){
        self.question = question
        self.choices = choices
        self.answer = answer
        quizList = []
    }
    
    mutating func add(quiz:Quiz){
        quizList.insert(quiz)
    }
    
}


