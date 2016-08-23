//
//  UserViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var numberOfSections = 2
    var userGoals: [Goal] = []
    var sessionsHistories = [SessionsHistory]()
    var viewingUser: User!
    var dateLabels = [String]()
    var hideNavBar = true
    
    var apiClient = APIClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewingUser = viewingUser ?? APIClient.currentUser
        self.navigationItem.title = "Your Goals"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        registerNibs()
        loadUserTimeline()
    }
    
    @IBAction func onAddGoalButton(sender: AnyObject) {
        let newGoalVC = StoryboardManager.sharedInstance.getViewController(
            "NewGoalViewController", storyboard: "NewGoal") as! NewGoalViewController
        navigationController?.pushViewController(newGoalVC, animated: true)
    }
    
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "UserProfileTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserProfileTableViewCell")
//        tableView.registerNib(UINib(nibName: "UserGoalsChartTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserGoalsChartTableViewCell")
        tableView.registerNib(UINib(nibName: "UserGoalTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserGoalTableViewCell")
    }
    
    func loadUserTimeline() {
        let params: [String: AnyObject] = ["user_id": viewingUser.id!]
        apiClient.userTimeLine(params) { (goals, viewingUser, dateLabels) in
            self.userGoals = goals
            self.viewingUser = viewingUser
            self.dateLabels = dateLabels!
            self.numberOfSections = self.userGoals.count + 1
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UserViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileTableViewCell") as! UserProfileTableViewCell
            
            cell.viewingUser = self.viewingUser
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserGoalTableViewCell") as! UserGoalTableViewCell
            if userGoals.count > 0 {
                let goal = userGoals[indexPath.section - 1]
            
                cell.goal = goal
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboardManager  = StoryboardManager.sharedInstance
        let defineGoalViewController = storyboardManager.getViewController("DefineGoalViewController", storyboard: "NewGoal") as? DefineGoalViewController

        if let defineGoalViewController = defineGoalViewController {
            defineGoalViewController.hasGoal = true
            self.navigationController?.pushViewController(defineGoalViewController, animated: true)
        }
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let view = UsersGoalSectionHeaderView.initFromNib()
            if userGoals.count > 0 {
                view.goalNameLabel.text = userGoals[section - 1].detailName
            }
            return view
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 50
        }
    }
}
