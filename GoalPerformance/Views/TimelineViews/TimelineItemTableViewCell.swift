//
//  TimelineItemTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

import SDWebImage
import DateTools
import Charts

protocol TimelineItemTableViewCellDelegate: class {
    func starButtonPressed(goalID: Int) -> Void
}

class TimelineItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var realStarButton: DOFavoriteButton!
    @IBOutlet weak var userAvatarImgView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fellingLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    var delegate: TimelineItemTableViewCellDelegate? = nil
    var goalID: Int? {
        didSet {
            if goalID != nil {
                loadComments()
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

    var apiClient = APIClient.sharedInstance
    var timeLineItem: TimelineItem! {
        didSet {
            self.goalID = timeLineItem.currentGoalSession?.goalId
            let currentSession = timeLineItem.currentGoalSession!
            userNameLabel.text = currentSession.participant?.displayName
            fellingLabel.text = currentSession.feelingSentence
            finishLabel.text = currentSession.finishSentence
            userAvatarImgView.sd_setImageWithURL(currentSession.participant?.avatarUrl)
            dateLabel.text = currentSession.createdAt?.timeAgoSinceNow()
            
            // show chart
            days = currentSession.sessionsHistory?.dateLabels
            
            let scores = currentSession.sessionsHistory?.scores
            setChart(days, values: scores!)

            if currentSession.goal.likeCount < 2 {
                self.starButton.setTitle("\(currentSession.goal.likeCount) star", forState: .Normal)
            } else {
                self.starButton.setTitle("\(currentSession.goal.likeCount) stars", forState: .Normal)
            }
        }
    }
    var days: [String]!
   
    func setChart(dataPoints: [String], values: [Double]) {
        lineChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Score")
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        
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
        
        if self.timeLineItem.currentGoalSession?.goal.likeCount == 0 {
            realStarButton.deselect()
        } else {
            realStarButton.select()
        }

    }
    
    
    func loadComments() {
        if let goalID = self.timeLineItem?.currentGoalSession?.goalId {
            
            apiClient.getComments(goalID, completed: { (comments) in
                
                if comments.count < 2 {
                    self.commentButton.setTitle("\(comments.count) comment", forState: .Normal)
                } else {
                    self.commentButton.setTitle("\(comments.count) comments", forState: .Normal)
                }
                
            })
        }
    }
    
    @IBAction func onStarAction(sender: DOFavoriteButton) {
        if self.timeLineItem.currentGoalSession?.goal.likeCount == 0 {
            realStarButton.deselect()
        } else {
            realStarButton.select()
        }
        if let _ = self.delegate {
            if let goalID = self.timeLineItem?.currentGoalSession?.goalId {
                self.delegate?.starButtonPressed(goalID)
            }
        }
        if sender.selected {
            sender.deselect()
        } else {
            sender.select()
        }

    }

    
    @IBAction func showCommentView(sender: UIButton) {
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
