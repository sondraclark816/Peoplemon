//
//  Constants.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/6/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//


import Foundation
import UIKit

struct Constants {
   
    // Step 7: Add keychain strings
    public static let keychainIdentifier = "PeopleMon-SondraClarkKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    public static let apiKey = "ApiKey"
    public static let ApiKey = "iOSandroid301november2016"
    public static let grantType = "grant_type"
    static let radius = 100.00
    
    // Step 4: JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
  
    // Step 9: User Constants
    struct Person {
        static let id = "id"
        static let email = "Email"
        static let hasRegistered = "HasRegistered"
        static let loginProvider = "loginProvider"
        static let fullName = "FullName"
        static let avatarBase64 = "AvatarBase64"
        static let lastCheckinLong = "LastCheckInLongitude"
        static let lastCheckinLat = "LastCheckInLatitude"
        static let lastCheckinDateTime = "LastCheckInDateTime"
        static let oldPassword = "OldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        static let apiKey = "ApiKey"
        static let password = "password"
        static let grantType = "grant_type"
        static let userName = "username"
        static let token =  "access_token"
        static let expiration = ".expires"
            }
    
    struct User {
        static let userId = "UserId"
        static let userName = "UserName"
        static let avatarBase64 = "AvatarBase64"
        static let latitude = "Latitude"
        static let longitude = "Longitude"
        static let created = "Created"
        static let radiusInMeter = "RadiusInMeters"
        static let caughtUserId = "CaughtUserId"
        static let conversationId = "conversationId"
        static let recipientId = "recipientId"
        static let recipientName = "recipientName"
        static let lastMessage = "lastMessage"
        static let messageCount = "messageCount"
        static let senderId = "senderId"
        static let senderName = "senderName"
        static let recipientAvatarBase64 = "recipientAvatarBase64"
        static let senderAvatarBase64 = "senderAvatarBase64"
        static let grantType = "grant_type"
        static let expiration = ".expires"
    }
    
}


