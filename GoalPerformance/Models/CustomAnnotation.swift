//
//  CustomAnnotation.swift
//  GoalPerformance
//
//  Created by Lam Tran on 9/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var friend: User!
    var photo: UIImage!
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: friend.latitude!, longitude: friend.longitude!)
    }
    
    var title: String? {
        return friend.displayName
    }
    
    var avartarUrl:NSURL {
        return friend.avatarUrl!
    }
    
    var listGoal: String {
        var activeGoal: String = ""
        
        if (friend.activeGoals?.count > 0) {
            for goal in friend.activeGoals! {
                activeGoal += "\(goal.detailName) +\n"
            }
            
        }
        
        return activeGoal
    }
    
    
    var thumbnail: UIImage? {
        if let photo = photo {
            let resizeRenderImageView = UIImageView(frame: CGRectMake(0, 0, 45, 45))
            resizeRenderImageView.layer.borderColor = UIColor.whiteColor().CGColor
            resizeRenderImageView.layer.borderWidth = 3.0
            resizeRenderImageView.contentMode = UIViewContentMode.ScaleAspectFill
            resizeRenderImageView.setImageWithURL(avartarUrl)
            
            UIGraphicsBeginImageContext(resizeRenderImageView.frame.size)
            resizeRenderImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return thumbnail
        }
        return nil
    }
    
    init(friend: User) {
        self.friend = friend
    }
}