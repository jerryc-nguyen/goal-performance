//
//  UserGoalsChartTableViewCell.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import Charts

class UserGoalsChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    var dateLabels = [String]()
    
    var goals: [Goal]! {
        didSet {
            displayChart()
        }
    }
    
    func displayChart() {
        
        var dataSets: [LineChartDataSet] = [LineChartDataSet]()
        
        for z in 0..<goals.count {
            var values: [ChartDataEntry] = [ChartDataEntry]()
            let goal = goals[z]
            let sesstionsHistory = goal.sessionsHistory
            
            for i in 0..<(sesstionsHistory?.scores.count)! {
                let val: Double = Double((sesstionsHistory?.scores[i])!)
                if val >= 0 {
                    values.append(ChartDataEntry(value: val, xIndex: i))
                }
            }
            
            let d: LineChartDataSet = LineChartDataSet(yVals: values, label: "DataSet \(z + 1)")
            d.lineWidth = 1.5
            d.circleRadius = 3.0
            d.circleHoleRadius = 1.5
            
            d.setColor(ChartColorTemplates.colorFromString(goal.categoryColor!))
            d.mode = .CubicBezier
            d.drawCircleHoleEnabled = false
            d.circleRadius = 3
            d.drawValuesEnabled = true
            
            d.setCircleColor(ChartColorTemplates.colorFromString(goal.categoryColor!))
            
            //hide value
            d.drawValuesEnabled = !d.isDrawValuesEnabled
            dataSets.append(d)
        }
        
        let data: LineChartData = LineChartData(xVals: dateLabels, dataSets: dataSets)
        
        
        lineChartView.extraTopOffset = 5
        lineChartView.extraBottomOffset = 5
        lineChartView.extraLeftOffset = 5
        lineChartView.extraRightOffset = 5
        lineChartView.legend.enabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.userInteractionEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.setLabelsToSkip(0)
        lineChartView.descriptionText = ""
        
        self.lineChartView.data = data
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
