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
    var displayName: String? = ""
    var likesCount: Bool? = false
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? NSInteger
        content = dictionary["content"] as? String
        displayName = dictionary["creator"]?["display_name"] as? String
        likesCount = dictionary["likes_count"] as? Bool
    }

}
