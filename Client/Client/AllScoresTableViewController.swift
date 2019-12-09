//
//  AllTableViewController.swift
//  Client
//
//  Created by Lilian on 07/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class AllScoresTableViewController: UITableViewController {
    
    var json = [[String : Any]]()
    var jsonFilter = [[String : Any]]()
    var jsonFilterSorted = [[String : Any]]()
    var quizz_id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        self.tableView.backgroundColor = UIColor.gray
        
        /*let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "name") {
            print(name) // Some String Value
        }*/
        
        let url = URL(string: "http://127.0.0.1:8000/api/scores")!
          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "GET"
          
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
              do {
                let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print(responseJson)
                self.json = responseJson["hydra:member"] as! [[String : Any]]
                self.jsonFilter = self.json.filter{ $0["quizId"] as! Int == self.quizz_id}
                self.jsonFilterSorted = self.jsonFilter.sorted{ $0["score"] as! Int > $1["score"] as! Int}
                  
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
        return jsonFilterSorted.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllScoreCell", for: indexPath)
        cell.textLabel?.text = String(jsonFilterSorted[indexPath.row]["score"] as! Int) + " point(s) - " + String(jsonFilterSorted[indexPath.row]["username"] as! String)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
    

}
