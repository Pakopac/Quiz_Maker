//
//  DoQuizzViewController.swift
//  Client
//
//  Created by Lilian on 08/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class DoQuizzViewController: UIViewController {
    
    var id_quizz = 0
    var count_Question = 0
    var score = 0
    let themeLabel = UILabel()
    let question = UILabel()
    let answer1 = UIButton()
    let answer2 = UIButton()
    let answer3 = UIButton()
    let answer4 = UIButton()
    let buttonNext = UIButton()
    let nView = UIView()
    var jsonAllQuestion = [[String : Any]]()
    var jsonQuestionFilter = [[String : Any]]()
    var jsonAllAnswer = [[String : Any]]()
    var jsonAnswerFilter = [[String : Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

    
        themeLabel.textAlignment = .center
        themeLabel.sizeToFit()
        themeLabel.font = themeLabel.font.withSize(30)
        
        question.textAlignment = .center
        question.sizeToFit()
        question.font = themeLabel.font.withSize(20)
        
        answer1.layer.cornerRadius = 10
        answer1.addTarget(self, action: #selector(checkAnswer1), for: .touchUpInside)
        answer1.backgroundColor = UIColor.black
        
        answer2.layer.cornerRadius = 10
        answer2.addTarget(self, action: #selector(checkAnswer2), for: .touchUpInside)
        answer2.backgroundColor = UIColor.black
        
        answer3.layer.cornerRadius = 10
        answer3.addTarget(self, action: #selector(checkAnswer3), for: .touchUpInside)
        answer3.backgroundColor = UIColor.black
        
        answer4.layer.cornerRadius = 10
        answer4.addTarget(self, action: #selector(checkAnswer4), for: .touchUpInside)
        answer4.backgroundColor = UIColor.black
        
        buttonNext.setTitle("Next Question",for: .normal)
        buttonNext.layer.cornerRadius = 10
        buttonNext.backgroundColor = UIColor.black
        buttonNext.isHidden = true
        
        buttonNext.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 1, height: 12, width: 12)
        nView.grid(child: themeLabel, x: 0, y: 0.5, height: 0.5, width: 12)
        nView.grid(child: question, x: 2, y: 2, height: 0.5, width: 8)
        nView.grid(child: answer1, x: 1.5, y: 3, height: 0.5, width: 4)
        nView.grid(child: answer2, x: 6.5, y: 3, height: 0.5, width: 4)
        nView.grid(child: answer3, x: 1.5, y: 4, height: 0.5, width: 4)
        nView.grid(child: answer4, x: 6.5, y: 4, height: 0.5, width: 4)
        nView.grid(child: buttonNext, x: 3, y: 6, height: 0.5, width: 6)
        getQuizz()
        getAllQuestions()
    }
    
    func getQuizz(){
        let url = URL(string: "http://127.0.0.1:8000/api/quizzes/" + String(id_quizz))!
           var request = URLRequest(url: url)
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.httpMethod = "GET"
             
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               do {
                   let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                   DispatchQueue.main.async (execute: {
                       self.themeLabel.text = responseJson["name"] as! String
                   })
               }
               catch let error as NSError{
                   print(error)
               }
           }
           task.resume()
    }
    
    func getAllQuestions(){
        let url = URL(string: "http://127.0.0.1:8000/api/questions/")!
                  var request = URLRequest(url: url)
                  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                  request.httpMethod = "GET"
                    
                  let task = URLSession.shared.dataTask(with: request) { data, response, error in
                      do {
                          let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        
                          self.jsonAllQuestion = responseJson["hydra:member"] as! [[String : Any]]
                          self.jsonQuestionFilter = self.jsonAllQuestion.filter{ $0["quizId"] as! String == "/api/quizzes/" + String(self.id_quizz)}
                          DispatchQueue.main.async (execute: {
                            self.getQuestion(idJson: self.count_Question)
                          })
                      }
                      catch let error as NSError{
                          print(error)
                      }
                  }
                  task.resume()
    }
    
    func getQuestion(idJson: Int){
        question.text = self.jsonQuestionFilter[idJson]["content"] as! String
        let questionId = self.jsonQuestionFilter[idJson]["id"] as! Int
        getAnswers(questionId: questionId)
    }
    
    func getAnswers(questionId: Int){
         let url = URL(string: "http://127.0.0.1:8000/api/answers/")!
         var request = URLRequest(url: url)
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         request.httpMethod = "GET"
           
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
             do {
                 let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
       
                 self.jsonAllAnswer = responseJson["hydra:member"] as! [[String : Any]]
                 self.jsonAnswerFilter = self.jsonAllAnswer.filter{ $0["questionId"] as! String == "/api/questions/" + String(questionId)}
              
                   for item in self.jsonAnswerFilter{
               
                   }
                 DispatchQueue.main.async (execute: {
                    self.answer1.setTitle(self.jsonAnswerFilter[0]["content"] as! String, for: .normal)
                    self.answer2.setTitle(self.jsonAnswerFilter[1]["content"] as! String, for: .normal)
                    self.answer3.setTitle(self.jsonAnswerFilter[2]["content"] as! String, for: .normal)
                    self.answer4.setTitle(self.jsonAnswerFilter[3]["content"] as! String, for: .normal)
                 })
             }
             catch let error as NSError{
                 print(error)
             }
         }
         task.resume()
    }
    
    @objc func nextQuestion(){
        buttonNext.isHidden = true
        if(count_Question < jsonQuestionFilter.count - 1){
            count_Question = count_Question + 1
             getQuestion(idJson: count_Question)
             answer1.backgroundColor = UIColor.black
             answer2.backgroundColor = UIColor.black
             answer3.backgroundColor = UIColor.black
             answer4.backgroundColor = UIColor.black
        }
        else{
            print(score)
        }
        if(count_Question == jsonQuestionFilter.count - 1){
            buttonNext.setTitle("Finish", for: .normal)
        }
    }
    
    @objc func checkAnswer1(){
        if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int != 0){
            answer1.backgroundColor = UIColor.red
        }
        else{
            score = score + 1
        }
        colorGoodAnswer()
        buttonNext.isHidden = false
    }
    
    @objc func checkAnswer2(){
        if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int != 1){
            answer2.backgroundColor = UIColor.red
        }
        else{
             score = score + 1
         }
        colorGoodAnswer()
        buttonNext.isHidden = false
    }
    
    @objc func checkAnswer3(){
        if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int != 2){
            answer3.backgroundColor = UIColor.red
        }
        else{
            score = score + 1
        }
        colorGoodAnswer()
        buttonNext.isHidden = false
    }
    
    @objc func checkAnswer4(){
        if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int != 3){
            answer4.backgroundColor = UIColor.red
        }
        else{
            score = score + 1
        }
        colorGoodAnswer()
        buttonNext.isHidden = false
    }
    
    func colorGoodAnswer(){
         if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int == 0){
            answer1.backgroundColor = UIColor.green
        }
        else if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int == 1){
            answer2.backgroundColor = UIColor.green
        }
        else if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int == 2){
            answer3.backgroundColor = UIColor.green
        }
        else if(jsonQuestionFilter[count_Question]["trueAnswer"] as! Int == 3){
            answer4.backgroundColor = UIColor.green
        }
    }

}
