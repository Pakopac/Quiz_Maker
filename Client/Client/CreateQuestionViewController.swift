//
//  CreateQuestionViewController.swift
//  Client
//
//  Created by SUP'Internet 11 on 28/11/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

let themeLabel = UILabel()
let question = UITextField()
let answer1 = UITextField()
let answer2 = UITextField()
let answer3 = UITextField()
let answer4 = UITextField()
let inputCorrectAnswer = UITextField()
let buttonNext = UIButton()
let buttonFinish = UIButton()

class CreateQuestionViewController: UIViewController {
    
    let nView = UIView()
    var theme = ""
    var id_quizz = 0
    var author = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.gray
        
        print(theme,id_quizz,author)
        
        themeLabel.text = theme
        themeLabel.textAlignment = .center
        themeLabel.sizeToFit()
        themeLabel.font = themeLabel.font.withSize(30)
        
        question.backgroundColor = UIColor.white
        question.placeholder = "Question"
        question.layer.cornerRadius = 10
        question.setLeftPaddingPoints(10)
        //question.delegate = self as! UITextFieldDelegate
        question.returnKeyType = UIReturnKeyType.next
        
        answer1.backgroundColor = UIColor.white
        answer1.placeholder = "Answer 1"
        answer1.layer.cornerRadius = 10
        answer1.setLeftPaddingPoints(10)
        //answer1.delegate = self as! UITextFieldDelegate
        answer1.returnKeyType = UIReturnKeyType.next
        
        answer2.backgroundColor = UIColor.white
        answer2.placeholder = "Answer 2"
        answer2.layer.cornerRadius = 10
        answer2.setLeftPaddingPoints(10)
        //answer2.delegate = self as! UITextFieldDelegate
        answer2.returnKeyType = UIReturnKeyType.next
        
        answer3.backgroundColor = UIColor.white
        answer3.placeholder = "Answer 3"
        answer3.layer.cornerRadius = 10
        answer3.setLeftPaddingPoints(10)
        //answer3.delegate = self as! UITextFieldDelegate
        answer3.returnKeyType = UIReturnKeyType.next
        
        answer4.backgroundColor = UIColor.white
        answer4.placeholder = "Answer 4"
        answer4.layer.cornerRadius = 10
        answer4.setLeftPaddingPoints(10)
        //answer4.delegate = self as! UITextFieldDelegate
        answer4.returnKeyType = UIReturnKeyType.done
        
        inputCorrectAnswer.backgroundColor = UIColor.white
        inputCorrectAnswer.placeholder = "Correct Answer"
        inputCorrectAnswer.layer.cornerRadius = 10
        inputCorrectAnswer.setLeftPaddingPoints(10)
        //answer4.delegate = self as! UITextFieldDelegate
        inputCorrectAnswer.returnKeyType = UIReturnKeyType.done
        inputCorrectAnswer.textAlignment = .center
        
        
        buttonNext.setTitle("Validate Question",for: .normal)
        buttonNext.layer.cornerRadius = 10
        buttonNext.backgroundColor = UIColor.black
        
        buttonNext.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        
        buttonFinish.setTitle("Finish Quizz",for: .normal)
        buttonFinish.layer.cornerRadius = 10
        buttonFinish.backgroundColor = UIColor.black
        
        buttonFinish.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 1, height: 12, width: 12)
        nView.grid(child: themeLabel, x: 0, y: 0.5, height: 0.5, width: 12)
        nView.grid(child: question, x: 2, y: 2, height: 0.5, width: 8)
        nView.grid(child: answer1, x: 1.5, y: 3, height: 0.5, width: 4)
        nView.grid(child: answer2, x: 6.5, y: 3, height: 0.5, width: 4)
        nView.grid(child: answer3, x: 1.5, y: 4, height: 0.5, width: 4)
        nView.grid(child: answer4, x: 6.5, y: 4, height: 0.5, width: 4)
        nView.grid(child: inputCorrectAnswer, x: 4, y: 5, height: 0.5, width: 4)
        nView.grid(child: buttonNext, x: 3, y: 6, height: 0.5, width: 6)
        nView.grid(child: buttonFinish, x: 3, y: 7, height: 0.5, width: 6)

        // Do any additional setup after loading the view.
    }
    
    @objc func nextQuestion() {
        if(question.text != "" && answer1.text != "" && answer2.text != "" && answer3.text != "" && answer4.text != "" && inputCorrectAnswer.text != ""){
            if(inputCorrectAnswer.text == "1" || inputCorrectAnswer.text == "2" || inputCorrectAnswer.text == "3" || inputCorrectAnswer.text == "4"){
                postQuestion()
            }
            else{
                self.showToast(message : "Correct answer must be 1, 2, 3 or 4", color: UIColor.red)
            }
        }
        else{
            self.showToast(message : "All fields must be filled", color: UIColor.red)
        }
    }
    
    @objc func postAnswer(answer_input: UITextField, question_number: String){
             let json: [String:Any] = [
                "content": answer_input.text!,
                 "questionId": "/api/questions/" + question_number
             ]
             
             let jsonData = try? JSONSerialization.data(withJSONObject: json)
             
             let url = URL(string: "http://127.0.0.1:8000/api/answers")!
             var request = URLRequest(url: url)
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             request.httpMethod = "POST"
             request.httpBody = jsonData
             
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 do {
                     let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                     print(responseJSON)
                 }
                 catch let error as NSError{
                     print(error)
                 }
         }
         task.resume()
    }
    
    @objc func postQuestion(){
             let json: [String:Any] = [
                "content": question.text!,
                "trueAnswer": Int(inputCorrectAnswer.text!)! - 1,
                "quizId": "/api/quizzes/" + String(id_quizz),
             ]
             
             let jsonData = try? JSONSerialization.data(withJSONObject: json)
             
             let url = URL(string: "http://127.0.0.1:8000/api/questions")!
             var request = URLRequest(url: url)
             request.setValue("application/json", forHTTPHeaderField: "Content-Type")
             request.httpMethod = "POST"
             request.httpBody = jsonData
             
             let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 do {
                     let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    let question_number = responseJSON["id"] as! Int
                    
                    self.postAnswer(answer_input: answer1,question_number: String(question_number))
                    self.postAnswer(answer_input: answer2,question_number: String(question_number))
                    self.postAnswer(answer_input: answer3,question_number: String(question_number))
                    self.postAnswer(answer_input: answer4,question_number: String(question_number))
                    
                    DispatchQueue.main.async(execute: {
                       question.text = ""
                       answer1.text = ""
                       answer2.text = ""
                       answer3.text = ""
                       answer4.text = ""
                       inputCorrectAnswer.text = ""
                        self.showToast(message : "Question succefully register", color: UIColor.green)
                    })
                 }
                 catch let error as NSError{
                     print(error)
                 }
         }
         task.resume()
    }
    
    @objc func finish(){
        let alert = UIAlertController(title: "Did you finish your quizz?", message: "", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in self.performSegue(withIdentifier: "toQuizzFinished", sender: nil)}))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        print("finish")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showToast(message : String, color : UIColor) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = color
        toastLabel.textColor = UIColor.white
        toastLabel.font = toastLabel.font.withSize(15)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    

}
