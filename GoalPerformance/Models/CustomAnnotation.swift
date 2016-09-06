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
    var friend: User
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: friend.latitude!, longitude: friend.longitude!)
    }
    
    var nameFriend: String? {
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
    
    init(friend: User) {
        self.friend = friend
    }
}