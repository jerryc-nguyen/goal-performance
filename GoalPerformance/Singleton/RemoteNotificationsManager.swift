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
    
    let config = UAConfig.defaultConfig()
    var airshipPusher: UAPush!
    
    /* Create a custom push notification handler property */
    var customPushDelegate = CustomNotificationHandler()
    
    func setupRemoteNotificationSettings() {
        //airship configuration
        
        config.automaticSetupEnabled = false
        config.inProduction = false
        UAirship.takeOff(config)
        
        var notificationTypes: UIUserNotificationType = UIUserNotificationType()
        notificationTypes.insert(.Alert)
        notificationTypes.insert(.Badge)
        notificationTypes.insert(.Sound)
        
        airshipPusher = UAirship.push()
        airshipPusher.userNotificationTypes = notificationTypes
        airshipPusher.userPushNotificationsEnabled = true
        airshipPusher.pushNotificationDelegate = customPushDelegate
        
        let channelID = airshipPusher.channelID
        print("My Application Channel ID: \(channelID)")
    
    }
    
}

class CustomNotificationHandler: NSObject, UAPushNotificationDelegate  {
    
    func receivedForegroundNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        NSLog("UALib: %@", "Received a notification while the app was already in the foreground: \(notification)")
        
        /*
         Called when a push is received when the app is in the foreground
         You can work with the notification object here
         
         Be sure to call the completion handler with a UIBackgroundFetchResult
         */
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    func launchedFromNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        NSLog("UALib: %@", "The application was launched or resumed from a notification: \(notification)");
        
        /*
         Called when the app is launched/resumed by interacting with the notification
         You can work with the notification object here
         
         Be sure to call the completion handler with a UIBackgroundFetchResult
         */
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    
    func receivedBackgroundNotification(notification: [NSObject : AnyObject], actionIdentifier identifier: String, completionHandler: () -> Void) {
        NSLog("UALib: %@", "The application was started in the background from a user notification button");
        
        /*
         Called when the app is launched/resumed by interacting with a notification button
         You can work with the notification object here
         */
        
        completionHandler()
    }
    
    func receivedBackgroundNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        NSLog("UALib: %@", "A CONTENT_AVAILABLE notification was received with the app in the background: \(notification)");
        /*
         Called when the app is in the background and a CONTENT_AVAILABLE notification is received
         Do something with the notification in the background
         
         Be sure to call the completion handler with a UIBackgroundFetchResult
         */
        completionHandler(UIBackgroundFetchResult.NoData)
    }
}