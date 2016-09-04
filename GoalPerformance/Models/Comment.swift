//
//  Comment.swift
//  GoalPerformance
//
//  Created by sophie on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class Comment: NSObject {

    var id: NSInteger? = 0
    var content: String? = ""
    var likesCount: Bool? = false
    var creator: User?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? NSInteger
        content = dictionary["content"] as? String
        likesCount = dictionary["likes_count"] as? Bool
        if let creatorData = dictionary["creator"] as? NSDictionary {
            creator = User(dictionary: creatorData)
        }

    }
    override init() {
        
    }

}
