//
//  ChatBuddiesTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 9/4/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class ChatBuddiesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var goalName: UILabel!
    
    @IBOutlet weak var userAvatarImgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var myChatItem: ChatItem? {
        didSet {
            let sender = myChatItem?.actor
            
            userAvatarImgView.sd_setImageWithURL(sender!.avatarUrl)
            userNameLabel.text = sender?.displayName
            messageLabel.text = myChatItem?.message
            dateLabel.text = myChatItem?.formattedCreatedAt
            goalName.text = myChatItem?.goal?.detailName
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
