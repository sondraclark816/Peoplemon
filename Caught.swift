//
//  Caught.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/10/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import Foundation
import UIKit

class Caught: NSObject, NSCoding {
    var username = ""
    var avatar = ""
    
    let usernameKey = "username"
    let avatarKey = "avatar"
    
    override init() {
        super.init()
    }
    
    init(username: String, avatar: String) {
        self.username = username
        self.avatar = avatar
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.username = aDecoder.decodeObject(forKey: usernameKey) as! String
        self.avatar = aDecoder.decodeObject(forKey: avatarKey) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: usernameKey)
        aCoder.encode(avatar, forKey: avatarKey)
    }
}
