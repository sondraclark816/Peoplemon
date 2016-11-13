
//  User.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/7/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.


import Foundation
import Alamofire
import Freddy

class User : NetworkModel {
    
    var userId : String?
    var userName : String?
    var avatarBase64 : String?
    var latitude : Double?
    var longitude : Double?
    var created : String?
    var radiusInMeters : Int?
    var caughtUserId : String?
    var conversationId : String?
    var recipientId : String?
    var recipientName : String?
    var lastMessage : Double?
    var messageCount : Int?
    var senderId : String?
    var senderName : String?
    var recipientAvatarBase64 : String?
    var senderAvatarBase64 : String?
    var grant_type : String?
    var expiration : Int?
    var radius = 100
    
    
    
    enum RequestType {
        case nearby
        case checkin
        case Catch
        case caught
        case conversations
        case register
        case login
    }
    var requestType = RequestType.nearby
    
    
    
    required init() {}
    
    required init(json: JSON) throws {
        //token = try? json.getString(at: Constants.User.token)
        userId = try? json.getString(at: Constants.User.userId)
        userName = try? json.getString(at: Constants.User.userName)
        avatarBase64 = try? json.getString(at: Constants.User.avatarBase64)
        latitude = try? json.getDouble(at: Constants.User.latitude)
        longitude = try? json.getDouble(at: Constants.User.longitude)
        created = try? json.getString(at: Constants.User.created)
        radiusInMeters = try? json.getInt(at: Constants.User.radiusInMeter)
        caughtUserId = try? json.getString(at: Constants.User.caughtUserId)
        conversationId = try? json.getString(at: Constants.User.conversationId)
        recipientId = try? json.getString(at: Constants.User.recipientId)
        recipientName = try? json.getString(at: Constants.User.recipientName)
        lastMessage = try? json.getDouble(at: Constants.User.lastMessage)
        messageCount = try? json.getInt(at: Constants.User.messageCount)
        senderId = try? json.getString(at: Constants.User.senderId)
        senderName = try? json.getString(at: Constants.User.senderName)
        recipientAvatarBase64 = try? json.getString(at: Constants.User.recipientAvatarBase64)
        senderAvatarBase64 = try? json.getString(at: Constants.User.senderAvatarBase64)
        grant_type = try? json.getString(at: Constants.User.grantType)
        expiration = try? json.getInt(at: Constants.User.expiration)
        
    }
    
    init(radiusInMeters: Int) {
        self.radiusInMeters = radiusInMeters
        requestType = .nearby
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        requestType = .checkin
    }
    
    init(caughtUserId: String?, radiusInMeters: Int?) {
        self.caughtUserId = caughtUserId
        self.radiusInMeters = radiusInMeters
        requestType = .Catch
    }
    
    init(userId: String?, userName: String?, created: String?, avatarBase64: String?) {
        self.userId = userId
        self.userName = userName
        self.created = created
        self.avatarBase64 = avatarBase64
        requestType = .caught
    }
    
    init(conversationId: Int, recipientId: String, recipientName: String, lastMessage: Double, created: String, messageCount: Int, avatarBase64: String, senderId: String, senderName: String, recipientAvatarBase64: String, senderAvatarBase64: String) {
        self.conversationId = "0"
        self.recipientId = recipientId
        self.recipientName = recipientName
        self.lastMessage = lastMessage
        self.created = created
        self.messageCount = messageCount
        self.avatarBase64 = avatarBase64
        self.senderId = senderId
        self.senderName = senderName
        self.recipientAvatarBase64 = recipientAvatarBase64
        self.senderAvatarBase64 = senderAvatarBase64
        requestType = .conversations
    }
    
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .nearby:
            return .get
        case .checkin:
            return .post
        case .Catch:
            return .post
        case .caught:
            return .get
        case .conversations:
            return .get
        default:
            return .get
            
        }
    }
    
    func path() -> String {
        switch requestType {
        case .nearby:
            return "/v1/User/Nearby"
        case .checkin:
            return "/v1/User/CheckIn"
        case .Catch:
            return "/v1/User/Catch"
        case .caught:
            return "/v1/User/Caught"
        case .conversations:
            return "/v1/User/Conversations"
        case .login:
            return "/token"
        case .register:
            return "/api/Account/Register"
        }
    }
    
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .checkin:
            params[Constants.User.latitude] = latitude as AnyObject?
            params[Constants.User.longitude] = longitude as AnyObject?
            
            
        case .Catch:
            params[Constants.User.caughtUserId] = caughtUserId as AnyObject?
            params[Constants.User.radiusInMeter] = radiusInMeters as AnyObject?
            
            
        case .nearby:
            params[Constants.User.radiusInMeter] = radiusInMeters as AnyObject?
            
            
        default:
            return nil
        }
        return params
    }
}
