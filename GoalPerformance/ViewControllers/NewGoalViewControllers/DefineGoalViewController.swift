//
//  DefineGoalViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Charts
import UIKit
import MBProgressHUD

class DefineGoalViewController: UIViewController, GoalIntervalTableViewControllerDelegate {
    
    @IBOutlet weak var containChartView: LineChartView!
    @IBOutlet weak var heightContainChartViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var startTimePicker: UIDatePicker!

    @IBOutlet weak var saveButton: UIButton!
    //var hasGoal = false
    
    var timeChosen: String = ""
    var weekdays:[String] = []
    var duration:Int = 0
    var categoryID:Int? = 0
    var categoryName:String = ""
    var currentGoalSession:GoalSession?
    var goalId: Int = 0
    var goal: Goal?
    
    var hasGoal: Bool {
        return goalId > 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let navBar = self.navigationController
        
        startTimePicker.datePickerMode = UIDatePickerMode.Time
      
        if hasGoal == true {
            heightContainChartViewConstraint.constant = 110
            saveButton.setImage(UIImage(named: "Save Change"), forState: .Normal)
            
            navBar?.navigationBar.translucent = true
            navBar?.navigationBar.backgroundColor = UIColors.ThemeOrange
            self.title = "Goal Details"
            navBar?.navigationBar.tintColor = UIColor.whiteColor()
            navBar?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            
            loadAndSetupChartForGoalDetail()
            
        } else {
            heightContainChartViewConstraint.constant = 0
            saveButton.setImage(UIImage(named: "Orange Arrow"), forState: .Normal)
            navBar?.navigationBar.translucent = true
            navBar?.navigationBar.backgroundColor = UIColors.ThemeOrange
            self.title = "Setup Your Goal"
            navBar?.navigationBar.tintColor = UIColor.whiteColor()
            navBar?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            let nextBarItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(next))
            self.navigationItem.rightBarButtonItem = nextBarItem
        }
        
    }
    
    func loadAndSetupChartForGoalDetail() {
        let params: [String : AnyObject] = ["goal_id": self.goalId]
        APIClient.sharedInstance.goalDetail(params) { (goal) in
            self.goal = goal
            self.setUpLinesChartFor(goal)
        }
    }
    
    
    func setUpLinesChartFor(goal: Goal) {
        if let chartData = goal.linesChartData {
        
        var dataSets: [LineChartDataSet] = [LineChartDataSet]()
        
        for i in 0..<chartData.sessionsHistories.count {
            var values: [ChartDataEntry] = [ChartDataEntry]()
            let userSessionHistory = chartData.sessionsHistories[i]
            let userScores = userSessionHistory.scores
            
            for j in 0..<(userScores.count) {
                let val: Double = Double(userScores[j])
                if val >= 0 {
                    values.append(ChartDataEntry(value: val, xIndex: j))
                }
            }
            
            
            let color = Utils.getRandomColor()
            
            let d: LineChartDataSet = LineChartDataSet(yVals: values, label: userSessionHistory.user!.displayName)
            d.lineWidth = 1.5
            d.circleRadius = 3.0
            d.circleHoleRadius = 1.5
            
            d.setColor(color)
            d.mode = .CubicBezier
            d.drawCircleHoleEnabled = false
            d.circleRadius = 3
            d.drawValuesEnabled = true
            d.setCircleColor(color)
            
            //hide value
            d.drawValuesEnabled = !d.isDrawValuesEnabled
            dataSets.append(d)
            
        }
        
        let data: LineChartData = LineChartData(xVals: chartData.dateLabels, dataSets: dataSets)
        
        containChartView.extraTopOffset = 5
        containChartView.extraBottomOffset = 5
        containChartView.extraLeftOffset = 5
        containChartView.extraRightOffset = 5
        containChartView.pinchZoomEnabled = false
        containChartView.userInteractionEnabled = false
        containChartView.rightAxis.enabled = false
        containChartView.leftAxis.drawGridLinesEnabled = false
        containChartView.xAxis.drawGridLinesEnabled = false
        containChartView.xAxis.setLabelsToSkip(0)
        containChartView.descriptionText = ""
        containChartView.data = data
        containChartView.setNeedsLayout()
        }
    }
        
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "UserGoalTableViewCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    func next() {
       let params : [String : AnyObject] = [
            "goal[start_at]" : self.timeChosen,
            "goal[repeat_every]" : self.weekdays,
            "goal[duration]" : self.duration,
            "goal[sound_name]" : "alarm1",
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
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        APIClient.sharedInstance.createGoal(params) { (result) in
            
            if (result as? GoalSession) != nil {
                let goalSession = result as! GoalSession
                goalSession.goal.registerStartGoalNotifications()
                goalSession.goal.registerEndGoalNotifications()
                self.currentGoalSession = goalSession
                print("Create goal success")
                self.performSegueWithIdentifier("DoneSegue", sender: self)
            }
        }
        
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    
       
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
            doneVC.currentGoalSession = self.currentGoalSession
       }
    }
    
    func goalIntervalTableViewController(goalIntervalVC: GoalIntervalTableViewController, duration: Int, weekdays: [String]) {
        self.duration = duration
        self.weekdays = weekdays
        print("get weekdays1: \(weekdays)")
        print("get duration1: \(duration)")
    }
}
