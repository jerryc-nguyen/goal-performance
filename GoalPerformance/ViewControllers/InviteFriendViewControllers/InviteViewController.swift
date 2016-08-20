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
    @IBOutlet weak var inviteFriendButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    var isChallenge = true
    var currentGoalSession: GoalSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        initView()
    }
    
    func initView(){
        //  Custom next button
        inviteFriendButton.makeCircle()
        inviteFriendButton.layer.borderColor = UIColor(netHex: 0xff4800).CGColor
        inviteFriendButton.layer.borderWidth = 2
        
        dismissButton.layer.borderColor = UIColor(netHex: 0xff4800).CGColor
        dismissButton.layer.borderWidth = 2
        dismissButton.layer.cornerRadius = 5
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "InviteFriend" {
            let selectFriendVC = segue.destinationViewController as! SelectInviteFriendViewController
            selectFriendVC.goalSessionId = currentGoalSession.id
        }
        
    }
    

}
