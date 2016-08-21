//
//  GoalStartEnd.swift
//  GoalPerformance
//
//  Created by sophie on 8/20/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    func updateGoalStatus(params: Dictionary<String, AnyObject>, completed: (GoalSession?) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        Alamofire.request(.POST, API_URLS.goalStartEnd, parameters: params, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if JSON["status"] as! Int == 200 {
                        if let goalData = JSON["data"] as? NSDictionary {
                            let goalSession = GoalSession(dictionary: goalData)
                            completed(goalSession)
                        } else  {
                            completed(nil)
                        }
                    } else {
                        print(response.result.error?.localizedDescription)
                        completed(nil)
                    }
                }
            }

    }
}
