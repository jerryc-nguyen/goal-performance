//
//  ChatListViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatListViewController: JSQMessagesViewController {
    
    var messages = [ChatItem]()
    
    var apiClient = APIClient.sharedInstance
    var lastItemId = -1
    var sender = APIClient.currentUser
    var receiver: ChatUser?
    var goal: Goal?
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChatLayout()
        setupBubbles()
        loadChatItems()
        handleNewRealtimeChat()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.senderId = sender.idStr
        self.senderDisplayName = sender.displayName
        
        super.viewWillAppear(animated)
        
    }
    
    func setupChatLayout() {
        self.showLoadEarlierMessagesHeader = true
        self.inputToolbar.contentView.leftBarButtonItem = nil
    }
    
    func handleNewRealtimeChat() {
        NSNotificationCenter.defaultCenter()
            .addObserverForName(ChatItem.NewChatEventName, object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification) in
                
                if let newChat = notification.object as? ChatItem {
                    if newChat.goalId == self.goal?.id || newChat.receiverId == self.sender.id {
                        self.messages.append(newChat)
                        self.collectionView.reloadData()
                        self.scrollToBottomAnimated(true)
                    }
                }
        }
    }
    
    func loadChatItems(isScroll: Bool = true) {
        var params: [String: AnyObject] = [
            "last_item_id": lastItemId
        ]
        
        if let receiverObj = receiver {
            params["receiver_id"] = receiverObj.id
        } else if let goalObject = goal {
            params["goal_id"] = goalObject.id
        }

        apiClient.chatList(params) { (items) in
            
            if let topMostItem = items.first {
                self.lastItemId = topMostItem.id
            } else {
                self.showLoadEarlierMessagesHeader = false
            }
            
            if isScroll {
                self.messages += items
            } else {
                for message in items {
                    self.messages.insert(message, atIndex: 0)
                }
            }
            
            self.collectionView.reloadData()
            
            self.scrollToBottomAnimated(isScroll)
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, header headerView: JSQMessagesLoadEarlierHeaderView!, didTapLoadEarlierMessagesButton sender: UIButton!) {
        loadChatItems(false)
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        var params: [String: AnyObject] = [
            "chat[message]": text
        ]
        
        if let receiverObj = receiver {
            params["chat[receiver_id]"] = receiverObj.id
        } else if let goalObject = goal {
            params["chat[goal_id]"] = goalObject.id
        }
        
        apiClient.createChat(params) { (chat: ChatItem?) in
            if let newChat = chat {
                self.messages.append(newChat)
                self.collectionView.reloadData()
                self.scrollToBottomAnimated(true)
            }
           self.finishSendingMessage()
        }
    }
    

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId() == sender.idStr {
            cell.textView.textColor = UIColor.whiteColor()
        } else {
            cell.textView.textColor = UIColor.blackColor()
        }
        
        let attributes : [String:AnyObject] = [NSForegroundColorAttributeName:cell.textView.textColor!, NSUnderlineStyleAttributeName: 1]
        cell.textView.linkTextAttributes = attributes
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        
        return message.actor
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item];
        
        return NSAttributedString(string: message.formattedCreatedAt!)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }

}
