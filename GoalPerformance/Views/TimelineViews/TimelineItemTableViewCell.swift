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

class TimelineItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImgView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var fellingLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var lineChartView: LineChartView!

    
    var timeLineItem: TimelineItem! {
        didSet {
            userNameLabel.text = timeLineItem.creator?.displayName
            fellingLabel.text = timeLineItem.feelingSentence
            finishLabel.text = timeLineItem.finishSentence
            userAvatarImgView.sd_setImageWithURL(timeLineItem.creator?.avatarUrl)
            dateLabel.text = timeLineItem.createdAt?.timeAgoSinceNow()
            
            // show chart
            days = timeLineItem.sessionsHistory?.dateLabels
            
            let scores = timeLineItem.sessionsHistory?.scores
            setChart(days, values: scores!)
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
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
