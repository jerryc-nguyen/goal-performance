//
//  SuggestedFriendsTableViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/24/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import MBProgressHUD

class SuggestedFriendsTableViewController: UITableViewController, SuggestedFriendsTableViewCellDelegate {
    var storyboardManager = StoryboardManager.sharedInstance
    var apiClient = APIClient.sharedInstance
    var friends = [User]()
    var goalSessionId = 138
    var parentNavigationController : UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        loadSuggestFriend()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Suggested Friends"
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if friends.count > 0 {
                return friends.count
            } else {
                return 0
            }
    }
    
    func loadSuggestFriend(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        apiClient.getSuggestedFriends(goalSessionId, completed: { (friends) in
            self.friends = friends
            //            self.suggestFriendTableView.reloadData()
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
    }
    func makeAlert(tittle: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func displayAlert(viewCell: SuggestedFriendsTableViewCell, button: String, status: Int, title: String, message: String) {
        if button != "ChallengeButton" && status != 200 {
            makeAlert(title, message: message)
        }
        
        loadSuggestFriend()
        print("Challenge or Connect is press")
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SuggestedFriendsTableViewCell") as! SuggestedFriendsTableViewCell
        
        cell.currentView = self.view
        cell.friend = friends[indexPath.row]
        cell.goalSessionId = goalSessionId
        cell.delegate = self
        cell.apiClient = apiClient
        
        return cell
    }

}
