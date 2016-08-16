//
//  GoalIntervalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/10/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol WeekdaysViewControllerDelegate:class {
    func weekdaysViewController(weekdayVC: WeekdaysViewController, weekdays: [String], weekdaysForLabel: [String])
}

class WeekdaysViewController: UIViewController {
    
    var selectedWeekdays:[String] = [""]
    @IBOutlet weak var tableView: UITableView!
    var indexList = Array<Int>()
    var weekdaysForLabel = Array<String>()
    weak var delegate: WeekdaysViewControllerDelegate?
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("selected weekdays to update: \(selectedWeekdays)")
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        indexList = indexList.sort({ (a, b) -> Bool in
            return a < b
        })
        var weekdaysArray = Array<String>()
            if indexList.contains(0) {
                weekdaysArray.append("sunday")
                weekdaysForLabel.append("Sun")
            }
            if indexList.contains(1) {
                weekdaysArray.append("monday")
                weekdaysForLabel.append("Mon")
            }
            if indexList.contains(2) {
                weekdaysArray.append("tuesday")
                weekdaysForLabel.append("Tue")
            }
            if indexList.contains(3) {
                weekdaysArray.append("wednesday")
                weekdaysForLabel.append("Wed")
            }
            if indexList.contains(4) {
                weekdaysArray.append("thursday")
                weekdaysForLabel.append("Thu")
            }
            if indexList.contains(5) {
                weekdaysArray.append("friday")
                weekdaysForLabel.append("Fri")
            }
            if indexList.contains(6) {
                weekdaysArray.append("saturday")
                weekdaysForLabel.append("Sat")
            }
        delegate?.weekdaysViewController(self, weekdays: weekdaysArray, weekdaysForLabel: weekdaysForLabel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension WeekdaysViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
}

extension WeekdaysViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeekdayCell", forIndexPath: indexPath) as! WeekdayCell
        cell.weekdayLabel.text = weekdays[indexPath.row]
        
        cell.accessoryType = .None
        
        if cell.isSelected == true {
            cell.accessoryType = .Checkmark
        }
        let isContain = selectedWeekdays.contains(weekdays[indexPath.row].lowercaseString)
        if isContain == true  {
            cell.isSelected = true
            let index = indexList.indexOf(indexPath.row)
            if let _ = index {
                indexList.removeAtIndex(index!)
            }
            indexList.append(indexPath.row)
            
            cell.accessoryType = .Checkmark
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! WeekdayCell
        cell.isSelected = !cell.isSelected!
        if cell.isSelected! {
            let index = indexList.indexOf(indexPath.row)
            if let _ = index {
                indexList.removeAtIndex(index!)
            }
            indexList.append(indexPath.row)
        } else {
            if indexList.contains(indexPath.row) {
                let index = indexList.indexOf(indexPath.row)
                if let _ = index {
                    indexList.removeAtIndex(index!)
                }
                let index2 = selectedWeekdays.indexOf(cell.weekdayLabel.text!.lowercaseString)
                if let _ = index2 {
                    selectedWeekdays.removeAtIndex(index2!)
                }
            }
        }
        tableView.reloadData()
    }
}