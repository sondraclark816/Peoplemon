//
//  Account.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/6/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class Account : NetworkModel {
    
    var id : String?
    var username : String?
    var password : String?
    var token : String?
    var Email : String?
    var FullName : String?
    var AvatarBase64 : String?
    var ApiKey : String?
    var Password : String?
    var NewPassword : String?
    var OldPassword : String?
    var ConfirmPassword : String?
    
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
        Email = try? json.getString(at: Constants.Account.email)
        FullName = try? json.getString(at: Constants.Account.fullName)
        AvatarBase64 = try? json.getString(at: Constants.Account.avatarBase64)
        ApiKey = try? json.getString(at: Constants.Account.apiKey)
    }
    
    init(email: String, FullName: String, AvatarBase64: String?, ApiKey: String, Password: String) {
        self.Email = email
        self.FullName = FullName
        self.AvatarBase64 = AvatarBase64
        self.ApiKey = ApiKey
        self.Password = Password
        requestType = .register
    }
    
    init(NewPassword: String) {
        self.NewPassword = NewPassword
        requestType = .setPassword
    }
    
    init(NewPassword: String, OldPassword: String, ConfirmPassword: String?) {
        self.NewPassword = NewPassword
        self.OldPassword = OldPassword
        self.ConfirmPassword = ConfirmPassword
        requestType = .changePassword
    }
    
    init(token: String) {
        requestType = .logout
        
    }
    
    init(FullName: String, AvatarBase64: String?) {
        self.FullName = FullName
        self.AvatarBase64 = AvatarBase64
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
        params[Constants.Account.email] = Email as AnyObject?
        params[Constants.Account.fullName] = FullName as AnyObject?
        params[Constants.Account.avatarBase64] = AvatarBase64 as AnyObject?
        params[Constants.Account.apiKey] = ApiKey as AnyObject?
        params[Constants.Account.password] = ApiKey as AnyObject?
        
        return params 
        }
    
     
    
    
    
    
    
}
