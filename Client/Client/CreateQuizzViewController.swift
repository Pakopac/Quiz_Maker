//
//  CreateQuizzViewController.swift
//  Client
//
//  Created by SUP'Internet 11 on 15/11/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

var id_quizz = 0

let inputTheme = UITextField()

class CreateQuizzViewController: UIViewController {
    
    override func viewDidLoad() {
        let nView = UIView()
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        let titleView = UILabel()
        titleView.text = "New Quizz"
        titleView.textAlignment = .center
        titleView.font = themeLabel.font.withSize(30)
        
        inputTheme.placeholder = "Theme"
        inputTheme.layer.cornerRadius = 10
        inputTheme.setLeftPaddingPoints(10)
        inputTheme.returnKeyType = UIReturnKeyType.next
        inputTheme.backgroundColor = UIColor.white
        
        let button = UIButton()
        button.setTitle("Enter",for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.black
        
        button.addTarget(self, action: #selector(redirectToQuestion), for: .touchUpInside)
        
        self.view.grid(child:nView, x: 0, y: 2, height: 4, width: 12)
        nView.grid(child: titleView, x: 3, y: 1, height: 4, width: 6)
        nView.grid(child: inputTheme, x: 2, y: 4, height: 1.5, width: 8)
        nView.grid(child: button, x: 4, y: 6, height: 1.5, width: 4)

    }
    
    @objc func redirectToQuestion(sender:UIButton) {
        var theme = inputTheme.text!
        print(theme)
        if((theme) != ""){
         self.performSegue(withIdentifier: "toCreateAuthor", sender: nil)
                       
        }
        else{
            showToast(message: "Field must be filled", color: UIColor.red)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! AuthorViewController
        vc.theme = inputTheme.text ?? ""
        vc.id_quizz = id_quizz
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showToast(message : String, color : UIColor) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-150, width: 250, height: 35))
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
