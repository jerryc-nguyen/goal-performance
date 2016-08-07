//
//  Utils.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation


class Utils {
    
    static func dateFromRailsString(str: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.dateFromString(str)
    }
    
}