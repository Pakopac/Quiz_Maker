//
//  CreateQuizzViewController.swift
//  Client
//
//  Created by SUP'Internet 11 on 15/11/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

let theme = UITextField()

class CreateQuizzViewController: UIViewController {
    
    override func viewDidLoad() {
        let nView = UIView()
        
        super.viewDidLoad()
        
        let titleView = UILabel()
        titleView.text = "New Quizz"
        titleView.textAlignment = .center
        
        theme.placeholder = "Theme"
        theme.layer.cornerRadius = 10
        theme.setLeftPaddingPoints(10)
        theme.returnKeyType = UIReturnKeyType.next
        
        let button = UIButton()
        button.setTitle("Enter",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        button.addTarget(self, action: #selector(redirectToQuestion), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: titleView, x: 3, y: 2, height: 4, width: 6)
        nView.grid(child: theme, x: 3, y: 4, height: 4, width: 6)
        nView.grid(child: button, x: 3, y: 6, height: 1, width: 4)

    }
    
    @objc func redirectToQuestion(sender:UIButton) {
        var inputTheme = theme.text
        print(inputTheme)
        if((inputTheme) != ""){
          self.performSegue(withIdentifier: "toCreateQuestion", sender: inputTheme)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
