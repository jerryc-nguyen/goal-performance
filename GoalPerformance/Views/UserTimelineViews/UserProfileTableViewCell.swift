//
//  UserProfileTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatarImgView: UIImageView!
    
    @IBOutlet weak var viewingUserNameLabel: UILabel!
    
    
    var viewingUser: User? {
        didSet {
            if let user = viewingUser {
                self.userAvatarImgView.sd_setImageWithURL(user.avatarUrl)
                self.viewingUserNameLabel.text = user.displayName
            }
        
                roundImage()
        }
    }
    
    func roundImage() {
        userAvatarImgView.layer.cornerRadius = userAvatarImgView.frame.size.width/2
        userAvatarImgView.layer.masksToBounds = true
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
