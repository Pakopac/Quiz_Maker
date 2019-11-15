//
//  CreateQuizzViewController.swift
//  Client
//
//  Created by SUP'Internet 11 on 15/11/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class CreateQuizzViewController: UIViewController {

    override func viewDidLoad() {
        let nView = UIView()
        
        super.viewDidLoad()
        
        let titleView = UILabel()
        titleView.text = "New Quizz"
        titleView.textAlignment = .center
        
        let theme = UITextField()
        theme.placeholder = "Theme"
        theme.layer.cornerRadius = 10
        theme.setLeftPaddingPoints(10)
        theme.returnKeyType = UIReturnKeyType.next
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: titleView, x: 3, y: 2, height: 4, width: 6)
        nView.grid(child: theme, x: 3, y: 4, height: 4, width: 6)

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
