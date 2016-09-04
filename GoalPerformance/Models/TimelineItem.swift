//
//  TimelineItem.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class TimelineItem: NSObject {

    var currentGoalSession: GoalSession?
    var likeCount: Int!
    
    init(dictionary: NSDictionary) {
        if let goalSessionData = dictionary["goal_session"] as? NSDictionary {
            currentGoalSession = GoalSession(dictionary: goalSessionData)
        }
    }
    
    static func initFromArrayData(dataArr: [NSDictionary]) -> [TimelineItem] {
        var results = [TimelineItem]()
        for data in dataArr {
            results.append(TimelineItem(dictionary: data))
        }
        return results
    }
}