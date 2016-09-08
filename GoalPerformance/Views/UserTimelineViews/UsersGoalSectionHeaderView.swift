//
//  UsersGoalSectionHeaderView.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol UsersGoalSectionHeaderViewDelegate: class {
    func showSettingsView(view: UsersGoalSectionHeaderView)
}

class UsersGoalSectionHeaderView: UIView {

    
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var challengeRightConstraintToSettings: NSLayoutConstraint!
    @IBOutlet weak var goalNameLabel: UILabel!
    
    @IBOutlet weak var countDownTimerWrapper: UIView!
    
    @IBOutlet weak var countDownTimerLabel: UILabel!
    
    @IBOutlet weak var countDownTimerImgView: UIImageView!
    
    @IBOutlet weak var challengeImgView: UIImageView!
    
    @IBOutlet weak var goalBuddiesImgView: UIButton!
    
    @IBOutlet weak var challengeRightSpaceToParent: NSLayoutConstraint!
    
    var delegate: UsersGoalSectionHeaderViewDelegate?
    
    var parentNavigationController: UINavigationController?
    
   // @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    var goal: Goal? {
        didSet {
            goalNameLabel.text = goal!.detailName
            showCountdownLabel()
            showChallengeIcon()
            showBuddiesIcon()
            showSettingButton()
        }
    }
    
    func showSettingButton() {
        if goal?.creatorId == APIClient.currentUser.id {
            print("yay")
        } else {
            settingButton.hidden = true
            //goalBuddiesImgView.hidden = true
            challengeRightConstraintToSettings.constant = -30
        }
    }
    
    @IBAction func onBuddiesChatButton(sender: AnyObject) {
        
        let storyboardManager = StoryboardManager.sharedInstance
        let chatVC = storyboardManager.getViewController("ChatViewController", storyboard: "Chat") as! ChatViewController
        chatVC.goal = self.goal
        self.parentNavigationController?.pushViewController(chatVC, animated: true)
    }
    
    @IBAction func showSettingsView(sender: UIButton) {
        self.delegate?.showSettingsView(self)
    }
    
    
    func showChallengeIcon() {
        if goal?.isChallenge == true {
            challengeImgView.hidden = false
        } else {
            challengeImgView.hidden = true
        }
    }
    
    func showBuddiesIcon() {
        if goal?.buddiesCount > 1 {
            goalBuddiesImgView.hidden = false
        } else {
            goalBuddiesImgView.hidden = true
           // challengeRightSpaceToParent.constant = 10
            challengeRightConstraintToSettings.constant = 10
            self.layoutIfNeeded()
        }
    }
    
    func showCountdownLabel() {
        if goal?.isDoingTime == true {
            //set background
            backgroundColor = UIColors.GoalDoingBackground
            
            //set text color
            goalNameLabel.textColor = UIColor.whiteColor()
            
            countDownTimerLabel.textColor = UIColors.HomeTimelineChartLineColor
            
            //schedule timer
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(countDownTimer), userInfo: nil, repeats: true)
        } else {
            countDownTimerWrapper.hidden = true
        }
    }
    
    func countDownTimer() {
        countDownTimerLabel.text = goal?.remainingTime
    }

    
    class func initFromNib() -> UsersGoalSectionHeaderView! {
        return UINib(nibName:"UsersGoalSectionHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UsersGoalSectionHeaderView
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
