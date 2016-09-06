//
//  UserGoalTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import Charts
import FontAwesome_swift


protocol UserGoalTableViewCellDelegate: class {
    func starButtonPressed(goalID: Int) -> Void
}

class UserGoalTableViewCell: UITableViewCell {
    

    @IBOutlet var realStarButton: DOFavoriteButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var lineChartView: LineChartView!
    var delegate: UserGoalTableViewCellDelegate?
    var goal: Goal? {
        didSet {
            
            setChart()
            loadComments()
            if goal!.likeCount < 2 {
                self.starButton.setTitle("\(goal!.likeCount) star", forState: .Normal)
            } else {
                self.starButton.setTitle("\(goal!.likeCount) stars", forState: .Normal)
            }
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        realStarButton.imageColorOff = UIColor.grayColor()
        realStarButton.imageColorOn = UIColor.orangeColor()
        realStarButton.circleColor = UIColor.yellowColor()
        realStarButton.lineColor = UIColor.yellowColor()
        realStarButton.duration = 1.0

    }
    
    func setChart() {
        lineChartView.noDataText = "You need to provide data for the chart."
        
        let dateLabels = goal?.sessionsHistory?.dateLabels
        let values = goal?.sessionsHistory?.scores
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dateLabels!.count {
            if values![i] >= 0 {
               let dataEntry = ChartDataEntry(value: values![i], xIndex: i)
                dataEntries.append(dataEntry)
            }
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Score")
        let lineChartData = LineChartData(xVals: dateLabels, dataSet: lineChartDataSet)
        
        lineChartDataSet.setColor(UIColors.HomeTimelineChartLineColor)
        lineChartDataSet.mode = .CubicBezier
        lineChartDataSet.drawCircleHoleEnabled = false
        lineChartDataSet.circleRadius = 3
        lineChartDataSet.drawValuesEnabled = true
        lineChartDataSet.setCircleColor(UIColors.HomeTimelineChartLineColor)
        
        lineChartView.extraTopOffset = 5
        lineChartView.extraBottomOffset = 5
        lineChartView.extraLeftOffset = 5
        lineChartView.extraRightOffset = 5
        lineChartView.legend.enabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.userInteractionEnabled = false
        
        //hide value
        lineChartDataSet.drawValuesEnabled = !lineChartDataSet.isDrawValuesEnabled
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.setLabelsToSkip(0)
        lineChartView.descriptionText = ""
        
        lineChartView.data = lineChartData
        
        if self.goal?.likeCount == 0 {
            realStarButton.deselect()
        } else {
            realStarButton.select()
        }
        
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onStarAction(sender: DOFavoriteButton) {
        if self.goal?.likeCount == 0 {
           realStarButton.deselect()
        } else {
            realStarButton.select()
        }
        
        if let _ = self.delegate {
            if let goalID = self.goal?.id {
                self.delegate?.starButtonPressed(goalID)
            }
        }
        if sender.selected {
            sender.deselect()
        } else {
            sender.select()

        }
    }
    
    
    func loadComments() {
        if let goalID = goal?.id {
            
            APIClient.sharedInstance.getComments(goalID, completed: { (comments) in
                
                if comments.count < 2 {
                    self.commentButton.setTitle("\(comments.count) comment", forState: .Normal)
                } else {
                    self.commentButton.setTitle("\(comments.count) comments", forState: .Normal)
                }
                
            })
        }
    }
}
    

