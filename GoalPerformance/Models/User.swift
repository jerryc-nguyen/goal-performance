//
//  User.swift
//  GoalPerformance
//
//  Created by Welcome on 8/4/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let id:Int?
    let displayName: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let token: String?
    var avatarUrl: NSURL?
    var airshipTag: String?
    var isFriend: Bool?
    var isPendingFriend: Bool?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        displayName = dictionary["display_name"] as? String
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        token = dictionary["token"] as? String
        airshipTag = dictionary["airship_tag"] as? String
        isFriend = dictionary["is_friend"] as? Bool
        isPendingFriend = dictionary["is_pending_friend"] as? Bool
        
        let avatarUrl = dictionary["avatar_url"] as? String
        if let avatarUrl = avatarUrl {
            self.avatarUrl = NSURL(string: avatarUrl)
        }
    }
    
}
