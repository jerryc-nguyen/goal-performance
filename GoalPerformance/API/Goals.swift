//
//  Goals.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func goalDetail(params: [String: AnyObject], completed: (goal: Goal) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        let requestUrl = String(format: API_URLS.goalDetail, params["goal_id"] as! Int)
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let goalData = JSON["data"] as? NSDictionary {
                        completed(goal: Goal(dictionary: goalData))
                    }
                }
        }
    }

    func inviteGoal(goalID: Int, friendID: Int, completed: (title: String, message: String) -> ()) {
        
        let header = [
             "X-Api-Token": APIClient.currentUserToken
        ]
        
        let parameters = ["friend_id" : friendID]
        
        let requestUrl = String(format: API_URLS.inviteGoal, goalID)
        
        Alamofire.request(.POST, requestUrl, headers: header, parameters: parameters)
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