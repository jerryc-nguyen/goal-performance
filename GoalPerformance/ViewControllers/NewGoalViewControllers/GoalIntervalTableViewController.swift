//
//  GoalIntervalTableViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol GoalIntervalTableViewControllerDelegate: class {
    func goalIntervalTableViewController(goalIntervalVC: GoalIntervalTableViewController, duration: Int)
}


class GoalIntervalTableViewController: UITableViewController, DurationViewControllerDelegate {
    
    weak var parentScreen: UIViewController?
    
    @IBOutlet weak var repeatLabel: UILabel!
    weak var delegate: GoalIntervalTableViewControllerDelegate?
    @IBOutlet weak var durationLabel: UILabel!
    var durationString:String = "30 min"
    var durationSec: Int = 0
    var duration: Int = 0
    @IBOutlet weak var soundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(animated: Bool) {
        self.durationLabel.text = "\(durationString)"
        durationSec = duration * 60
        self.delegate?.goalIntervalTableViewController(self, duration: duration)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DurationSegue" {
            let durationVC = segue.destinationViewController as! DurationViewController
            durationVC.durationSec = self.durationSec
//            durationVC.delegate = self.parentScreen as? DurationViewControllerDelegate
            durationVC.delegate = self as DurationViewControllerDelegate
            
        } else if segue.identifier == "WeekdaySegue" {
            let weekdayVC = segue.destinationViewController as! WeekdaysViewController
            weekdayVC.delegate = self.parentScreen as? WeekdaysViewControllerDelegate
        }
    }
    
    func durationViewController(durationVC: DurationViewController, durationUpdated duration: Int, durationString: String) {
        self.durationString = durationString
        self.duration = duration
        print("get duration2: \(duration) and \(durationString)")
    }
}
