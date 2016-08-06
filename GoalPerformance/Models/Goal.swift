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
    
    let id: Int?
    let name: String?
    var startAt: NSDate?
    let repeatEvery: String?
    var duration: Int = 0
    let soundName: String?
    var isChallenge: Bool = false
    var isDefault: Bool = false
    let token: String?
    
    var notificationKey: String {
        return "goal-\(self.id)"
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        repeatEvery = dictionary["repeat_every"] as? String
        soundName = dictionary["sound_name"] as? String
        token = dictionary["token"] as? String
        
        if let startAt = dictionary["start_at"] as? String {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            self.startAt = formatter.dateFromString(startAt)
        }

        if let isChallenge = dictionary["is_challenge"] as? Bool {
            self.isChallenge = isChallenge
        }
        
        if let isDefault = dictionary["is_challenge"] as? Bool {
            self.isDefault = isDefault
        }
        
        if let duration = dictionary["duration"] as? Int {
            self.duration = duration
        }
    }
    
    
    
    
    
    
}