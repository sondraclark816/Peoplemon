//
//  UserStore.swift
//  PeopleMon-SondraClark
//
//  Created by Sondra Clark on 11/6/16.
//  Copyright © 2016 Sondra Clark. All rights reserved.
//


import Foundation
import UIKit


class UserStore {

    static let shared = UserStore()
    private init() {}
    var selectedImage: UIImage?
    var user:People?
    
    
    
    func login(_ loginUser: People, completion: @escaping (_ success:Bool, _ error: String?) -> Void) {
        
        
        //Call web service to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if let user = user {
                print("Token: \(user.token) Expiration: \(user.expiration)")
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func register(_ registerUser: People, completion: @escaping
        (_ success: Bool, _ error: String?)-> ()) {
        WebServices.shared.authUser(registerUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
               completion(true, nil)
            } else {
               completion(false, error)
            }
        }
    }
    
    
    func logout(_ completion:() -> ()) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }
}
