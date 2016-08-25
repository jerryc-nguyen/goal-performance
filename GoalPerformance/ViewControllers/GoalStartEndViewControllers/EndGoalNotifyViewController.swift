//
//  EndGoalNotifyViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import AVFoundation

class EndGoalNotifyViewController: UIViewController {
    
    var notificationData: AnyObject!
    var isViewOpenByUser: Bool = false
    var player: AVAudioPlayer?
    
    @IBOutlet weak var scoreTxt: UITextField!

    @IBAction func onCompleteButton(sender: UIButton) {
        let score = sender.accessibilityLabel
        if let goalId = notificationData["goalId"] as? Int {
            let params : [String : AnyObject] = [
                "status" : "completed",
                "goal_id": goalId,
                "score": score!
            ]
            updateGoalStatus(params)
        } else {
            Utils.displayTabbarVCFor(HomeTimelineTabbarIndex)
        }
    }
    
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
    
    func updateGoalStatus(params : [String : AnyObject]) {
        APIClient.sharedInstance.updateGoalStatus(params, completed: { (goalSession: GoalSession?) in
            print("sent goalStartEnd status", goalSession)
            Utils.displayTabbarVCFor(UserTimelineTabbarIndex)
        })
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
