//
//  Profile.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/11/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import Foundation
import UIKit


class Profile: NSObject, NSCoding{
    
    var userName = ""
    
    var image: UIImage?
    
    
    let userNameKey = "userName"
    
    let imageKey = "image"
    
    override init(){
        super.init()
        
    }
    //creating a custom initializer --convenience initializer
    init(userName: String){
        self.userName = userName
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        self.userName = aDecoder.decodeObject(forKey: userNameKey) as! String
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: userNameKey)
        aCoder.encode(image, forKey: imageKey)
    }
}
