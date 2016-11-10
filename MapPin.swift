//
//  MapPin.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/8/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var user: User?
    var userId: String?
    var avatarBase64: String?
    var title: String?
    var subtitle: String?
    
    
    
    init(user: User) {
        self.user = user
        self.userId = user.userId
        self.subtitle = user.userName
        self.title = user.userName
        self.avatarBase64 = user.avatarBase64
        
        
        if let lat = user.latitude, let long = user.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
}
