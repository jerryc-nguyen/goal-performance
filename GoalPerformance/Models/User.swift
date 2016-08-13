//
//  User.swift
//  GoalPerformance
//
//  Created by Welcome on 8/4/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let id:String?
    let displayName: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let token: String?
    var avatarUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? String
        displayName = dictionary["display_name"] as? String
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        token = dictionary["token"] as? String
        
        let avatarUrl = dictionary["avatar_url"] as? String
        if let avatarUrl = avatarUrl {
            self.avatarUrl = NSURL(string: avatarUrl)
        }
    }
    
}
