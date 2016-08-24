//
//  FriendViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/14/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController, CAPSPageMenuDelegate {

//    @IBOutlet weak var viewSegment: UISegmentedControl!
//    
//    @IBOutlet weak var friendTableView: UITableView!
//    
//    @IBOutlet weak var goalBuddiesTable: UITableView!
//    
//    var apiClient = APIClient.sharedInstance
//    var pendingFriends = [User]()
//    var friends = [User]()
//    var pendingBuddies = [User]()
//    var buddies = [User]()
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UITableViewController] = []
    var storyboardManager  = StoryboardManager.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller1 = storyboardManager.getViewController("SuggestedFriendsTableViewController", storyboard: "Friend") as! SuggestedFriendsTableViewController
        controller1.title = "Suggested Friends"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        let controller2 = storyboardManager.getViewController("FriendsTableViewController", storyboard: "Friend") as! FriendsTableViewController
        controller2.parentNavigationController = self.navigationController
        controller2.title = "Friends"
        controllerArray.append(controller2)
        
        let controller3 = storyboardManager.getViewController("GoalBuddiesTableViewController", storyboard: "Friend") as! GoalBuddiesTableViewController
        controller3.title = "Goal Buddies"
        controller3.parentNavigationController = self.navigationController
        controllerArray.append(controller3)
        
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)),
            .BottomMenuHairlineColor(UIColor(red: 255.0/255.0, green: 87.0/255.0, blue: 34.0/255.0, alpha: 0.5)),
            .SelectionIndicatorColor(UIColor(red: 255.0/255.0, green: 87.0/255.0, blue: 34.0/255.0, alpha: 1.0)),
            .MenuMargin(20.0),
            .MenuHeight(40.0),
            .SelectedMenuItemLabelColor(UIColor(red: 255.0/255.0, green: 87.0/255.0, blue: 34.0/255.0, alpha: 1.0)),
            .UnselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue-Medium", size: 14.0)!),
            .SelectionIndicatorHeight(2.0),
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
    }

//    func loadFriend() {
//        
//        if viewSegment.selectedSegmentIndex == 0 {
//            apiClient.getPendingFriend { (friends) in
//                self.pendingFriends = friends
//                self.friendTableView.reloadData()
//            }
//            
//            apiClient.getAllFriends { (friends) in
//                self.friends = friends
//                self.friendTableView.reloadData()
//            }
//        } else {
//            apiClient.getPendingFriend { (friends) in
//                self.pendingFriends = friends
//                self.friendTableView.reloadData()
//            }
//            
//            apiClient.getAllFriends { (friends) in
//                self.friends = friends
//                self.friendTableView.reloadData()
//            }
//            
//        }
//    }
    
//    @IBAction func onSegmentChange(sender: UISegmentedControl) {
//        loadFriend()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//        case 0:
//            
//            if pendingFriends.count > 0 {
//                if viewSegment.selectedSegmentIndex == 0 {
//                    return "Pending friends"
//                } else {
//                    return "Pending buddies"
//                }
//            } else {
//                return ""
//            }
//                
//            
//        default:
//            if viewSegment.selectedSegmentIndex == 0 {
//                return "List friends"
//            } else {
//                return "List buddies"
//            }
//        }
//    }
//    
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return pendingFriends.count
//            
//        case 1:
//            return friends.count
//            
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell
//        
//        cell.apiClient = apiClient
//        
//        var friend: User?
//        
//        switch indexPath.section {
//        case 0:
//            friend = pendingFriends[indexPath.row]
//            cell.challengeImage.hidden = true
//            
//        default:
//            friend = friends[indexPath.row]
//            cell.acceptButton.hidden = true
//            cell.rejectButton.hidden = true
//        }
//        
//        cell.friend = friend
//        
//        return cell
//        
//    }
//}

