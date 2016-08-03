//
//  LoginViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func onLoginButton(sender: AnyObject) {
        //test API
        APIClient.sharedInstance.friends { (friends) in
            print("Friends", friends)
        }
        
//        APP_DELEGATE.window?.rootViewController = StoryboardManager.sharedInstance.getInitialViewController("Main")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
