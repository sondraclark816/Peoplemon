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
    public static let keychainIdentifier = "EFABKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    public static let apiKey = "ApiKey"
    public static let ApiKey = "iOS301november2016"
    public static let grantType = "password"
    
    // Step 4: JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
  
    // Step 9: User Constants
    struct Person {
        static let id = "id"
        static let email = "Email"
        static let password = "password"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        static let loginProvider = "loginProvider"
        static let fullName = "FullName"
        static let lastCheckinLong = "0"
        static let lastCheckinLat = "0"
        static let lastCheckinDateTime = "0"
        static let avatarBase64 = "AvatarBase64"
        static let apiKey = "ApiKey"
        static let token =  "access_token"
        static let expiration = ".expires"
        static let userName = "username"
        static let hasRegistered = "HasRegistered"
    }
    
}


