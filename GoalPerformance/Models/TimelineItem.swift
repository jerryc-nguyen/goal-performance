//
//  TimelineItem.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class TimelineItem: NSObject {
    let id: Int!
    let creatorId: Int!
    let goalId: Int!
    let participantId: Int!
    var score: Int = 0
    let likesCount: Int = 0
    let commentsCount: Int = 0
    let viewsCount: Int = 0
    let finishSentence: String?
    let feelingSentence: String?
    var createdAt: NSDate?
    
    var sessionsHistory: [SessionHistory]?
    
    var creator: User?

    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        creatorId = dictionary["creator_id"] as? Int
        goalId = dictionary["goal_id"] as? Int
        participantId = dictionary["participant_id"] as? Int
        
        if let goalScore = dictionary["score"] as? Int {
            score = goalScore
        }
        
        finishSentence = dictionary["finish_sentence"] as? String
        feelingSentence = dictionary["feeling_sentence"] as? String
        
        if let userData = dictionary["creator"] as? NSDictionary {
            creator = User(dictionary: userData)
        }
        
        if let arraySessionData = dictionary["sessions_history"] as? [NSDictionary] {
            sessionsHistory = SessionHistory.objectsFromArrayData(arraySessionData)
        }
        
        if let creatorData = dictionary["participant"] as? NSDictionary {
            creator = User(dictionary: creatorData)
        }
        
        
        if let createdAtStr = dictionary["created_at"] as? String {
            if let createdAtDate = Utils.dateFromRailsString(createdAtStr) {
                createdAt = createdAtDate
            }
        }
        
    }
}