//
//  SelectInviteFriendViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/5/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class SelectInviteFriendViewController: UIViewController, SuggestFriendTableViewCellDelegate {

    
    @IBOutlet weak var inviteLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var suggestFriendTableView: UITableView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var suggestedFriendLabel: UILabel!
    
    var apiClient = APIClient.sharedInstance
    var friends = [User]()
    var goalID = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        suggestFriendTableView.delegate = self
        suggestFriendTableView.dataSource = self
        
        loadSuggestFriend()
    }
    
    func initView() {
        inviteLabel.textColor = UIColor.blackColor()
        suggestedFriendLabel.textColor = UIColor.blackColor()
        
        inviteButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        inviteButton.layer.cornerRadius = 10
        
        doneButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        doneButton.layer.cornerRadius = 10
        doneButton.layer.borderWidth = 1
    }
    
    func loadSuggestFriend(){
        apiClient.getSuggestedFriends({ (friends) in
            self.friends = friends
            self.suggestFriendTableView.reloadData()
        })
    }
    
    func displayAlert(viewCell: SuggestFriendTableViewCell, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        print("Invite or Connect is press")
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

extension SelectInviteFriendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if friends.count > 0 {
            return friends.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SuggestFriendCell") as! SuggestFriendTableViewCell
        
        cell.friend = friends[indexPath.row]
        cell.goalID = goalID
        cell.delegate = self
        cell.apiClient = apiClient
        
        return cell
    }
    
}