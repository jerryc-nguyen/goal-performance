//
//  LocalNotificationsManager.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

let StartGoalNotificationActionCategory = "StartGoalNotificationActionCategory"

class LocalNotificationsManager {
    
    static let sharedInstance = LocalNotificationsManager()
    
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
        removeNotificationItemFor(goal.notificationKey)
        
        let notification = UILocalNotification()
        let message = "Goal \(goal.name) ending time!" // text that will be displayed in the notification
        notification.alertBody = message // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["message": message, "UUID": goal.notificationKey, "notificationName": "startGoal"] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = StartGoalNotificationActionCategory
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func registerEndGoalNotification(goal: Goal) {
        
        // clear old notification data
        clearAllNotification()
        removeNotificationItemFor(goal.notificationKey)
        
        let notification = UILocalNotification()
        let message = "Goal \(goal.name) ending time!" // text that will be displayed in the notification
        notification.alertBody = message
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = goal.startAt // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["message": message, "UUID": goal.notificationKey, "notificationName": "endGoal"] // assign a unique identifier to the notification so that we can retrieve it later
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
    
}
