//
//  ChatViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: UIViewController {
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
//
//extension ChatViewController: JSQMessagesCollectionViewDataSource {
//    /**
//     *  Asks the data source for the current sender's display name, that is, the current user who is sending messages.
//     *
//     *  @return An initialized string describing the current sender to display in a `JSQMessagesCollectionViewCell`.
//     *
//     *  @warning You must not return `nil` from this method. This value does not need to be unique.
//     */
//    func senderDisplayName() -> String! {
//        return APIClient.currentUser.displayName
//    }
//    
//    /**
//     *  Asks the data source for the current sender's unique identifier, that is, the current user who is sending messages.
//     *
//     *  @return An initialized string identifier that uniquely identifies the current sender.
//     *
//     *  @warning You must not return `nil` from this method. This value must be unique.
//     */
//    func senderId() -> String! {
//        return APIClient.currentUser.idStr
//    }
//    
//    /**
//     *  Asks the data source for the message data that corresponds to the specified item at indexPath in the collectionView.
//     *
//     *  @param collectionView The collection view requesting this information.
//     *  @param indexPath      The index path that specifies the location of the item.
//     *
//     *  @return An initialized object that conforms to the `JSQMessageData` protocol. You must not return `nil` from this method.
//     */
//    func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
//        return items[indexPath.row]
//    }
//    
//    /**
//     *  Notifies the data source that the item at indexPath has been deleted.
//     *  Implementations of this method should remove the item from the data source.
//     *
//     *  @param collectionView The collection view requesting this information.
//     *  @param indexPath      The index path that specifies the location of the item.
//     */
//    func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
//        
//    }
//    
//    /**
//     *  Asks the data source for the message bubble image data that corresponds to the specified message data item at indexPath in the collectionView.
//     *
//     *  @param collectionView The collection view requesting this information.
//     *  @param indexPath      The index path that specifies the location of the item.
//     *
//     *  @return An initialized object that conforms to the `JSQMessageBubbleImageDataSource` protocol. You may return `nil` from this method if you do not
//     *  want the specified item to display a message bubble image.
//     *
//     *  @discussion It is recommended that you utilize `JSQMessagesBubbleImageFactory` to return valid `JSQMessagesBubbleImage` objects.
//     *  However, you may provide your own data source object as long as it conforms to the `JSQMessageBubbleImageDataSource` protocol.
//     *
//     *  @warning Note that providing your own bubble image data source objects may require additional
//     *  configuration of the collectionView layout object, specifically regarding its `messageBubbleTextViewFrameInsets` and `messageBubbleTextViewTextContainerInsets`.
//     *
//     *  @see JSQMessagesBubbleImageFactory.
//     *  @see JSQMessagesCollectionViewFlowLayout.
//     */
//    func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//        return nil
//    }
//    
//    /**
//     *  Asks the data source for the avatar image data that corresponds to the specified message data item at indexPath in the collectionView.
//     *
//     *  @param collectionView The collection view requesting this information.
//     *  @param indexPath      The index path that specifies the location of the item.
//     *
//     *  @return A initialized object that conforms to the `JSQMessageAvatarImageDataSource` protocol. You may return `nil` from this method if you do not want
//     *  the specified item to display an avatar.
//     *
//     *  @discussion It is recommended that you utilize `JSQMessagesAvatarImageFactory` to return valid `JSQMessagesAvatarImage` objects.
//     *  However, you may provide your own data source object as long as it conforms to the `JSQMessageAvatarImageDataSource` protocol.
//     *
//     *  @see JSQMessagesAvatarImageFactory.
//     *  @see JSQMessagesCollectionViewFlowLayout.
//     */
//    func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> ChatUser! {
//        return items[indexPath.row].actor
//    }
//    
//}
//
//extension ChatViewController: JSQMessagesCollectionViewDelegateFlowLayout {
//    
//}