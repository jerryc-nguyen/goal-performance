//
//  SessionHistory.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class SessionsHistory: NSObject {
    var scores: [Double] = []
    var dateLabels: [String]? = []
    
    init(dictionary: NSDictionary) {
        if let goalScores = dictionary["scores"] as? [NSNumber] {
            for score in goalScores {
                scores.append(Double(score))
            }
        }
        
        if let dateLabelArr = dictionary["date_labels"] as? [String] {
            dateLabels = dateLabelArr
        }
    }
    
    class func initFromArrayData(arr: [NSDictionary]) -> [SessionsHistory] {
        var results = [SessionsHistory]()
        for data in arr {
            results.append(SessionsHistory(dictionary: data))
        }
        return results
    }
}