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
    var name : String?
    //var avatarBase64 : String?
    
    init(user: User) {
        self.user = user
        if let lat = user.latitude, let long = user.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
    init(userName: User) {
        self.userName = userName
    }
    
}
