//
//  Utils.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation


class Utils {
    
    static func dateFromString(str: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        return formatter.dateFromString(str)
    }
    
}