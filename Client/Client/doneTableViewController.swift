//
//  AllTableViewController.swift
//  Client
//
//  Created by Lilian on 07/12/2019.
//  Copyright © 2019 LiKe. All rights reserved.
//

import UIKit

class doneTableViewController: UITableViewController {
    
    var jsonQuestion = [[String : Any]]()
    var jsonQuestionFilter = [[String : Any]]()
    var jsonScore = [[String : Any]]()
    var jsonScoreFilter = [[String: Any]]()
    var jsonQuizzById = [[String: Any]]()
    var jsonFinal = [[String: Any]]()

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        self.tableView.backgroundColor = UIColor.gray
        
        
        getAllQuizz()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(jsonFinal.count)
        //return json.count
        return jsonFinal.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoneCell", for: indexPath)
        print(jsonFinal[indexPath.row])
        cell.textLabel?.text = jsonFinal[indexPath.row]["name"] as! String
        cell.backgroundColor = UIColor.gray


        return cell
    }
    
    func getAllQuizz(){
        let url = URL(string: "http://127.0.0.1:8000/api/quizzes")!
          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "GET"
          
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
              do {
                let responseJsonQuestion = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.jsonQuestion = responseJsonQuestion["hydra:member"] as! [[String : Any]]
                  
                DispatchQueue.main.async(execute: {
                    self.getScore()
                })
               }
              catch let error as NSError{
                  print(error)
              }
           }
        task.resume()
    }
    
    func getScore(){
        let url = URL(string: "http://127.0.0.1:8000/api/scores")!
          var request = URLRequest(url: url)
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "GET"
          
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
              do {
                let responseJsonScore = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                self.jsonScore = responseJsonScore["hydra:member"] as! [[String : Any]]
                self.jsonScoreFilter = self.jsonScore.filter{ $0["username"] as! String == self.defaults.string(forKey: "name")}
                DispatchQueue.main.async(execute: {
                    for item in self.jsonScoreFilter{
                        self.getQuizzById(id: item["quizId"] as! Int)
                    }
                })
               }
              catch let error as NSError{
                  print(error)
              }
           }
        task.resume()
    }
    
    func getQuizzById(id: Int){
        let url = URL(string: "http://127.0.0.1:8000/api/quizzes/" + String(id))!
                 var request = URLRequest(url: url)
                 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                 request.httpMethod = "GET"
                 
                  let task = URLSession.shared.dataTask(with: request) { data, response, error in
                     do {
                       let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                        self.jsonFinal.append(responseJson)
                       //self.jsonQuizzById = responseJson["hydra:member"] as! [[String : Any]]
                       DispatchQueue.main.async(execute: {
                        //print(self.jsonQuizzById)
                        self.tableView.reloadData()
                       })
                      }
                     catch let error as NSError{
                         print(error)
                     }
                  }
               task.resume()
    }

}
