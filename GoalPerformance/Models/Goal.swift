//
//  Goal.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import UIKit

class Goal: NSObject {
    
    let id: Int!
    let name: String!
    var startAt: NSDate?
    let repeatEvery: String?
    var duration: Int = 0
    let soundName: String?
    var isChallenge: Bool = false
    var isDefault: Bool = false
    let token: String?
    let detailName: String?
    
    var sessionsHistory: SessionsHistory?
    
    var notificationStartKey: String {
        return "goal-\(self.id)-start"
    }
    
    var notificationEndKey: String {
        return "goal-\(self.id)-end"
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        repeatEvery = dictionary["repeat_every"] as? String
        soundName = dictionary["sound_name"] as? String
        token = dictionary["token"] as? String
        detailName = dictionary["detail_name"] as? String
        
        if let startAtStr = dictionary["start_at"] as? String {
            if let startAtDate = Utils.dateFromRailsString(startAtStr) {
                startAt = startAtDate
            }
        }

        if let isChallenge = dictionary["is_challenge"] as? Bool {
            self.isChallenge = isChallenge
        }
        
        if let isDefault = dictionary["is_default"] as? Bool {
            self.isDefault = isDefault
        }
        
        if let duration = dictionary["duration"] as? Int {
            self.duration = duration
        }
        
        if let sessionsHistoryData = dictionary["sessions_history"] as? NSDictionary {
            sessionsHistory = SessionsHistory(dictionary: sessionsHistoryData)
        }
        
        
    }
    
    static func initFromArrayData(goalsData: [NSDictionary]) -> [Goal] {
        var results = [Goal]()
        for goalData in goalsData {
            results.append(Goal(dictionary: goalData))
        }
        return results
    }
}