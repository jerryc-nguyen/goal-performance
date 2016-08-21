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

class UserGoalTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var goal: Goal? {
        didSet {
            setChart()
        }
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
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
