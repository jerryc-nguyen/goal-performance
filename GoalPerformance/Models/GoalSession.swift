//
//  GoalSession.swift
//  GoalPerformance
//
//  Created by Welcome on 8/20/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class GoalSession: NSObject {
    var id: Int!
    var goal: Goal!
    
    init(dictionary: NSDictionary) {
        if let goalSessionId = dictionary["id"] as? Int {
            id = goalSessionId
        }
        
        if let goalData = dictionary["goal"] as? NSDictionary {
            goal = Goal(dictionary: goalData)
        }
    }
}