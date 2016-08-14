//
//  DefineGoalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class DefineGoalViewController: UIViewController, DurationViewControllerDelegate, WeekdaysViewControllerDelegate {

    @IBOutlet weak var startTimePicker: UIDatePicker!
    
    var timeChosen: String = ""
    var weekdays:[String] = []
    var duration:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimePicker.datePickerMode = UIDatePickerMode.Time
        
        let nextBarItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = nextBarItem
    }
    
    override func viewWillDisappear(animated: Bool) {
        timePickerAction(startTimePicker)
    }
    
    override func viewWillAppear(animated: Bool) {
    
    }
    
    func done() {
        
        
        
//        goal[name]:Goal name 1
//        goal[start_at]:06:30 PM
//        goal[repeat_every][]:monday
//        goal[repeat_every][]:tuesday
//        goal[repeat_every][]:thursday
//        goal[repeat_every][]:friday
//        goal[repeat_every][]:sunday
//        goal[duration]:10
//        goal[sound_name]:'0'
//        goal[is_challenge]:true
//        goal[is_default]:true
//        goal[category_id]:6
        

        let params : [String : AnyObject] = [
            "goal[name]" : "Swim",
            "goal[start_at]" : self.timeChosen,
            "goal[repeat_every]" : self.weekdays,
            "goal[duration]" : self.duration,
            "goal[sound_name]" : 0,
            "goal[is_challenge]" : true,
            "goal[is_default]" : true,
            "goal[category_id]" : 6
        ]
        
        APIClient.sharedInstance.sendSetupGoalData(params) { (result) in
            print(result)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timePickerAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        startTimePicker.datePickerMode = UIDatePickerMode.Time
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        let timeChosen = dateFormatter.stringFromDate(startTimePicker.date)
        print(timeChosen)
        self.timeChosen = timeChosen
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoalIntervalTableViewSegue" {
            let goalIntervalTableVC = segue.destinationViewController as! GoalIntervalTableViewController
            goalIntervalTableVC.parentScreen = self
        }
        
    }

    func durationViewController(durationVC: DurationViewController, durationUpdated duration: Int) {
        print("get duration: \(duration)")
        self.duration = duration
    }
    
    func weekdaysViewController(weekdayVC: WeekdaysViewController, weekdays: [String]) {
        print("get weekdays: \(weekdays)")
        self.weekdays = weekdays
        
    }
}
