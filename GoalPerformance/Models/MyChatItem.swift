//
//  MyChatItem.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class MyChatItem: NSObject {
    let id: Int!
    let senderId: Int?
    let receiverId: Int?
    let message: String?
    let goalId: Int?
    var isRead: Bool = false
    var sender: User?
    var receiver: User?
    var createdAt: String?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        senderId = dictionary["sender_id"] as? Int
        receiverId = dictionary["receiver_id"] as? Int
        message = dictionary["message"] as? String
        createdAt = dictionary["created_at"] as? String
        goalId = dictionary["goal_id"] as? Int
        
        if let isRead = dictionary["is_read"] as? Bool {
            self.isRead = isRead
        }
        
        if let senderData = dictionary["sender"] as? NSDictionary {
            sender = User(dictionary: senderData)
        }
        
        if let receiverData = dictionary["receiver"] as? NSDictionary {
            receiver = User(dictionary: receiverData)
        }
        
    }
}