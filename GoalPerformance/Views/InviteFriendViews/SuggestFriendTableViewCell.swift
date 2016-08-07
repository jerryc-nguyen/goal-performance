//
//  SuggestFriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class SuggestFriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onInvite(sender: UIButton) {
    }
    
    @IBAction func onConnect(sender: UIButton) {
    }

}
