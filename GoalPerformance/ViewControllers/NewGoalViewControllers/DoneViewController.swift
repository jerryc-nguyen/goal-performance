//
//  DoneViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/14/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    @IBOutlet weak var notiLabel: UILabel!
    var categoryName:String = ""
    var weekdays:[String] = []
    var timeChosen: String = ""
    var currentGoalSession: GoalSession?
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0.0
        let weekdaysString = weekdays.joinWithSeparator(", ")
        if weekdays.count == 7 {
            notiLabel.text = "Everything is set! We will remind you at \(timeChosen) everyday to \(categoryName)"
        } else {
        notiLabel.text = "Everything is set! We will remind you at \(timeChosen) every \(weekdaysString) to \(categoryName)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneAction(sender: UIButton) {
        let inviteFriendVC = StoryboardManager.sharedInstance.getViewController("InviteViewController", storyboard: "InviteFriend") as! InviteViewController
        inviteFriendVC.currentGoalSession = self.currentGoalSession
        navigationController?.pushViewController(inviteFriendVC, animated: true)
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    }
  
}
