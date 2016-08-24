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
    var currentView: UIView!
    weak var delegate : FriendTableViewCellDelegate!
    
    var friend:User? {
        didSet {
            friendImage.makeCircle()
            friendImage.sd_setImageWithURL(friend!.avatarUrl)
            friendName.text = friend!.displayName
        }
    }
    
    var goalsSession: GoalSession? {
        didSet {
            friend = goalsSession?.inviter
            currentGoalsLabel.text = goalsSession?.statement
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
