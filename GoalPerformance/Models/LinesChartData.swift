//
//  LinesChartData.swift
//  GoalPerformance
//
//  Created by Welcome on 8/24/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class LinesChartData: NSObject {
    var dateLabels: [String]!
    var sessionsHistories: [SessionsHistory]!
    
    init(chartData: NSDictionary) {
        
        if let dateLabelsArr = chartData["date_labels"] as? [String] {
            dateLabels = dateLabelsArr
        }
        
        if let sessionsData = chartData["sessions_histories"] as? [NSDictionary] {
            sessionsHistories = SessionsHistory.initFromArrayData(sessionsData)
        }
        
    }
}
