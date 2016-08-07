//
//  SessionHistory.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class SessionHistory: NSObject {
    var score: Int = 0
    var completedAt: NSDate?
    
    init(dictionary: NSDictionary) {
        if let goalScore = dictionary["score"] as? Int {
            score = goalScore
        }
        
        if let completedAtStr = dictionary["start_at"] as? String {
            if let completedAtDate = Utils.dateFromString(completedAtStr) {
                completedAt = completedAtDate
            }
        }
        
    }
    
    static func objectsFromArrayData(arrayData: [NSDictionary]) -> [SessionHistory] {
        var results = [SessionHistory]()
        for sessionData in arrayData {
            results.append(SessionHistory(dictionary: sessionData))
        }
        return results
    }
}