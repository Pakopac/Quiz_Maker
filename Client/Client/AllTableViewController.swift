//
//  AllTableViewController.swift
//  Client
//
//  Created by Lilian on 07/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class AllTableViewController: UITableViewController {
    
    var json = [[String : Any]]()
    var id_quizz = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        self.tableView.backgroundColor = UIColor.gray
        
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "name") {
            print(name) // Some String Value
        }
        
        let url = URL(string: "http://127.0.0.1:8000/api/quizzes")!
          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "GET"
          
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
              do {
                let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.json = responseJson["hydra:member"] as! [[String : Any]]
                  
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
               }
              catch let error as NSError{
                  print(error)
              }
           }
        task.resume()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllCell", for: indexPath)
        cell.textLabel?.text = json[indexPath.row]["name"] as! String
        cell.backgroundColor = UIColor.gray
        return cell
    }
    	
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id_quizz = json[indexPath.row]["id"] as! Int
        self.performSegue(withIdentifier: "allToDoQuizz", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       var vc = segue.destination as! DoQuizzViewController
       vc.id_quizz = self.id_quizz
   }
    

}
