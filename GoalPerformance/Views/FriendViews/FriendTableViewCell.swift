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
    @IBOutlet weak var challengeImage: UIImageView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var currentGoalsLabel: UILabel!
    
    var friend:User! {
        didSet {
            friendImage.makeCircle()
            friendImage.sd_setImageWithURL(friend.avatarUrl)
            friendName.text = friend.displayName
        }
    }
    
    var apiClient:APIClient!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onAccept(sender: UIButton) {
        apiClient.acceptFriend(friend.id!) { (title, message) in
            print("\(title): \(message)")
        }
    }

    @IBAction func onReject(sender: UIButton) {
        apiClient.rejectFriend(friend.id!) { (title, message) in
            print("\(title): \(message)")
        }
    }
    
}
