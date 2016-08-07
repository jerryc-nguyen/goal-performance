//
//  Category.swift
//  GoalPerformance
//
//  Created by sophie on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class Category: NSObject
{
    var id: NSInteger? = 0
    var name: String? = ""
    var nth: NSInteger? = 0
    var is_default: Bool? = false
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? NSInteger
        name = dictionary["name"] as? String
        nth = dictionary["nth"] as? NSInteger
        is_default = dictionary["is_default"] as? Bool
    }
}
