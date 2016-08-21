//
//  SuggestFriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SuggestFriendTableViewCellDelegate: class {
    func displayAlert(viewCell: SuggestFriendTableViewCell, button: String, status: Int, title: String, message: String)
}

class SuggestFriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var connectFriendButton: UIButton!
    @IBOutlet weak var inviteJoinGoalButton: UIButton!
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
            avatarImage.makeCircle()
            avatarImage.sd_setImageWithURL(friend.avatarUrl)
            nameLabel.text = friend.displayName
            if (friend.isFriend != nil && friend.isPendingFriend != nil) {
                if friend.isPendingFriend == true {
                    connectFriendButton.setBackgroundImage(UIImage(named: "pending")!, forState: .Disabled)
                    connectFriendButton.enabled = false
                } else {
                    if friend.isFriend == true {
                        connectFriendButton.setBackgroundImage(UIImage(named: "connected")!, forState: .Disabled)
                        connectFriendButton.enabled = false
                    } else {
                        connectFriendButton.setBackgroundImage(UIImage(named: "add")!, forState: .Normal)
                        connectFriendButton.enabled = true
                    }
                    
                }
            }
        }
    }
    
    var currentView: UIView!
    var goalSessionId: Int!
    var apiClient: APIClient!
    weak var delegate: SuggestFriendTableViewCellDelegate!
    
    @IBAction func onInvite(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(currentView, animated: true)
        apiClient.inviteGoal(goalSessionId, friendID: friend.id!) { (status, title, message) in
            self.delegate.displayAlert(self, button: "InviteButton", status: status, title: title, message: message)
            MBProgressHUD.hideHUDForView(self.currentView, animated: true)
        }
    }
    
    @IBAction func onConnect(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(currentView, animated: true)
        apiClient.connectFriend(friend.id!) { (title, message) in
            self.delegate.displayAlert(self, button: "ConnectButton", status: 0, title: title, message: message)
            MBProgressHUD.hideHUDForView(self.currentView, animated: true)
        }
    }

}
