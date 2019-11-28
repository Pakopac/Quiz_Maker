//
//  CreateQuestionViewController.swift
//  Client
//
//  Created by SUP'Internet 11 on 28/11/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

let nView = UIView()
let question = UITextField()
let answer1 = UITextField()
let answer2 = UITextField()
let answer3 = UITextField()
let answer4 = UITextField()
let buttonNext = UIButton()
let buttonFinish = UIButton()

class CreateQuestionViewController: UIViewController {

    override func viewDidLoad() {
        
        question.backgroundColor = UIColor.gray
        question.textColor = UIColor.white
        question.placeholder = "Question"
        question.layer.cornerRadius = 10
        question.setLeftPaddingPoints(10)
        //question.delegate = self as! UITextFieldDelegate
        question.returnKeyType = UIReturnKeyType.next
        
        answer1.backgroundColor = UIColor.gray
        answer1.textColor = UIColor.white
        answer1.placeholder = "Answer 1"
        answer1.layer.cornerRadius = 10
        answer1.setLeftPaddingPoints(10)
        //answer1.delegate = self as! UITextFieldDelegate
        answer1.returnKeyType = UIReturnKeyType.next
        
        answer2.backgroundColor = UIColor.gray
        answer2.placeholder = "Answer 2"
        answer2.textColor = UIColor.white
        answer2.layer.cornerRadius = 10
        answer2.setLeftPaddingPoints(10)
        //answer2.delegate = self as! UITextFieldDelegate
        answer2.returnKeyType = UIReturnKeyType.next
        
        answer3.backgroundColor = UIColor.gray
        answer3.placeholder = "Answer 3"
        answer3.textColor = UIColor.white
        answer3.layer.cornerRadius = 10
        answer3.setLeftPaddingPoints(10)
        //answer3.delegate = self as! UITextFieldDelegate
        answer3.returnKeyType = UIReturnKeyType.next
        
        answer4.backgroundColor = UIColor.gray
        answer4.placeholder = "Answer 4"
        answer4.textColor = UIColor.white
        answer4.layer.cornerRadius = 10
        answer4.setLeftPaddingPoints(10)
        //answer4.delegate = self as! UITextFieldDelegate
        answer4.returnKeyType = UIReturnKeyType.done
        
        buttonNext.setTitle("Continue",for: .normal)
        buttonNext.layer.cornerRadius = 10
        buttonNext.backgroundColor = UIColor.black
        
        buttonNext.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        
        buttonFinish.setTitle("Finish",for: .normal)
        buttonFinish.layer.cornerRadius = 10
        buttonFinish.backgroundColor = UIColor.black
        
        buttonFinish.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        super.viewDidLoad()
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: question, x: 2, y: 1, height: 1.5, width: 8)
        nView.grid(child: answer1, x: 1.5, y: 3, height: 1.5, width: 4)
        nView.grid(child: answer2, x: 6.5, y: 3, height: 1.5, width: 4)
        nView.grid(child: answer3, x: 1.5, y: 5, height: 1.5, width: 4)
        nView.grid(child: answer4, x: 6.5, y: 5, height: 1.5, width: 4)
        nView.grid(child: buttonNext, x: 3, y: 7, height: 1.5, width: 3)
        nView.grid(child: buttonFinish, x: 6.5, y: 7, height: 1.5, width: 3)

        // Do any additional setup after loading the view.
    }
    
    @objc func nextQuestion() {
        let json: [String: Any] = [
            "content": answer1.text!,
            "questionId": 1
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "http://127.0.0.1:8000/api/answers")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                print(data)
            }
            catch let error as NSError{
                print(error)
            }
    }
    task.resume()
    }
    
    @objc func finish(){
        print("finish")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
