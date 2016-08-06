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
    
    func setupStartGoalNotificationSettings() {

        var notificationTypes: UIUserNotificationType = UIUserNotificationType()
        notificationTypes.insert(UIUserNotificationType.Alert)
        notificationTypes.insert(UIUserNotificationType.Badge)
        notificationTypes.insert(UIUserNotificationType.Sound)
        
        // Specify the notification actions.
        let justInformAction = UIMutableUserNotificationAction()
        justInformAction.identifier = "justInform"
        justInformAction.title = "OK, got it"
        justInformAction.activationMode = UIUserNotificationActivationMode.Foreground
        justInformAction.destructive = false
        justInformAction.authenticationRequired = false
        
        let modifyListAction = UIMutableUserNotificationAction()
        modifyListAction.identifier = "editList"
        modifyListAction.title = "Edit list"
        modifyListAction.activationMode = UIUserNotificationActivationMode.Foreground
        modifyListAction.destructive = false
        modifyListAction.authenticationRequired = true
        
        let trashAction = UIMutableUserNotificationAction()
        trashAction.identifier = "trashAction"
        trashAction.title = "Delete list"
        trashAction.activationMode = UIUserNotificationActivationMode.Background
        trashAction.destructive = true
        trashAction.authenticationRequired = true
        
        let actionsArray = NSArray(objects: justInformAction, modifyListAction, trashAction) as! [UIUserNotificationAction]
        let actionsArrayMinimal = NSArray(objects: modifyListAction, trashAction) as! [UIUserNotificationAction]
        
        // Specify the category related to the above actions.
        let goalReminderCategory = UIMutableUserNotificationCategory()
        goalReminderCategory.identifier = StartGoalNotificationActionCategory
        goalReminderCategory.setActions(actionsArray, forContext: UIUserNotificationActionContext.Default)
        goalReminderCategory.setActions(actionsArrayMinimal, forContext: UIUserNotificationActionContext.Minimal)
        
        let categoriesForSettings = NSSet(objects: goalReminderCategory) as! Set<UIUserNotificationCategory>
        
        // Register the notification settings.
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
    }
    
    func registerStartGoalNotification(goal: Goal) {
        // clear old notification data
        clearAllNotification()
        removeNotificationItemFor(goal.notificationStartKey)
        
        let notification = UILocalNotification()
        let message = "Goal \(goal.name) ending time!" // text that will be displayed in the notification
        notification.alertBody = message // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = "\(AlarmSoundName).\(AlarmSoundExtension)"
        notification.userInfo = ["message": message, "UUID": goal.notificationStartKey, "notificationName": LocalNotificationName.StartGoal] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = StartGoalNotificationActionCategory
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func registerEndGoalNotification(goal: Goal) {
        
        // clear old notification data
        clearAllNotification()
        removeNotificationItemFor(goal.notificationEndKey)
        
        let notification = UILocalNotification()
        let message = "Goal \(goal.name) ending time!" // text that will be displayed in the notification
        notification.alertBody = message
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = "\(AlarmSoundName).\(AlarmSoundExtension)"
        notification.userInfo = ["message": message, "UUID": goal.notificationEndKey, "notificationName": LocalNotificationName.EndGoal] // assign a unique identifier to the notification so that we can retrieve it later
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
                print("Start goal")
                showStartGoalVCFor(notification)
            case LocalNotificationName.EndGoal:
                print("End goal")
                showEndGoalVCFor(notification)
                
            default:
                return
            }
        }
    }
    
    
}
