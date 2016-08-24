//
//  SuggestedFriendsTableViewCell.swift
//  GoalPerformance
//
//  Created by sophie on 8/24/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SuggestedFriendsTableViewCellDelegate: class {
    func displayAlert(viewCell: SuggestedFriendsTableViewCell, button: String, status: Int, title: String, message: String)
}

class SuggestedFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalNameLabel: UILabel!
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    weak var delegate: SuggestedFriendsTableViewCellDelegate!
    var apiClient: APIClient!
    var currentView: UIView!
    var goalSessionId: Int!
    var friend: User! {
        didSet {
            profileImgView.makeCircle()
            profileImgView.sd_setImageWithURL(friend.avatarUrl)
            nameLabel.text = friend.displayName
            if (friend.isFriend != nil && friend.isPendingFriend != nil) {
                if friend.isPendingFriend == true {
                    addFriendButton.setBackgroundImage(UIImage(named: "pending")!, forState: .Disabled)
                    addFriendButton.enabled = false
                } else {
                    if friend.isFriend == true {
                        addFriendButton.setBackgroundImage(UIImage(named: "connected")!, forState: .Disabled)
                        addFriendButton.enabled = false
                    } else {
                        addFriendButton.setBackgroundImage(UIImage(named: "add")!, forState: .Normal)
                        addFriendButton.enabled = true
                    }
                    
                }
            }
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
    
    @IBAction func onChallengeAction(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(currentView, animated: true)
        apiClient.connectFriend(friend.id!) { (title, message) in
            self.delegate.displayAlert(self, button: "ChallengeButton", status: 0, title: title, message: message)
            MBProgressHUD.hideHUDForView(self.currentView, animated: true)
        }

    }
    
    @IBAction func onAddFriendAction(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(currentView, animated: true)
        apiClient.inviteGoal(goalSessionId, friendID: friend.id!) { (status, title, message) in
            self.delegate.displayAlert(self, button: "ConnectButton", status: status, title: title, message: message)
            MBProgressHUD.hideHUDForView(self.currentView, animated: true)
        }

    }
    
    

}
