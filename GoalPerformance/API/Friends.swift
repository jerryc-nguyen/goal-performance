//
//  Friends.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func getAllFriends(completed: (friends: [User]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
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
    
    func getSuggestedBuddies(goaldSessionID:Int, completed: (friends: [User]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.suggestBuddies, goaldSessionID)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
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
    
    func getPendingFriend(completed: (friends: [User]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        Alamofire.request(.GET, API_URLS.pendingFriend, headers: headers)
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
    
    func acceptFriend(friendID: Int, completed: (title: String, message: String) -> ()) {
        let header = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let parameters = ["friend_id" : friendID]
        
        Alamofire.request(.POST, API_URLS.acceptFriend, headers: header, parameters: parameters)
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
    
    func rejectFriend(friendID: Int, completed: (title: String, message: String) -> ()) {
        let header = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let parameters = ["friend_id" : friendID]
        
        Alamofire.request(.POST, API_URLS.rejectFriend, headers: header, parameters: parameters)
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
    
    func getBuddiesFriend(completed: (friends: [User]) -> ()) {
            let headers = [
                "X-Api-Token": APIClient.currentUserToken
            ]
            Alamofire.request(.GET, API_URLS.buddiesFriends, headers: headers)
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
