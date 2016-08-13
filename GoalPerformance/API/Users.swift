//
//  Users.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
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
    
    func userTimeLine(params: [String: AnyObject], completed: (goals: [Goal], viewingUser: User?) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.userTimeLine, params["user_id"] as! Int)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                var items = [Goal]()
                
                if let JSON = response.result.value {
    
                    if let data = JSON["data"] as? Dictionary<String, AnyObject> {
                        if let goalsData = data["goals"] as? [Dictionary<String, AnyObject>] {
                            items = Goal.initFromArrayData(goalsData)
                        }
                        
                        if let userData = data["viewing_user"] as? Dictionary<String, AnyObject> {
                            let user = User(dictionary: userData)
                            completed(goals: items, viewingUser: user)
                        }
                    } else {
                        completed(goals: items, viewingUser: nil)
                    }
                } else {
                    completed(goals: items, viewingUser: nil)
                }
        }
    }
}
