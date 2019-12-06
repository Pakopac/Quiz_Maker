//
//  QuizzFinishedViewController.swift
//  Client
//
//  Created by Lilian on 06/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class QuizzFinishedViewController: UIViewController {

    let nView = UIView()
    let text1 = UILabel()
    let text2 = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        text1.text = "Congratulation"
        text1.textAlignment = .center
        text1.font = themeLabel.font.withSize(30)
        text1.textColor = UIColor.green
        
        text2.text = "your quizz is now online"
        text2.textAlignment = .center
        text2.font = themeLabel.font.withSize(20)
        text2.textColor = UIColor.green
        
        button.setTitle("Back to home",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        button.addTarget(self, action: #selector(backHome), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: text1, x: 2, y: 1, height: 4, width: 8)
        nView.grid(child: text2, x: 2, y: 2, height: 4, width: 8)
        nView.grid(child: button, x: 4, y: 6, height: 1.5, width: 4)
    }
    
    @objc func backHome(){
        self.performSegue(withIdentifier: "finishedQuizzToHome", sender: nil)
    }

}
