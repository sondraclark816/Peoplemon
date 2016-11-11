//
//  CaughtTableViewCell.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/10/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit

class CaughtTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!

    
    var user: User!
    
    func setUpCell(user: User){
        self.user = user
        userNameLabel.text = user.userName
    }
    
    
}
