//
//  UsersGoalSectionHeaderView.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class UsersGoalSectionHeaderView: UIView {

    
    @IBOutlet weak var goalNameLabel: UILabel!
    
    @IBOutlet weak var countDownTimerWrapper: UIView!
    
    @IBOutlet weak var countDownTimerLabel: UILabel!
    
    @IBOutlet weak var countDownTimerImgView: UIImageView!
    
    @IBOutlet weak var challengeImgView: UIImageView!
   // @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    var goal: Goal? {
        didSet {
            goalNameLabel.text = goal!.detailName
            showCountdownLabel()
            showChallengeIcon()
//            countDownTimerImgView.image = UIImage.fontAwesomeIconWithName(.Hourglass, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
//            challengeImgView.image = UIImage.fontAwesomeIconWithName(.Users, textColor: UIColor.blackColor(), size: CGSize(width: 30, height: 30))
        }
    }
    
    
    func showChallengeIcon() {
        if goal?.isChallenge == true {
            
        } else {
            challengeImgView.hidden = true
        }
        
    }
    
    func showCountdownLabel() {
        if goal?.isDoingTime == true {
            //set image
            
            
            //set background
            backgroundColor = UIColors.GoalDoingBackground
            
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
