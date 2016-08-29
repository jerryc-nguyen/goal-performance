//
//  ChatUser.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatUser: NSObject, JSQMessageAvatarImageDataSource {
    
    let id:Int?
    let idStr: String?
    let displayName: String?
    var avatarUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        idStr = dictionary["id_str"] as? String
        displayName = dictionary["display_name"] as? String

        
        let avatarUrl = dictionary["avatar_url"] as? String
        if let avatarUrl = avatarUrl {
            self.avatarUrl = NSURL(string: avatarUrl)
        }
    }
    
    func avatarImage() -> UIImage! {
        let image_data = NSData(contentsOfURL: self.avatarUrl!)
        return UIImage(data: image_data!)
    }
    
    /**
     *  @return The avatar image for a highlighted display state.
     *
     *  @discussion You may return `nil` from this method if this does not apply.
     */
  
    func avatarHighlightedImage() -> UIImage! {
        return avatarImage()
    }
    
    /**
     *  @return A placeholder avatar image to be displayed if avatarImage is not yet available, or `nil`.
     *  For example, if avatarImage needs to be downloaded, this placeholder image
     *  will be used until avatarImage is not `nil`.
     *
     *  @discussion If you do not need support for a placeholder image, that is, your images
     *  are stored locally on the device, then you may simply return the same value as avatarImage here.
     *
     *  @warning You must not return `nil` from this method.
     */

    func avatarPlaceholderImage() -> UIImage! {
        return avatarImage()
    }
}
