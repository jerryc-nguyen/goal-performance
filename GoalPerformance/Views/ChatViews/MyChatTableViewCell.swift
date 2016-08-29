//
//  MyChatTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var myChatItem: MyChatItem? {
        didSet {
            let sender = myChatItem?.sender
            
            userAvatarImgView.sd_setImageWithURL(sender!.avatarUrl)
            userNameLabel.text = sender?.displayName
            messageLabel.text = myChatItem?.message
            dateLabel.text = myChatItem?.createdAt
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
