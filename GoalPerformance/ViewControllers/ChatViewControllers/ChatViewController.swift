//
//  ChatViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: UIViewController {
    
    var receiver: ChatUser?
    var goal: Goal?
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "chatListSegue" {
            let chatListVC = segue.destinationViewController as! ChatListViewController
            chatListVC.goal = self.goal
            chatListVC.receiver = self.receiver
        }
        
    }

}
