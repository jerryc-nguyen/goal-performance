//
//  TimelineItemTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

import SDWebImage
import DateTools

class TimelineItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var fellingLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var timeLineItem: TimelineItem? {
        didSet {
            userNameLabel.text = timeLineItem?.creator?.displayName
            fellingLabel.text = timeLineItem?.feelingSentence
            finishLabel.text = timeLineItem?.finishSentence
            userAvatarImgView.sd_setImageWithURL(timeLineItem?.creator?.avatarUrl)
            dateLabel.text = timeLineItem?.createdAt?.timeAgoSinceNow()
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
