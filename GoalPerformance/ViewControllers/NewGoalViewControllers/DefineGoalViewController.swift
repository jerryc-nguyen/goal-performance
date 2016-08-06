//
//  DefineGoalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class DefineGoalViewController: UIViewController  {

    @IBOutlet weak var timePicker: UIDatePicker!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.addTarget(self, action: #selector(DefineGoalViewController.timePickerAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func timePickerAction(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        timePicker.datePickerMode = UIDatePickerMode.Time
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
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

