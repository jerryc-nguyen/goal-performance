//
//  GoalStartEnd.swift
//  GoalPerformance
//
//  Created by sophie on 8/20/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    func goalStartEnd(params: Dictionary<String, AnyObject>, completed: CompletedBlock) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        Alamofire.request(.PUT, API_URLS.goalStartEnd, parameters: params, headers: headers)
        
        .responseJSON { response in
            if let JSON = response.result.value {
                if JSON["status"] as! Int == 200 {
                    if let completed = completed {
                        if let goalData = JSON["data"] as? NSDictionary {
                            let goal = Goal(dictionary: goalData)
                            completed(result: goal)
                        }
                    }
                } else {
                    if let completed = completed {
                        completed(result: nil)
                        print(response.result.error?.localizedDescription)
                    }
                    
                }
            }
        }

    }
}
