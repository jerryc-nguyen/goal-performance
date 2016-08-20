//
//  RemoteNotificationsManager.swift
//  GoalPerformance
//
//  Created by Welcome on 8/18/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import AirshipKit

class RemoteNotificationsManager {
    static let sharedInstance = RemoteNotificationsManager()
    
    func setupRemoteNotificationSettings() {
        var notificationTypes: UIUserNotificationType = UIUserNotificationType()
        notificationTypes.insert(.Alert)
        notificationTypes.insert(.Badge)
        notificationTypes.insert(.Sound)
        UAirship.push().userNotificationTypes = notificationTypes
        UAirship.push().userPushNotificationsEnabled = true
    }
    
}