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
    var categoryName:String? = ""
    var weekdays:[String] = []
    var timeChosen: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notiLabel.text = "Everything is set! We will remind you at \(timeChosen) every \(weekdays) to \(categoryName)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneAction(sender: UIButton) {
        let inviteFriendVc = StoryboardManager.sharedInstance.getViewController("InviteViewController", storyboard: "InviteFriend") as! InviteViewController
        navigationController?.pushViewController(inviteFriendVc, animated: true)
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
