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

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nView = UIView()
        
        let helloView = UILabel()
        helloView.text = "Welcome to Quiz Maker"
        helloView.textAlignment = .center
        
        let username = UITextField()
        username.backgroundColor = UIColor.white
        username.placeholder = "username"
        username.layer.cornerRadius = 10
        username.setLeftPaddingPoints(10)
        username.returnKeyType = UIReturnKeyType.next
        
        let password = UITextField()
        password.backgroundColor = UIColor.white
        password.placeholder = "password"
        password.layer.cornerRadius = 10
        password.setLeftPaddingPoints(10)
        password.isSecureTextEntry = true
        password.returnKeyType = UIReturnKeyType.done
        
        let button = UIButton()
        button.setTitle("Connect",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        self.view.backgroundColor = UIColor.gray
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: helloView, x: 3, y: 2, height: 4, width: 6)
        self.view.grid(child:username, x: 2, y: 5, height: 0.5, width: 8)
        self.view.grid(child:password, x: 2, y: 6, height: 0.5, width: 8)
        self.view.grid(child:button, x: 4, y: 7, height: 0.5, width: 4)
        
    }
}
