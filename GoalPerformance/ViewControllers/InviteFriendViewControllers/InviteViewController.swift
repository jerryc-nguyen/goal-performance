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
    @IBOutlet weak var titleLabel: UILabel!
    
    var isChallenge = true
    var currentGoalSession: GoalSession!
    var apiClient = APIClient.sharedInstance
    
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
        titleLabel.textColor = UIColors.ThemeOrange
        //  Custom next button
        inviteFriendButton.makeCircle()
        inviteFriendButton.layer.borderColor = UIColors.ThemeOrange.CGColor
        inviteFriendButton.layer.borderWidth = 1
        
        dismissButton.layer.borderColor = UIColors.ThemeOrange.CGColor
        dismissButton.setTitleColor(UIColors.ThemeOrange, forState: .Normal)
        dismissButton.layer.borderWidth = 1
        dismissButton.layer.cornerRadius = 10
    }
    
    
    @IBAction func onInvite(sender: UIButton) {
//        apiClient.updateGoal(true) { (result) in
//            if result != nil {
//                let selectInviteVC = self.storyboard?.instantiateViewControllerWithIdentifier("SelectInvite") as! SelectInviteFriendViewController
//                selectInviteVC.goalSessionId = self.currentGoalSession.id
//                self.navigationController?.pushViewController(selectInviteVC, animated: true)
//            }
//        }
        
        let selectInviteVC = self.storyboard?.instantiateViewControllerWithIdentifier("SelectInvite") as! SelectInviteFriendViewController
//        selectInviteVC.goalSessionId = self.currentGoalSession.id
        self.navigationController?.pushViewController(selectInviteVC, animated: true)
    }
    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "InviteFriend" {
            let selectFriendVC = segue.destinationViewController as! SelectInviteFriendViewController
//            selectFriendVC.goalSessionId = currentGoalSession.id
        }
        
    }
    

}
