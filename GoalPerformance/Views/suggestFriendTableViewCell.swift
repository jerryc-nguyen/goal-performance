//
//  suggestFriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/5/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class suggestFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func inviteFriendOnClick(sender: AnyObject) {
        
    }
    
    @IBAction func connectFriendOnClick(sender: UIButton) {
        
    }
    

}