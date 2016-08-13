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
    
    @IBAction func onReloadData(sender: AnyObject) {
        loadUserTimeline()
    }
    let numberOfSections = 3
    
    var userGoals = [Goal]()
    var sessionsHistories = [SessionsHistory]()
    var viewingUser: User?
    var dateLabels = [String]()
    
    var apiClient = APIClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Your Goals"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        registerNibs()
        loadUserTimeline()
    }
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "UserProfileTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserProfileTableViewCell")
        tableView.registerNib(UINib(nibName: "UserGoalsChartTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserGoalsChartTableViewCell")
        tableView.registerNib(UINib(nibName: "UserGoalTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserGoalTableViewCell")
    }
    
    func loadUserTimeline() {
        let params = ["user_id": 5]
        apiClient.userTimeLine(params) { (goals, viewingUser, dateLabels) in
            self.userGoals = goals
            self.viewingUser = viewingUser
            self.dateLabels = dateLabels!
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
        switch section {
        case 0, 1:
            return 1
        default:
            return userGoals.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserProfileTableViewCell") as! UserProfileTableViewCell
            
            cell.viewingUser = self.viewingUser
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserGoalsChartTableViewCell") as! UserGoalsChartTableViewCell
            cell.dateLabels = dateLabels
            cell.goals = userGoals
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserGoalTableViewCell") as! UserGoalTableViewCell
            let goal = userGoals[indexPath.row]
            
            cell.goal = goal
            return cell
        }
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let view = UsersGoalSectionHeaderView.initFromNib()
            view.sectionHeaderLabel.text = "Doing goals"
            return view
        default:
            return nil
        }
    }
}
