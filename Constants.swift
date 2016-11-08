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
    // Step 16: Add monthDayYear
    static let monthDayYear = "MM/dd/yyyy"
    
    // Step 7: Add keychain strings
    public static let keychainIdentifier = "PeopleMon-SondraClarkKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    public static let ApiKey = "iOSandroid301november2016"
    
    // Step 4: JSON Constants
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
    
    struct Person {
        static let email = "email"
        static let fullName = "fullName"
        static let avatarBase64 = "avatarBase64"
        static let apiKey = "apiKey"
        static let password = "password"
        static let token = "token"
    }
    
    // Step 9: User Constants
    struct User {
        static let id = "id"
        static let email = "email"
        static let password = "password"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let confirmPassword = "confirmPassword"
        static let hasRegistered = "hasRegistered"
        static let loginProvider = "loginProvider"
        static let fullName = "fullName"
        static let lastCheckinLong = "0"
        static let lastCheckinLat = "0"
        static let lastCheckinDateTime = "0"
        static let ApiKey = "iOSandroid301november2016"
    }
    
}

// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    static let PositiveColor = UIColor.rgba(red: 15, green: 181, blue: 46)
    static let NegativeColor = UIColor.rgba(red: 219, green: 31, blue: 31)
    static let BlueColor = UIColor.rgba(red: 12, green: 35, blue: 64)
    static let GoldColor = UIColor.rgba(red: 201, green: 151, blue: 0)
    static let calendarCellColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let calendarTodayColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.3)
    static let calendarBorderColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.8)
}
