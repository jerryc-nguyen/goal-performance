//
//  StartGoalNotifyViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class StartGoalNotifyViewController: UIViewController {
    
    var notificationData: AnyObject?
    
    @IBAction func onDoNowButton(sender: AnyObject) {
    }
    
    @IBAction func onRemindLaterButton(sender: AnyObject) {
    }
    
    @IBAction func onNotDoButton(sender: AnyObject) {
        let loginVC = StoryboardManager.sharedInstance.getInitialViewController("Login") as! LoginViewController
        if let window = self.view.window {
            window.rootViewController = loginVC
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
