//
//  ViewController.swift
//  Quiz_Maker
//
//  Created by SUP'Internet 11 on 31/10/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension UIView {
    func grid(child: UIView, x: CGFloat, y: CGFloat, height: CGFloat, width: CGFloat) {
        child.frame = CGRect (
            x: (self.frame.maxX / 12) * x,
            y: (self.frame.maxY / 12) * y,
            width: (self.frame.width / 12) * width,
            height: (self.frame.height / 12) * height
        )
        
        self.addSubview(child)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    let email: UITextField = UITextField()
    let password: UITextField = UITextField()
    let error: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nView = UIView()
        
        let helloView = UILabel()
        helloView.text = "Welcome to Quiz Maker"
        helloView.textAlignment = .center
        
        email.backgroundColor = UIColor.white
        email.placeholder = "email"
        email.layer.cornerRadius = 10
        email.setLeftPaddingPoints(10)
        email.delegate = self as! UITextFieldDelegate
        email.returnKeyType = UIReturnKeyType.next
        
        password.backgroundColor = UIColor.white
        password.placeholder = "password"
        password.layer.cornerRadius = 10
        password.setLeftPaddingPoints(10)
        password.isSecureTextEntry = true
        password.delegate = self as! UITextFieldDelegate
        password.returnKeyType = UIReturnKeyType.done
        
        error.textColor = UIColor.red
        
        let button = UIButton()
        button.setTitle("Connect",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        button.addTarget(self, action: #selector(redirectToList), for: .touchUpInside)
        
        
        self.view.backgroundColor = UIColor.gray
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: helloView, x: 3, y: 2, height: 4, width: 6)
        self.view.grid(child:email, x: 2, y: 5, height: 0.5, width: 8)
        self.view.grid(child:password, x: 2, y: 6, height: 0.5, width: 8)
        self.view.grid(child:error, x: 3, y: 8, height: 0.5, width: 8)
        self.view.grid(child:button, x: 4, y: 7, height: 0.5, width: 4)
        
    }
    
    @objc func redirectToList() {
        print("email",email)
        let json: [String: Any] = [
            "email": self.email.text!,
            "password": self.password.text!
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: "http://edu2.shareyourtime.fr/api/auth")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                let response = response as? HTTPURLResponse
                if(response?.statusCode == 200){
                    let data = responseJSON["data"] as! [String:Any]
                    let token = data["token"] as! String
                    
                    let urlToken = URL(string: "http://edu2.shareyourtime.fr/api/secret")!
                    var requestToken = URLRequest(url: urlToken)
                    let authValue: String? = "Bearer \(token)"
                    print("token",token)
                    requestToken.setValue(authValue!, forHTTPHeaderField:"Authorization")
                    
                    let taskToken = URLSession.shared.dataTask(with: requestToken) { data, response, error in
                        do {
                            let responseToken = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            let response = response as? HTTPURLResponse
                            if(response?.statusCode ==  200){
                                DispatchQueue.main.async(execute: {
                                    self.performSegue(withIdentifier: "ShowSecondVIew", sender: nil)
                                })
                            }
                            else{
                                self.error.text = "token failed"
                            }
                        }
                        catch let error as NSError{
                            print(error)
                        }
                    }
                    taskToken.resume()
                    print(token)
                }
                else{
                    DispatchQueue.main.async(execute: {
                        self.error.text = "Invalid email or password"
                    })
                }
                
            }
            catch let error as NSError{
                print(error)
            }
        }
        task.resume()
    }
    
}
