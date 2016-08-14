//
//  InviteViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {

    //  MARK: Properties
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var inviteFriendButton: UIButton!
    
    var isChallenge = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChallengeClick(sender: UIButton) {
        if isChallenge {
            challengeButton.setBackgroundImage(UIImage(named: "check"), forState: .Normal)
            isChallenge = false
            inviteFriendButton.enabled = false
        } else {
            challengeButton.setBackgroundImage(UIImage(named: "unCheck"), forState: .Normal)
            isChallenge = false
            inviteFriendButton.enabled = true
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
