//
//  GoalIntervalTableViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol GoalIntervalTableViewControllerDelegate: class {
    func goalIntervalTableViewController(goalIntervalVC: GoalIntervalTableViewController, duration: Int, weekdays: [String])
}


class GoalIntervalTableViewController: UITableViewController, DurationViewControllerDelegate, WeekdaysViewControllerDelegate {
    
    weak var parentScreen: UIViewController?
    var weekdays = Array<String>()
    var weekdaysForLabel:[String] = ["Never"]
    @IBOutlet weak var repeatLabel: UILabel!
    weak var delegate: GoalIntervalTableViewControllerDelegate?
    @IBOutlet weak var durationLabel: UILabel!
    var durationString:String = "1 min"
    var durationSec: Int = 0
    var duration: Int = 0
    @IBOutlet weak var soundLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(animated: Bool) {

        if weekdays.count == 7 {
            weekdaysForLabel = ["Everyday"]
        }
        if weekdays.count == 0 {
            weekdaysForLabel = ["Never"]
        }
        
        let weekdaysString = weekdaysForLabel.joinWithSeparator(", ")
        self.repeatLabel.text = "\(weekdaysString)"
        self.durationLabel.text = "\(durationString)"
        durationSec = duration * 60
        self.delegate?.goalIntervalTableViewController(self, duration: duration, weekdays: weekdays)
        
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
    
    
    func durationViewController(durationVC: DurationViewController, durationUpdated duration: Int, durationString: String) {
        self.durationString = durationString
        self.duration = duration
        print("get duration2: \(duration) and \(durationString)")
    }
    
    func weekdaysViewController(weekdayVC: WeekdaysViewController, weekdays: [String], weekdaysForLabel: [String]) {
        print("get weekdays2: \(weekdays)")
        self.weekdays = weekdays
        self.weekdaysForLabel = weekdaysForLabel
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DurationSegue" {
            let durationVC = segue.destinationViewController as! DurationViewController
            durationVC.durationSec = self.durationSec
            durationVC.durationSec2 = self.durationSec
            durationVC.delegate = self as DurationViewControllerDelegate
            
        } else if segue.identifier == "WeekdaySegue" {
            let weekdayVC = segue.destinationViewController as! WeekdaysViewController
            weekdayVC.selectedWeekdays = self.weekdays
            weekdayVC.delegate = self as WeekdaysViewControllerDelegate
        }
    }
    
}
