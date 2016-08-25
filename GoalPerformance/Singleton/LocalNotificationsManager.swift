//
//  LocalNotificationsManager.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

let AlarmSoundName = "clockalarm"
let AlarmSoundExtension = "caf"
let StartGoalNotificationActionCategory = "StartGoalNotificationActionCategory"

struct LocalNotificationName {
    static let StartGoal: String = "StartGoal"
    static let EndGoal: String = "EndGoal"
}

class LocalNotificationsManager {
    
    static let sharedInstance = LocalNotificationsManager()
    
    var window: UIWindow?
    var isViewOpenByUser: Bool = false
    
    func setupLocalNotificationSettings() {
        
        var notificationTypes: UIUserNotificationType = UIUserNotificationType()
        notificationTypes.insert(UIUserNotificationType.Alert)
        notificationTypes.insert(UIUserNotificationType.Badge)
        notificationTypes.insert(UIUserNotificationType.Sound)

        // Register the notification settings.
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
    }
    
    func removeNotificationItemFor(notificationID: String) {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return}
        
        for notification in scheduledNotifications! {
            if (notification.userInfo!["UUID"] as! String == notificationID) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
    }
    
    func removeNotificationHasKeyContains(string: String) {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return}
        
        for notification in scheduledNotifications! {
            let currentKey = notification.userInfo!["UUID"] as! String
            if (currentKey.containsString(string)) {
                print("Removing key: \(currentKey) contains string: \(string)")
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
    }
    
    func showAllRegisteredNotification() {
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return} // Nothing to remove, so return
        
        for notification in scheduledNotifications! { // loop through notifications...
            if let id = notification.userInfo!["UUID"] as? String {
                print("\(id) - start at: \(notification.fireDate)")
            }
        }
    }
    
    func clearAllNotification() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func handleStartGoalNotification(notification: UILocalNotification) {
        
    }
    
    func handleEndGoalNotification(notification: UILocalNotification) {
        
    }
    
    func showStartGoalVCFor(notification: UILocalNotification) {
        let startGoalNotifyVC = StoryboardManager.sharedInstance.getViewController("StartGoalNotifyViewController", storyboard: "GoalStartEnd") as! StartGoalNotifyViewController
        startGoalNotifyVC.notificationData = notification.userInfo
        startGoalNotifyVC.isViewOpenByUser = isViewOpenByUser
        window?.rootViewController = startGoalNotifyVC
    }
    
    func showEndGoalVCFor(notification: UILocalNotification) {
        let endGoalNotifyVC = StoryboardManager.sharedInstance.getViewController("EndGoalNotifyViewController", storyboard: "GoalStartEnd") as! EndGoalNotifyViewController
        endGoalNotifyVC.notificationData = notification.userInfo
        endGoalNotifyVC.isViewOpenByUser = isViewOpenByUser
        window?.rootViewController = endGoalNotifyVC
    }
    
    func handleLocalPushNotification(notification: UILocalNotification) {
        if let notificationName = notification.userInfo!["notificationName"] as? String {
            switch(notificationName) {
            case LocalNotificationName.StartGoal:
                print("Start goal", isViewOpenByUser)
                showStartGoalVCFor(notification)
            case LocalNotificationName.EndGoal:
                print("End goal", isViewOpenByUser)
                showEndGoalVCFor(notification)
                
            default:
                return
            }
        }
    }
    
    
}
