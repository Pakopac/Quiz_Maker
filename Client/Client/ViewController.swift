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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nView = UIView()
        
        let helloView = UILabel()
        helloView.text = "Welcome to Quiz Maker"
        helloView.textAlignment = .center
        helloView.font = helloView.font.withSize(30)
        
        email.text = "test@supinternet.fr"
        email.backgroundColor = UIColor.white
        email.placeholder = "email"
        email.layer.cornerRadius = 10
        email.setLeftPaddingPoints(10)
        email.delegate = self as! UITextFieldDelegate
        email.returnKeyType = UIReturnKeyType.next
        
        password.backgroundColor = UIColor.white
        password.text = "supintertest"
        password.placeholder = "password"
        password.layer.cornerRadius = 10
        password.setLeftPaddingPoints(10)
        password.isSecureTextEntry = true
        password.delegate = self as! UITextFieldDelegate
        password.returnKeyType = UIReturnKeyType.done
        
        let button = UIButton()
        button.setTitle("Connect",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        button.addTarget(self, action: #selector(redirectToList), for: .touchUpInside)
        
        
        self.view.backgroundColor = UIColor.gray
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: helloView, x: 1, y: 2, height: 4, width: 10)
        self.view.grid(child:email, x: 2, y: 5, height: 0.5, width: 8)
        self.view.grid(child:password, x: 2, y: 6, height: 0.5, width: 8)
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
                                self.showToast(message: "Token Failed", color: UIColor.red)
                            }
                        }
                        catch let error as NSError{
                            print(error)
                        }
                    }
                    taskToken.resume()
                }
                else{
                    DispatchQueue.main.async(execute: {
                        self.showToast(message: "Invalid email or password", color: UIColor.red)
                    })
                }
                
            }
            catch let error as NSError{
                print(error)
            }
        }
        task.resume()
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
