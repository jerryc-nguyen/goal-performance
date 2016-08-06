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
        LocalNotificationsManager.sharedInstance.registerStartGoalNotification(goalItem)
        
        print("Notification at:", goalItem.startAt)
        print("Registered notify!", goalItem.notificationKey)
        
        LocalNotificationsManager.sharedInstance.showAllRegisteredNotification()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            
            print("currentAccessToken", FBSDKAccessToken.currentAccessToken())
            APIClient.sharedInstance.loginFacebook(FBSDKAccessToken.currentAccessToken().tokenString, completed: { (currentUser) in
                print("currentUser token", currentUser.token)
                
                //APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("Main")
            })
            
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
            }
        })
    }
}

extension LoginViewController : FBSDKLoginButtonDelegate{
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        FBSDKLoginManager().logOut()
    }

}
