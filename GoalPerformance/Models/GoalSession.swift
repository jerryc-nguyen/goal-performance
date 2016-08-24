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
    let status: String?
    var inviter: User?
    var participant: User?
    var statement: String?
    
    var goal: Goal!
    
    var sessionsHistory: SessionsHistory?
    
    init(dictionary: NSDictionary) {
        creatorId = dictionary["creator_id"] as? Int
        goalId = dictionary["goal_id"] as? Int
        participantId = dictionary["participant_id"] as? Int
        finishSentence = dictionary["finish_sentence"] as? String
        feelingSentence = dictionary["feeling_sentence"] as? String
        status = dictionary["status"] as? String
        
        if let goalSessionId = dictionary["id"] as? Int {
            id = goalSessionId
        }
        
        if let goalData = dictionary["goal"] as? NSDictionary {
            goal = Goal(dictionary: goalData)
        }
        
        if let goalScore = dictionary["score"] as? Int {
            score = goalScore
        }
        
        if let sessionsData = dictionary["sessions_history"] as? NSDictionary {
            sessionsHistory = SessionsHistory(dictionary: sessionsData)
        }
        
        if let sessionsData = dictionary["sessions_history"] as? NSDictionary {
            sessionsHistory = SessionsHistory(dictionary: sessionsData)
        }
        
        if let participantData = dictionary["participant"] as? NSDictionary {
            participant = User(dictionary: participantData)
        }
        
        if let inviterData = dictionary["inviter"] as? NSDictionary {
            inviter = User(dictionary: inviterData)
        }
        
        if let statementData = dictionary["statement"] as? String {
            statement = statementData
        }
        
        if let createdAtStr = dictionary["created_at"] as? String {
            if let createdAtDate = Utils.dateFromRailsString(createdAtStr) {
                createdAt = createdAtDate
            }
        }
    }
}