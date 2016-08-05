//
//  Friends.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func friends(completed: (friends: [User]) -> ()) {
        let headers = [
            "X-Api-Token": "3dedef7c35a8d2549b3982c5276d1cd1"
        ]
        Alamofire.request(.GET, API_URLS.friends, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var friends = [User]()
                    for friendDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let friend = User(dictionary: friendDictionary)
                        friends.append(friend)
                    }
                    completed(friends: friends)
                }
        }
    }
    
}
