//
//  CaughtTableViewController.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/10/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class CaughtTableViewController: UITableViewController {
    
    
    
    var caught: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User()
        WebServices.shared.getObjects(user) { (objects, error) in
            if let objects = objects{
                self.caught = objects
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getCount() -> Int {
        return caught.count
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return caught.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CaughtTableViewCell.self)) as! CaughtTableViewCell
        let person = caught[indexPath.row]
        cell.setUpCell(user: person)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
