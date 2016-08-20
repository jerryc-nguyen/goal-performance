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
    var currentGoals: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func initView(){
        //  Custom next button
        inviteFriendButton.makeCircle()
        inviteFriendButton.layer.borderColor = UIColor(netHex: 0xff4800).CGColor
        inviteFriendButton.layer.borderWidth = 1
        
        dismissButton.layer.borderColor = UIColor(netHex: 0xff4800).CGColor
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.cornerRadius = 10
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "InviteFriend" {
            let selectFriendVC = segue.destinationViewController as! SelectInviteFriendViewController
            selectFriendVC.goalID = (currentGoals?.id)!
        }
        
    }
    

}
