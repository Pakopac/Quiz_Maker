//
//  AuthorViewController.swift
//  Client
//
//  Created by Lilian on 06/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class AuthorViewController: UIViewController {
    
    let nView = UIView()
    let button = UIButton()
    let input = UITextField()
    var theme = ""
    var id_quizz = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        let titleView = UILabel()
        titleView.text = "Enter your name"
        titleView.textAlignment = .center
        titleView.font = titleView.font.withSize(30)
        
        input.backgroundColor = UIColor.white
        input.placeholder = "name"
        input.layer.cornerRadius = 10
        input.setLeftPaddingPoints(10)
        //answer1.delegate = self as! UITextFieldDelegate
        input.returnKeyType = UIReturnKeyType.next
        
        button.setTitle("Enter",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
       
        button.addTarget(self, action: #selector(redirectToQuizz), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: titleView, x: 2, y: 1, height: 4, width: 8)
        nView.grid(child: input, x: 2, y: 4, height: 1.5, width: 8)
        nView.grid(child: button, x: 4, y: 6, height: 1.5, width: 4)
        
    }
    
    @objc func redirectToQuizz() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        print(formatter.string(from: date))
        
        if(input.text != ""){
            let json: [String:Any] = [
                        "name": theme,
                        "author": input.text,
                        "date": formatter.string(from: date)
                     
                    ]
                    
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    let url = URL(string: "http://127.0.0.1:8000/api/quizzes")!
                    var request = URLRequest(url: url)
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpMethod = "POST"
                    request.httpBody = jsonData
                    
                    let task = URLSession.shared.dataTask(with: request) { data, response, error in
                        do {
                            let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            print(responseJSON)
                            DispatchQueue.main.async {
                             let responseJSON = responseJSON
                                self.id_quizz = responseJSON["id"] as! Int
                                self.performSegue(withIdentifier: "toCreateQuestion", sender: nil)
                            }
                        }
                        catch let error as NSError{
                            print(error)
                        }
                }
                task.resume()
        }
        else{
            showToast(message: "Field must be filled", color: UIColor.red)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       var vc = segue.destination as! CreateQuestionViewController
       vc.theme = theme ?? ""
       vc.id_quizz = id_quizz
        vc.author = input.text ?? ""
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
