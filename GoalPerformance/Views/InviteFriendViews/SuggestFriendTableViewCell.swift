//
//  SuggestFriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol SuggestFriendTableViewCellDelegate: class {
    func displayAlert(viewCell: SuggestFriendTableViewCell, title: String, message: String)
}

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
    
    var friend: User! {
        didSet {
            nameLabel.text = friend.displayName
            avatarImage.sd_setImageWithURL(friend.avatarUrl)
        }
    }
    
    var goalID: Int!
    var apiClient: APIClient!
    weak var delegate: SuggestFriendTableViewCellDelegate!
    
    @IBAction func onInvite(sender: UIButton) {
        apiClient.inviteGoal(goalID, friendID: friend.id!) { (title, message) in
            self.delegate.displayAlert(self, title: title, message: message)
        }
    }
    
    @IBAction func onConnect(sender: UIButton) {
        
    }

}
