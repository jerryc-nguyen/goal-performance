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
    
    func userTimeLine(params: [String: AnyObject], completed: (goals: [Goal], viewingUser: User?, dateLabels: [String]?) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.userTimeLine, params["user_id"] as! Int)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                
                
                if let JSON = response.result.value {
    
                    if let data = JSON["data"] as? Dictionary<String, AnyObject> {
                        
                        var items = [Goal]()
                        var user = User(dictionary: NSDictionary())
                        
                        if let goalsData = data["goals"] as? [Dictionary<String, AnyObject>] {
                            items = Goal.initFromArrayData(goalsData)
                        }
                        
                        if let userData = data["viewing_user"] as? Dictionary<String, AnyObject> {
                            user = User(dictionary: userData)
                        }
                        
                        let dateLabels = data["date_labels"] as? [String]
                        
                        completed(goals: items, viewingUser: user, dateLabels: dateLabels)
                        
                    } else {
                        completed(goals: [], viewingUser: nil, dateLabels: [])
                    }
                } else {
                    completed(goals: [], viewingUser: nil, dateLabels: [])
                }
        }
    }
    
    func connectFriend(friendID: Int, completed: (title: String, message: String) -> ()){
        let header = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let parameters = ["friend_id" : friendID]
        
        Alamofire.request(.POST, API_URLS.requestFriend, headers: header, parameters: parameters)
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
