//
//  Goals.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    func createGoal() {
        
    }
    
    func homeTimeLine(completed: (items: [TimelineItem]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken 
        ]
        Alamofire.request(.GET, API_URLS.homeTimeLine, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var items = [TimelineItem]()
                    for itemDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let timelineItem = TimelineItem(dictionary: itemDictionary)
                        items.append(timelineItem)
                    }
                    completed(items: items)
                }
        }
    }
  }