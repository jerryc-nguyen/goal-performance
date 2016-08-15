//
//  DurationViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol DurationViewControllerDelegate: class {
    func durationViewController(durationVC: DurationViewController, durationUpdated duration: Int, durationString: String)
}

class DurationViewController: UIViewController {
    var durationSec: Int = 0
    @IBOutlet weak var durationTimer: UIDatePicker!
    weak var delegate: DurationViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if durationSec == durationSec {
            durationTimer.countDownDuration = Double(durationSec)
        } else {
        durationTimer.countDownDuration = 1800
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        onDurationChangedAction(durationTimer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDurationChangedAction(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        let date = durationTimer.date
        dateFormatter.dateFormat = "H:m"
        let durationChosen = dateFormatter.stringFromDate(date)
        var durationArray = durationChosen.characters.split{$0 == ":"}.map(String.init)
            if durationArray.count > 1 {
            let minute  = Int(durationArray[1])
            let hour    = Int(durationArray[0])
            var durationString: String = ""
            if let hour = hour, minute = minute {
                if hour == 1 {
                    durationString = "\(hour) hour \(minute) min"
                    print(durationString)
                } else {
                    durationString = "\(hour) hours \(minute) min"
                    print(durationString)
                }
                let durationMinutes = hour * 60 + minute
                self.delegate?.durationViewController(self, durationUpdated: durationMinutes, durationString: durationString)
            }
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


