//
//  BuddiesTableViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/21/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

class GoalBuddiesTableViewController: UITableViewController, FriendTableViewCellDelegate {
    var apiClient = APIClient.sharedInstance
    var buddies = [User]()
    var storyboardManager = StoryboardManager.sharedInstance
    var pendingBuddies = [GoalSession]()
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(loadFriend), forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "FriendTableViewCell")
        
        loadFriend()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if pendingBuddies.count > 0 {
                return "Pending request"
            } else {
                return ""
            }
        default:
            return "Goal Buddies"
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = buddies[indexPath.row]
        let userVC = storyboardManager.getViewController("UserViewController", storyboard: "User") as! UserViewController
        userVC.viewingUser = user
        userVC.addGoalButton.setImage(UIImage(named: "goal buddy"), forState: .Normal)
        userVC.addGoalButton.setTitle("", forState: .Normal)
        userVC.addGoalButton.frame.size.width = 30
        if let userName = user.displayName {
            userVC.navBarTitle = userName
        }
        parentNavigationController?.pushViewController(userVC, animated: true)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pendingBuddies.count
            
        case 1:
            return buddies.count
            
        default:
            return 0
        }
    }
    
    //    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return friends.count
    //    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
        
        cell.apiClient = apiClient
        cell.currentView = self.view
        cell.delegate = self
        var friend: User?
        var goal: GoalSession?
        
        switch indexPath.section {
        case 0:
            goal = pendingBuddies[indexPath.row]
            cell.challengeImage.hidden = true
            cell.goalsSession = goal
            cell.chatFriendButton.hidden = true
        default:
            friend = buddies[indexPath.row]
            cell.acceptButton.hidden = true
            cell.rejectButton.hidden = true
            cell.challengeImage.hidden = false
            
            cell.friend = friend
            cell.parentNavigationController = self.parentNavigationController
        }
        
        
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func loadFriend() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.apiClient.getPendingGoal { (goals) in
            self.pendingBuddies = goals
            self.tableView.reloadData()
            
            
            self.apiClient.getBuddiesFriend { (friends) in
                self.buddies = friends
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.refreshControl!.endRefreshing()
            }
        
        }
    }
    
    func reloadData(viewCell: FriendTableViewCell) {
        loadFriend()
    }
}
