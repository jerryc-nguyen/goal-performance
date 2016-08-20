//
//  AppDelegate.swift
//  GoalPerformance
//
//  Created by Welcome on 7/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import AirshipKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    var window: UIWindow?
    
    let localNotificationManager = LocalNotificationsManager.sharedInstance
    let remoteNotificationManager = RemoteNotificationsManager.sharedInstance
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Handle notification:
        // http://stackoverflow.com/questions/16393673/detect-if-the-app-was-launched-opened-from-a-push-notification
        if (launchOptions != nil) {
            
            // For local Notification
            if let localNotification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] as? UILocalNotification {
                localNotificationManager.isViewOpenByUser = true
                localNotificationManager.handleLocalPushNotification(localNotification)
            }
        }
        
        remoteNotificationManager.setupRemoteNotificationSettings()
        
        let loginVC = StoryboardManager.sharedInstance.getInitialViewController("Login") as! LoginViewController
        self.window?.rootViewController = loginVC
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            openURL: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("received notification", notification.userInfo)
        localNotificationManager.window = window
        localNotificationManager.isViewOpenByUser = false
        localNotificationManager.handleLocalPushNotification(notification)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if identifier == "editList" {
            //NSNotificationCenter.defaultCenter().postNotificationName("modifyListNotification", object: nil)
        }
        else if identifier == "trashAction" {
            //NSNotificationCenter.defaultCenter().postNotificationName("deleteListNotification", object: nil)
        }
        
        print("handleActionWithIdentifier", identifier)
        
        completionHandler()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        UAirship.push().appRegisteredForRemoteNotificationsWithDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UAirship.push().appRegisteredUserNotificationSettings()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("didReceiveRemoteNotification")
        UAirship.push().appReceivedRemoteNotification(userInfo, applicationState: application.applicationState)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        UAirship.push().appReceivedRemoteNotification(userInfo,
                                                      applicationState:application.applicationState,
                                                      fetchCompletionHandler:completionHandler)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        UAirship.push().appReceivedActionWithIdentifier(identifier!,
                                                        notification: userInfo,
                                                        applicationState: application.applicationState,
                                                        completionHandler: completionHandler)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        
        UAirship.push().appReceivedActionWithIdentifier(identifier!,
                                                        notification: userInfo,
                                                        responseInfo: responseInfo,
                                                        applicationState: application.applicationState,
                                                        completionHandler: completionHandler)
    }

    func receivedForegroundNotification(notification: [NSObject : AnyObject], fetchCompletionHandler completionHandler: ((UIBackgroundFetchResult) -> Void)) {
        // Called when the app receives a foreground notification. Includes the notification dictionary.
        
        // Call the completion handler
        completionHandler(UIBackgroundFetchResult.NoData)
    }
    
    func displayNotificationAlert(alertMessage: String) {
        // Called when an alert notification is received in the foreground. Includes a simple string to be displayed as an alert.
    }

}



