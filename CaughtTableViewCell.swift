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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUpCell(user: User){
        self.user = user
        userNameLabel.text = user.userName
        
    }
    
    
    
    
}
