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
    
    var apiClient = APIClient.sharedInstance
    var pendingFriends = [User]()
    var friends = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        friendTableView.delegate = self
        friendTableView.dataSource = self
        
        friendTableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "FriendTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadFriend() {
        apiClient.getAllFriends { (friends) in
            self.friends = friends
        }
        
        apiClient.getPendingFriend { (friends) in
            self.pendingFriends = friends
        }
        
        friendTableView.reloadData()
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
            return "Connect requests"
        default:
            return "List Friend"
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
        
        var friend: User?
        
        switch indexPath.section {
        case 0:
            friend = pendingFriends[indexPath.row]
            
        default:
            friend = friends[indexPath.row]
        }
        
        cell.friend = friend
        
        return cell
        
    }
}

