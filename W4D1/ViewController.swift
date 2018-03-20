//
//  ViewController.swift
//  W4D1
//
//  Copyright © 2018 shauntc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var repos = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.github.com/users/shauntc/repos") else {
            print("Error Unknown URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if let jsonUnformatted = try? JSONSerialization.jsonObject(with: data!, options: []),
                let jsonArray = jsonUnformatted as? [[String:AnyObject]]
            {
                
                for eachRepo in jsonArray {
                    if let name = eachRepo["name"] as? String {
                        
                        self.repos.append(name)
                        
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        })
        
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reposCell", for: indexPath)
        
        let repo = repos[indexPath.row]
        
        cell.textLabel?.text = repo
        
        // Configure the cell...
        
        return cell
    }

}

