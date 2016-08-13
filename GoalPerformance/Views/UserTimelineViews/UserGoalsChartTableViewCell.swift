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
    
    var goals: [Goal]! {
        didSet {
            displayChart()
        }
    }
    
    func displayChart() {
        
//        var dataEntries: [ChartDataEntry] = []
//        
//        for i in 0..<dataPoints.count {
//            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
//            dataEntries.append(dataEntry)
//        }
//        
//        
//        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Score")
//        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
//        
        var dataSets: [LineChartDataSet] = [LineChartDataSet]()
        
        for z in 0..<goals.count {
            var values: [ChartDataEntry] = [ChartDataEntry]()
            let sesstionsHistory = goals[z].sessionsHistory
            
            for i in 0..<(sesstionsHistory?.scores.count)! {
                let val: Double = Double((sesstionsHistory?.scores[i])!)
                values.append(ChartDataEntry(value: val, xIndex: i))
            }
            let d: LineChartDataSet = LineChartDataSet(yVals: values, label: "DataSet \(z + 1)")
            d.lineWidth = 2.5
            d.circleRadius = 4.0
            d.circleHoleRadius = 2.0
            
            d.setColor(ChartColorTemplates.colorFromString(UIColors.HomeTimelineChartLineColor))
            d.mode = .CubicBezier
            d.drawCircleHoleEnabled = false
            d.circleRadius = 3
            d.drawValuesEnabled = true
            d.setCircleColor(ChartColorTemplates.colorFromString(UIColors.HomeTimelineChartLineColor))
            
            //hide value
            d.drawValuesEnabled = !d.isDrawValuesEnabled
            dataSets.append(d)
        }
//        (dataSets[0] as! LineChartDataSet).lineDashLengths = [5.0, 5.0]
//        (dataSets[0] as! LineChartDataSet).colors = ChartColorTemplates.vordiplom
//        (dataSets[0] as! LineChartDataSet).circleColors = ChartColorTemplates.vordiplom
//       
        let values = ["1st", "2st", "3st", "4st", "5st", "6st"]
       
        let data: LineChartData = LineChartData(xVals: values, dataSets: dataSets)
        
        
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
