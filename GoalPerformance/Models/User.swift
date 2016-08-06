//
//  User.swift
//  GoalPerformance
//
//  Created by Welcome on 8/4/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class User: NSObject {
    
    let displayName: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let token: String?
    
    init(dictionary: NSDictionary) {
        displayName = dictionary["display_name"] as? String
        firstName = dictionary["first_name"] as? String
        lastName = dictionary["last_name"] as? String
        email = dictionary["email"] as? String
        token = dictionary["token"] as? String
    }
    
}
