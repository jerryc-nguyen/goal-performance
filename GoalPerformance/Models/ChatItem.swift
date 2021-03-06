//
//  MyChatItem.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class ChatItem: NSObject, JSQMessageData {
    let id: Int!
    let senderIdStr: String?
    let receiverId: Int?
    let message: String?
    let goalId: Int?
    var isRead: Bool = false
    var actor: ChatUser?
    var receiver: ChatUser?
    var formattedCreatedAt: String?
    var createdAt: NSDate?
    var goal: Goal?
    
    static let NewChatEventName: String = "hasNewChat"
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        senderIdStr = dictionary["sender_id_str"] as? String
        receiverId = dictionary["receiver_id"] as? Int
        message = dictionary["message"] as? String
        formattedCreatedAt = dictionary["formatted_created_at"] as? String
        goalId = dictionary["goal_id"] as? Int
        
        if let isRead = dictionary["is_read"] as? Bool {
            self.isRead = isRead
        }
        
        if let senderData = dictionary["sender"] as? NSDictionary {
            actor = ChatUser(dictionary: senderData)
        }
        
        if let receiverData = dictionary["receiver"] as? NSDictionary {
            receiver = ChatUser(dictionary: receiverData)
        }
        
        if let createdAtStr = dictionary["created_at"] as? String {
            if let createdAtDate = Utils.dateFromRailsString(createdAtStr) {
                createdAt = createdAtDate
            }
        }
        
        if let goalData = dictionary["goal"] as? NSDictionary {
            goal = Goal(dictionary: goalData)
        }
    }
    
    func senderId() -> String! {
        return self.senderIdStr
    }
    
    func text() -> String! {
        return message
    }
    
    func senderDisplayName() -> String! {
        return actor?.displayName
    }
    
    func date() -> NSDate! {
        return createdAt
    }
    
    func imageUrl() -> String? {
        return actor?.avatarUrl?.absoluteString
    }
    
    func isMediaMessage() -> Bool {
        return false
    }
    
    func messageHash() -> UInt {
        return UInt(self.id)
    }
    
}