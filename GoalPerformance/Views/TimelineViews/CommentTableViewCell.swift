//
//  CommentTableViewCell.swift
//  GoalPerformance
//
//  Created by sophie on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var commentItem: Comment! {
        didSet {
            commentLabel.text = commentItem.content
            profileImgView.sd_setImageWithURL(commentItem.creator?.avatarUrl)
            displayNameLabel.text = commentItem.creator?.displayName
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
