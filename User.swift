
//  User.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/7/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.


import Foundation
import Alamofire
import Freddy

class Person : NetworkModel {
   

    
    //POST
    var recipientId : String?
    var message : String?
    var caughtUserId : String?
    var radiusInMeter : Int?
    var latitude : Double?
    var longitude : Double?
    var token : String?
    var expiration : String?
    
    //GET
    var count : Int?
    var recipientName : String?
    var senderName : String?
    var messages : String?
    var messageId : String?
    var created : String?
    var recipientUserId : String?
    var senderUserId : String?
    var conversationId : String?
    var lastMessage: Date?
    var messageCount: Int?
    var senderId: String?
    var recipientAvatarBase64: String?
    var sendAvatarBase64: String?
    
    enum RequestType {
        case conversation
        case conversations
        case caught
        case Catch
        case checkin
        case nearby
    }
    var requestType = RequestType.checkin
    
    
    
    required init() {}
    
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.Person.token)
    }
    
    
}
