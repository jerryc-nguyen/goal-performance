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
    
    func inviteGoal(goalID: String, friendID: String, completed: (title: String, message: String) -> ()) {
        let inviteGoalURL = "\(APIBaseURL)/api/goals/\(goalID)/invite.json"
        let header = [
             "X-Api-Token": APIClient.currentUserToken
        ]
        
        let parameters = ["friend_id" : friendID]
        
        Alamofire.request(.POST, inviteGoalURL, headers: header, parameters: parameters)
            .responseJSON { response in
            if let JSON = response.result.value {
                
                var title = ""
                var message = ""
                let status = JSON["status"] as! Int
                
                if status == 200 {
                    let dictionary = JSON["data"] as! Dictionary<String, AnyObject>
                    title = "Success!"
                    message = dictionary["message"] as! String
                } else {
                    title = "Fail"
                    message = JSON["error_message"] as! String
                }
                
                completed(title: title, message: message)
            }
        }
        
    }
    
}