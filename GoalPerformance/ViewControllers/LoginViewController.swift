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
import PKHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
//    @IBAction func onNotificationButton(sender: AnyObject) {
//        
//        APIClient.sharedInstance.goalDetail(["goal_id": 37]) { (goal) in
//            goal.debugInfo()
//            goal.registerStartGoalNotifications()
//        }
//        
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.login()
    }
    
    @IBAction func loginWithFacebook(sender: UIButton) {
        self.login()
    }
    func login() {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            authWithAPIServer(FBSDKAccessToken.currentAccessToken().tokenString)
        } else {
            let loginManager = FBSDKLoginManager()
            let permisions = ["public_profile", "email", "user_friends"]
            loginManager.logInWithReadPermissions(permisions, fromViewController: self, handler: { [weak self] (result, error) in
                guard let strongSelf = self else { return }
                
                if ((error) != nil) {
                    // Process error
                } else if result.isCancelled {
                    // Handle cancellations
                } else {
                    strongSelf.authWithAPIServer(FBSDKAccessToken.currentAccessToken().tokenString)
                }
                })
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
        HUD.show(.Progress)
        self.loginButton.hidden = true
        print("currentAccessToken", FBSDKAccessToken.currentAccessToken().tokenString)
        APIClient.sharedInstance.loginFacebook(fbAccessToken, completed: { (currentUser) in
            print("currentUser token", currentUser.token)
            APIClient.currentUser = currentUser
            APIClient.currentUserToken = currentUser.token!
            HUD.hide()
            APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("NewGoal")
        })
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        FBSDKLoginManager().logOut()
    }

}
