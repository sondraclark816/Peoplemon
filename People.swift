//
//  People.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/7/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class User : NetworkModel {
    
    var id : String?
    
    
    var username : String?
    var password : String?
    var token : String?
    var email : String?
    var fullName : String?
    var avatarBase64 : String?
    var apiKey : String?
    
    var newPassword : String?
    var oldPassword : String?
    var confirmPassword : String?
    
    enum RequestType {
        case register
        case setPassword
        case changePassword
        case logout
        case userInfo
    }
    
    var requestType = RequestType.register
    
    required init() {}
    
    required init(json: JSON) throws {
        token = try? json.getString(at: Constants.Person.token)
        email = try? json.getString(at: Constants.Person.email)
        fullName = try? json.getString(at: Constants.Person.fullName)
        avatarBase64 = try? json.getString(at: Constants.Person.avatarBase64)
        apiKey = try? json.getString(at: Constants.Person.apiKey)
    }
    
    init(email: String, FullName: String, AvatarBase64: String?, ApiKey: String, Password: String) {
        self.email = email
        self.fullName = FullName
        self.avatarBase64 = AvatarBase64
        self.apiKey = ApiKey
        self.password = Password
        requestType = .register
    }
    
    init(NewPassword: String) {
        self.newPassword = NewPassword
        requestType = .setPassword
    }
    
    init(NewPassword: String, OldPassword: String, ConfirmPassword: String?) {
        self.newPassword = NewPassword
        self.oldPassword = OldPassword
        self.confirmPassword = ConfirmPassword
        requestType = .changePassword
    }
    
    init(token: String) {
        requestType = .logout
        
    }
    
    init(FullName: String, AvatarBase64: String?) {
        self.fullName = FullName
        self.avatarBase64 = AvatarBase64
        requestType = .userInfo
    }
    
    func method() -> Alamofire.HTTPMethod {
        return .post
    }
    
    
    func path() -> String {
        switch requestType {
        case .register:
            return "/api/Account/Register"
        case .setPassword:
            return "/api/Account/SetPassword"
        case .changePassword:
            return "/api/Account/ChangePassword"
        case .logout:
            return "/api/Account/Logout"
        case .userInfo:
            return "/api/Account/UserInfo"
        }
    }
    
    
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        params[Constants.Person.email] = email as AnyObject?
        params[Constants.Person.fullName] = fullName as AnyObject?
        params[Constants.Person.avatarBase64] = avatarBase64 as AnyObject?
        params[Constants.Person.apiKey] = apiKey as AnyObject?
        params[Constants.Person.password] = apiKey as AnyObject?
        
        return params
    }
    
    
    
    
    
    
    
}
