//
//  StartGoalNotifyViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import AVFoundation

class StartGoalNotifyViewController: UIViewController {
    
    var notificationData: AnyObject!
    var isViewOpenByUser: Bool = false
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationData = notificationData as? NSDictionary ?? [String: AnyObject]()
        
        if !isViewOpenByUser {
            let url = NSBundle.mainBundle().URLForResource(AlarmSoundName, withExtension: AlarmSoundExtension)!
            
            do {
                player = try AVAudioPlayer(contentsOfURL: url)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDoNowButton(sender: AnyObject) {
        if let goalId = notificationData["goalId"] as? Int {
            let params : [String : AnyObject] = [
                "status" : "doing",
                "goal_id": goalId
            ]
            updateGoalStatus(params)
        } else {
            showHomeTimelineView()
        }
    }
    
    @IBAction func onRemindLaterButton(sender: AnyObject) {
        if let goalId = notificationData["goalId"] as? Int {
            
            let params : [String : AnyObject] = [
                "goal_id": goalId,
                "status" : "remind_later",
                "remind_user_at" : "15:00 PM"
            ]
            updateGoalStatus(params)
        } else {
            showHomeTimelineView()
        }
    }
    
    @IBAction func onNotDoButton(sender: AnyObject) {
        if let goalId = notificationData["goalId"] as? Int {
            let params : [String : AnyObject] = [
                "status" : "cannot_make_today",
                "goal_id": goalId
            ]
            updateGoalStatus(params)
        } else {
            showHomeTimelineView()
        }
    }
    
    func backToHomeTimeline() {
        let loginVC = StoryboardManager.sharedInstance.getInitialViewController("Login") as! LoginViewController
        if let window = self.view.window {
            window.rootViewController = loginVC
        }
    }
    
    func updateGoalStatus(params : [String : AnyObject]) {
        APIClient.sharedInstance.updateGoalStatus(params, completed: { (goalSession: GoalSession?) in
            print("sent goalStartEnd status", goalSession)
            if let window = self.view.window {
                Utils.displayTabbarVCFor(window, selectedTabbarIndex: UserTimelineTabbarIndex)
            }
        })
    }
    
    func showHomeTimelineView() {
        if let window = self.view.window {
            Utils.displayTabbarVCFor(window, selectedTabbarIndex: HomeTimelineTabbarIndex)
        }
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
