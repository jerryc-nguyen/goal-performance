//
//  DurationViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class DurationViewController: UIViewController {

    @IBOutlet weak var durationTimer: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        durationTimer.datePickerMode = UIDatePickerMode.CountDownTimer
        durationTimer.addTarget(self, action: #selector(DurationViewController.onDurationChangedAction(_:)), forControlEvents: UIControlEvents.ValueChanged)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDurationChangedAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        durationTimer.datePickerMode = UIDatePickerMode.CountDownTimer
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
