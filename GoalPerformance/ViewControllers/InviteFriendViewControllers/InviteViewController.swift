//
//  InviteViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

class InviteViewController: UIViewController {

    //  MARK: Properties
    @IBOutlet weak var inviteFriendButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isChallenge = true
    var currentGoalSession: GoalSession!
    var apiClient = APIClient.sharedInstance
    var storyboardManager = StoryboardManager.sharedInstance
    
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
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        apiClient.updateGoal(currentGoalSession.goal.id, isChallenge:true) { (result) in
        
            if result {
                let selectInviteVC = self.storyboard?.instantiateViewControllerWithIdentifier("SelectInvite") as! SelectInviteFriendViewController
                selectInviteVC.goalSessionId = self.currentGoalSession.id
                self.navigationController?.pushViewController(selectInviteVC, animated: true)
            } else {
                self.makeAlert("Oops!", message: "Cannot make your goal to be a challenge, try again please")
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
    }
    
    func makeAlert(tittle: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func onDismiss(sender: UIButton) {
        let mainVC = storyboardManager.getViewController("MainTabBarController", storyboard: "Main") as! MainTabBarController
        mainVC.selectedIndex = 2
        self.presentViewController(mainVC, animated: true, completion: nil)
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/
 
    

}
