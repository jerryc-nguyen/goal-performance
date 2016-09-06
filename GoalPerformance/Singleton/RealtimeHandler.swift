//
//  RealtimeHandler.swift
//  GoalPerformance
//
//  Created by Welcome on 9/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import PubNub

enum RealtimeEventType {
    case Chatting
    case DirectChat
    case GroupChat
}

class RealtimeHandler: NSObject, PNObjectEventListener {
    static let sharedInstance = RealtimeHandler()
    
    let eventMap: [String: RealtimeEventType] = [
        "chatting_direct": .DirectChat,
        "chatting_group": .GroupChat
    ]
    
    // Instance property
    var client: PubNub?
    
    func setupPubNub() {
        // Instantiate configuration instance.
        let configuration = PNConfiguration(publishKey: "pub-c-1a9e76ef-7214-47c1-b6ba-31617c438911", subscribeKey: "sub-c-270e0dcc-6d0f-11e6-a014-0619f8945a4f")
        // Instantiate PubNub client.
        client = PubNub.clientWithConfiguration(configuration)
        
        client?.addListener(self)
    }
    
    // Handle new message from one of channels on which client has been subscribed.
    func client(client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        // Handle new message stored in message.data.message
        if message.data.actualChannel != nil {
            // Message has been received on channel group stored in message.data.subscribedChannel.
        }
        else {
            handleRealtimeFor(message.data.message)
            // Message has been received on channel stored in message.data.subscribedChannel.
        }
        
        print("Received message: \(message.data.message) on channel " +
            "\((message.data.actualChannel ?? message.data.subscribedChannel)!) at " +
            "\(message.data.timetoken)")
    }
    
    func handleRealtimeFor(messageObj: AnyObject?) {
        if let messageEvent =  messageObj?.valueForKey("event_type") as? String {
            switch messageEvent {
            case "chatting_direct":
                if let chatItemData = messageObj?.valueForKey("data") as? NSDictionary {
                    let chatItem = ChatItem(dictionary: chatItemData)
                    handleDirectChatFor(chatItem)
                }
            default:
                if let chatItemData = messageObj?.valueForKey("data") as? NSDictionary {
                    let chatItem = ChatItem(dictionary: chatItemData)
                    handleGroupChatFor(chatItem)
                }
            }
            
        }
    }
    
    func handleDirectChatFor(chatItem: ChatItem?) {
        notifyChattingEventFor(chatItem)
    }
    
    func handleGroupChatFor(chatItem: ChatItem?) {
        notifyChattingEventFor(chatItem)
    }
    
    func notifyChattingEventFor(chatItem: ChatItem?) {
        NSNotificationCenter.defaultCenter().postNotificationName(ChatItem.NewChatEventName, object: chatItem)
    }
}
