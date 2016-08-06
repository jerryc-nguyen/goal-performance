//
//  LocalNotificationsManager.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class LocalNotificationsManager {
    
    static let sharedInstance = LocalNotificationsManager()
    
    func registerGoalStartingNotification(goal: Goal) {
        
        // clear old notification data
        removeNotificationItemFor(goal.notificationKey)
        
        let notification = UILocalNotification()
        notification.alertBody = "Goal \(goal.name) starting time!" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": goal.name!, "UUID": goal.notificationKey] // assign a unique identifier to the notification so that we can retrieve it later
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func registerGoalEndingNotification(goal: Goal) {
        
        // clear old notification data
        removeNotificationItemFor(goal.notificationKey)
        
        let notification = UILocalNotification()
        notification.alertBody = "Goal \(goal.name) ending time!" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": goal.name!, "UUID": goal.notificationKey] // assign a unique identifier to the notification so that we can retrieve it later
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func removeNotificationItemFor(notificationID: String) {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return} // Nothing to remove, so return
        
        for notification in scheduledNotifications! { // loop through notifications...
            if (notification.userInfo!["UUID"] as! String == notificationID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                UIApplication.sharedApplication().cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                break
            }
        }
    }
    
    func showAllRegisteredNotification() {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return} // Nothing to remove, so return
        
        for notification in scheduledNotifications! { // loop through notifications...
            let id = notification.userInfo!["UUID"] as! String
            print("\(id) - start at: \(notification.fireDate)")
        }
    }
    
}
