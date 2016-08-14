//
//  UserGoalTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class UserGoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goalNameLabel: UILabel!
    
    @IBOutlet weak var countDownTimerWrapper: UIView!
    
    @IBOutlet weak var countDownTimerLabel: UILabel!
    
    @IBOutlet weak var countDownTimerImgView: UIImageView!
    
    @IBOutlet weak var challengeImgView: UIImageView!
    
    var goal: Goal? {
        didSet {
            goalNameLabel.text = goal!.detailName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
