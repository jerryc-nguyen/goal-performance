//
//  DefineGoalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class DefineGoalViewController: UIViewController, GoalIntervalTableViewControllerDelegate {
    
    @IBOutlet weak var containChartView: UIView!
    @IBOutlet weak var heightContainChartViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var hasGoal = false
    
    var timeChosen: String = ""
    var weekdays:[String] = []
    var duration:Int = 0
    var categoryID:Int? = 0
    var categoryName:String = ""
    var currentGoal:Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController
        
        startTimePicker.datePickerMode = UIDatePickerMode.Time
       // navBar?.navigationBar.alpha = 0.5
        navBar?.navigationBar.translucent = true
        navBar?.navigationBar.backgroundColor = UIColor.clearColor()
        self.title = "Setup Your Goal"
        navBar?.navigationBar.tintColor = UIColor.orangeColor()
        navBar?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        let nextBarItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(next))
        self.navigationItem.rightBarButtonItem = nextBarItem

        if hasGoal {
            heightContainChartViewConstraint.constant = 110
            saveButton.setImage(UIImage(named: "Save Change"), forState: .Normal)
        } else {
            heightContainChartViewConstraint.constant = 0
            saveButton.setImage(UIImage(named: "Orange Arrow"), forState: .Normal)
        }
    }
    
    func next() {
       let params : [String : AnyObject] = [
            "goal[start_at]" : self.timeChosen,
            "goal[repeat_every]" : self.weekdays,
            "goal[duration]" : self.duration,
            "goal[sound_name]" : "alarm1",
            "goal[is_challenge]" : true,
            "goal[is_default]" : true,
            "goal[category_id]" : self.categoryID!
        ]
        
        if self.timeChosen == "" {
            showAlert("Oops! Something is missing", message: "Please pick the starting time.")
        }
        if self.weekdays == [] {
            showAlert("Oops! Something is missing", message: "Please pick the days to do your goal.")
        }
        
        if self.duration == 0 {
            showAlert("Uh oh, still missing something", message: "Please pick the duration for your goal.")
        }
        
        APIClient.sharedInstance.createGoal(params) { (result) in
            
            if (result as? Goal) != nil {
                let goal = result as! Goal
                goal.registerStartGoalNotifications()
                self.currentGoal = goal
                print("Create goal success")
                self.performSegueWithIdentifier("DoneSegue", sender: self)
            }
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func timePickerAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        startTimePicker.datePickerMode = UIDatePickerMode.Time
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeChosen = dateFormatter.stringFromDate(startTimePicker.date)
        print(timeChosen)
        self.timeChosen = timeChosen
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        next()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoalIntervalTableViewSegue" {
            let goalIntervalTableVC = segue.destinationViewController as! GoalIntervalTableViewController
            goalIntervalTableVC.parentScreen = self
            goalIntervalTableVC.delegate = self
        } else if segue.identifier == "DoneSegue" {
            let doneVC = segue.destinationViewController as! DoneViewController
            doneVC.categoryName = self.categoryName
            doneVC.timeChosen = self.timeChosen
            doneVC.weekdays = self.weekdays
            doneVC.currentGoal = self.currentGoal
       }
    }
    
    func goalIntervalTableViewController(goalIntervalVC: GoalIntervalTableViewController, duration: Int, weekdays: [String]) {
        self.duration = duration
        self.weekdays = weekdays
        print("get weekdays1: \(weekdays)")
        print("get duration1: \(duration)")
    }
}
