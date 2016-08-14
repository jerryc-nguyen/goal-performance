//
//  LoginViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    @IBAction func onNotificationButton(sender: AnyObject) {
        
        //test API
//        APIClient.sharedInstance.friends { (friends) in
//            print("Friends", friends)
//        }
        let goalData = [
                "id": 1,
                "name": "Swimming everyday! at 14:20",
                "start_at": "2016-08-06T06:00:00.000+07:00",
                "repeat_every": "",
                "duration": 10,
                "sound_name": "sound_name",
                "is_challenge": true,
                "is_default": true
        ]
        
        let goalItem = Goal(dictionary: goalData)
        let today = NSDate()
        goalItem.startAt = today.dateByAddingTimeInterval(5)
        LocalNotificationsManager.sharedInstance.registerEndGoalNotification(goalItem)
        
        print("Notification at:", goalItem.startAt)
        print("Registered notify!", goalItem.notificationEndKey)
        
        LocalNotificationsManager.sharedInstance.showAllRegisteredNotification()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            authWithAPIServer(FBSDKAccessToken.currentAccessToken().tokenString)
            
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
}

extension LoginViewController : FBSDKLoginButtonDelegate{
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            authWithAPIServer(FBSDKAccessToken.currentAccessToken().tokenString)
        }
    }
    
    func authWithAPIServer(fbAccessToken: String) {
        
        print("currentAccessToken", FBSDKAccessToken.currentAccessToken())
        APIClient.sharedInstance.loginFacebook(fbAccessToken, completed: { (currentUser) in
            print("currentUser token", currentUser.token)
            APIClient.currentUser = currentUser
            //APIClient.currentUserToken = currentUser.token!
            APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("Main")
        })
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        FBSDKLoginManager().logOut()
    }

}
