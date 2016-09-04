//
//  ChatUser.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import SDWebImage

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
        var image = UIImage()
        let manager = SDWebImageManager.sharedManager()
        manager.downloadImageWithURL(self.avatarUrl, options: SDWebImageOptions.CacheMemoryOnly, progress: { (i: Int, j: Int) in
            
        }) { (downloadedImage: UIImage!, error: NSError!, cache: SDImageCacheType, bool: Bool, url: NSURL!) in
            image = downloadedImage
        }
        return image
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
        return UIImage(named: "goal buddy")
    }
    
    static func fakeData() -> ChatUser {
        let data: [String: AnyObject] = [
            "id": 2,
            "id_str": "2",
            "display_name": "Tấn Lâm Trần",
            "email": "trankind@gmail.com",
            "avatar_url": "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xtp1/v/t1.0-1/p50x50/12105892_1220080941351772_8477295691115486798_n.jpg?oh=57e5bf166ff758cb6d1442e1cb498711&oe=585B4509&__gda__=1482563080_98be925169b95f9d572285c1274aea9b",
            "first_name": "",
            "last_name": "",
            "birthday": "",
            "phone_number": "",
            "latitude": "10.801072",
            "longitude": "106.6254213",
            "created_at": "2016-08-25T18:32:30.879+07:00",
            "token": "e6d54ae460c24f9fd4299745e7de2e95",
            "goal_count": 1,
            "is_friend": false,
            "is_pending_friend": false,
            "airship_tag": "user-2"
        ]
        
        return ChatUser(dictionary: data)
    }
    
}
