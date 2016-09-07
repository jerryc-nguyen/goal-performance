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
import AirshipKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var waitLabel: UILabel!
    @IBOutlet weak var bgTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    let realtimeHandler = RealtimeHandler.sharedInstance
    let remoteNotificationManager = RemoteNotificationsManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.loginButton.hidden == true {
            self.waitLabel.hidden = false
        } else {
            self.waitLabel.hidden = true
        }

        self.login()
        
        UIView.animateWithDuration(20, delay: 0, options: .AllowUserInteraction, animations: { 
            self.bgTopConstraint.constant = -30
            self.bgLeadingConstraint.constant = -600
            self.view.layoutIfNeeded()
            }, completion: nil)
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
      //  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.loginButton.hidden = true
        if self.loginButton.hidden == true {
            self.waitLabel.hidden = false
        }

        UIView.animateWithDuration(25, delay: 0, options: .AllowUserInteraction, animations: {
            self.bgTopConstraint.constant = -30
            self.bgLeadingConstraint.constant = -600
            self.view.layoutIfNeeded()
            }, completion: nil)
        print("currentAccessToken", FBSDKAccessToken.currentAccessToken().tokenString)
        APIClient.sharedInstance.loginFacebook(fbAccessToken, completed: { (currentUser) in
            print("currentUser token", currentUser.token)
            
            if let airshipTag = currentUser.airshipTag{
                print("Register airship tag: ", airshipTag)
                self.remoteNotificationManager.airshipPusher.addTag(airshipTag)
                self.realtimeHandler.client?.subscribeToChannels([airshipTag], withPresence: true)
            }
            
            APIClient.currentUser = currentUser
            APIClient.currentUserToken = currentUser.token!
         //   MBProgressHUD.hideHUDForView(self.view, animated: true)
            if currentUser.goalsCount == 0 {
                APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("NewGoal")
            } else {
                APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("Main")
            }
        })
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        FBSDKLoginManager().logOut()
    }

}
