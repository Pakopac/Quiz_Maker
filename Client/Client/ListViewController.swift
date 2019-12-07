//
//  ListViewController.swift
//  Client
//
//  Created by Kevin Badinca on 31/10/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
		
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 284)
        label.textAlignment = NSTextAlignment.center
        label.text = "The List View"
        
        self.view.addSubview(label)
    }

}
