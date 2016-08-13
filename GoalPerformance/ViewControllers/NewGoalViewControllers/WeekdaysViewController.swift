//
//  GoalIntervalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/10/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol WeekdaysViewControllerDelegate:class {
    func weekdaysViewController(weekdayVC: WeekdaysViewController, weekdays: [String])
}

class WeekdaysViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var indexList = Array<Int>()
    weak var delegate: WeekdaysViewControllerDelegate?
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
            }
            if indexList.contains(1) {
                weekdaysArray.append("monday")
            }
            if indexList.contains(2) {
                weekdaysArray.append("tuesday")
            }
            if indexList.contains(3) {
                weekdaysArray.append("wednesday")
            }
            if indexList.contains(4) {
                weekdaysArray.append("thursday")
            }
            if indexList.contains(5) {
                weekdaysArray.append("friday")
            }
            if indexList.contains(6) {
                weekdaysArray.append("saturday")
            }
        delegate?.weekdaysViewController(self, weekdays: weekdaysArray)
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
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! WeekdayCell
        cell.isSelected = !cell.isSelected!
        if cell.isSelected! {
            indexList.append(indexPath.row)
        } else {
            if indexList.contains(indexPath.row) {
                let index = indexList.indexOf(indexPath.row)
                if let _ = index {
                    indexList.removeAtIndex(index!)
                }
            }
        }
        tableView.reloadData()
    }
}