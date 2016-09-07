//
//  FriendTableViewCell.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol FriendTableViewCellDelegate: class {
    func reloadData(viewCell: FriendTableViewCell)
}

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var challengeImage: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var currentGoalsLabel: UILabel!
    @IBOutlet weak var chatFriendButton: UIButton!
    
    var currentView: UIView!
    
    var parentNavigationController: UINavigationController?
    
    weak var delegate : FriendTableViewCellDelegate!
    
    var friend: User? {
        didSet {
            friendImage.makeCircle()
            friendImage.sd_setImageWithURL(friend!.avatarUrl)
            friendName.text = friend!.displayName
            
            acceptButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            acceptButton.backgroundColor = UIColors.ThemeOrange
            acceptButton.layer.cornerRadius = 10
            acceptButton.tintColor = UIColor.whiteColor()
            
            rejectButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            rejectButton.backgroundColor = UIColors.ThemeOrange
            rejectButton.layer.cornerRadius = 10
            rejectButton.tintColor = UIColor.whiteColor()
        }
    }
    
    var goalsSession: GoalSession? {
        didSet {
            friend = goalsSession?.inviter
            currentGoalsLabel.text = goalsSession?.statement
        }
    }
    
    var apiClient:APIClient!
    
    @IBAction func onChatButton(sender: AnyObject) {
        let storyboardManager = StoryboardManager.sharedInstance
        let chatVC = storyboardManager.getViewController("ChatViewController", storyboard: "Chat") as! ChatViewController
        chatVC.receiver = ChatUser(dictionary: self.friend!.userData)
        self.parentNavigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onAccept(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(self.currentView, animated: true)
        if (goalsSession != nil) {
            apiClient.acceptGoal((goalsSession?.id)!, completed: { (title, message) in
                print("\(title): \(message)")
                self.delegate.reloadData(self)
                MBProgressHUD.hideHUDForView(self.currentView, animated: true)
            })
        } else {
            apiClient.acceptFriend((friend!.id!), completed: { (title, message) in
                print("\(title): \(message)")
                self.delegate.reloadData(self)
                MBProgressHUD.hideHUDForView(self.currentView, animated: true)
            })
        }
        
       
       
    }

    @IBAction func onReject(sender: UIButton) {
        MBProgressHUD.showHUDAddedTo(self.currentView, animated: true)
        
        if (goalsSession != nil) {
            apiClient.rejectGoal((goalsSession?.id)!, completed: { (title, message) in
                print("\(title): \(message)")
                self.delegate.reloadData(self)
                MBProgressHUD.hideHUDForView(self.currentView, animated: true)
            })
        } else {
            apiClient.rejectFriend((friend!.id!), completed: { (title, message) in
                print("\(title): \(message)")
                self.delegate.reloadData(self)
                MBProgressHUD.hideHUDForView(self.currentView, animated: true)
            })
        }
        
    }
    
}
