//
//  FriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {


    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendGoal: UILabel!
    @IBOutlet weak var challengeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onChallengeClick(sender: UIButton) {
    }
    
}
