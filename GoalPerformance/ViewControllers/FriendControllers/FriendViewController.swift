//
//  FriendViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/14/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var viewSegment: UISegmentedControl!
    
    @IBOutlet weak var friendTableView: UITableView!
    
    @IBOutlet weak var goalBuddiesTable: UITableView!
    
    var apiClient = APIClient.sharedInstance
    var pendingFriends = [User]()
    var friends = [User]()
    var pendingBuddies = [User]()
    var buddies = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        friendTableView.delegate = self
        friendTableView.dataSource = self
        
        friendTableView.rowHeight = UITableViewAutomaticDimension
        friendTableView.estimatedRowHeight = 120
        
        friendTableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "FriendTableViewCell")
        
        
        
        loadFriend()
    }

    func loadFriend() {
        
        if viewSegment.selectedSegmentIndex == 0 {
            apiClient.getPendingFriend { (friends) in
                self.pendingFriends = friends
                self.friendTableView.reloadData()
            }
            
            apiClient.getAllFriends { (friends) in
                self.friends = friends
                self.friendTableView.reloadData()
            }
        } else {
            apiClient.getPendingFriend { (friends) in
                self.pendingFriends = friends
                self.friendTableView.reloadData()
            }
            
            apiClient.getAllFriends { (friends) in
                self.friends = friends
                self.friendTableView.reloadData()
            }
            
        }
    }
    
    @IBAction func onSegmentChange(sender: UISegmentedControl) {
        loadFriend()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            
            if pendingFriends.count > 0 {
                if viewSegment.selectedSegmentIndex == 0 {
                    return "Pending friends"
                } else {
                    return "Pending buddies"
                }
            } else {
                return ""
            }
                
            
        default:
            if viewSegment.selectedSegmentIndex == 0 {
                return "List friends"
            } else {
                return "List buddies"
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pendingFriends.count
            
        case 1:
            return friends.count
            
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
        
        cell.apiClient = apiClient
        
        var friend: User?
        
        switch indexPath.section {
        case 0:
            friend = pendingFriends[indexPath.row]
            cell.challengeImage.hidden = true
            
        default:
            friend = friends[indexPath.row]
            cell.acceptButton.hidden = true
            cell.rejectButton.hidden = true
        }
        
        cell.friend = friend
        
        return cell
        
    }
}

