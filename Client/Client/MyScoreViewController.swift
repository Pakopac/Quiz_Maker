//
//  MyScoreViewController.swift
//  Client
//
//  Created by Lilian on 09/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class MyScoreViewController: UIViewController {
    
    let nView = UIView()
    let scoreTitle = UILabel()
    let scoreText = UILabel()
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        print("abc")
        print(score)
        
        self.view.backgroundColor = UIColor.gray
        
        scoreTitle.text = "Your Score :"
        scoreTitle.textAlignment = .center
        scoreTitle.sizeToFit()
        scoreTitle.font = themeLabel.font.withSize(30)
        
        scoreText.text = String(score) + " point(s)"
        scoreText.textAlignment = .center
        scoreText.sizeToFit()
        scoreText.textColor = UIColor.green
        scoreText.font = themeLabel.font.withSize(25)
        
        self.view.grid(child:nView, x: 0, y: 1, height: 12, width: 12)
        nView.grid(child: scoreTitle, x: 0, y: 0.5, height: 0.5, width: 12)
        nView.grid(child: scoreText, x: 0, y: 1.5, height: 0.5, width: 12)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
