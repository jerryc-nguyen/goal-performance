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
        durationTimer?.datePickerMode = UIDatePickerMode.CountDownTimer
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        onDurationChangedAction(durationTimer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDurationChangedAction(sender: UIDatePicker) {
        let dateFormatter = NSDateComponentsFormatter()
        let date = durationTimer.date
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        dateFormatter.unitsStyle = .Positional
        durationTimer.datePickerMode = UIDatePickerMode.CountDownTimer
        dateFormatter.unitsStyle = .Positional
        let durationChosen = dateFormatter.stringFromDateComponents(components)
        var durationArray = durationChosen!.characters.split{$0 == ":"}.map(String.init)
        let minute = Int(durationArray[1])
        let hour = Int(durationArray[0])
        if let hour = hour, minute = minute {
            let durationMinutes = hour * 60 + minute
            print(durationMinutes)
        }
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


