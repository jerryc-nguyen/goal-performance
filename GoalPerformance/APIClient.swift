//
//  APIClient.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import Alamofire //https://github.com/Alamofire/Alamofire

//let APIBaseURL = "https://goal-api.herokuapp.com/"
let APIBaseURL = "http://localhost:3000"

struct API_URLS {
    //AUTH
    static let loginFacebook = "\(APIBaseURL)/api/auth/facebook.json"
    
    //FRIENDS
    static let friends = "\(APIBaseURL)/api/friends.json"
    
    //FRIENDSHIPS
    static let requestFriend = "\(APIBaseURL)/api/friendships/request_friend.json"
    static let acceptFriend = "\(APIBaseURL)/api/friendships/accept_friend.json"
    
    //GOALS
    static let createGoal = "\(APIBaseURL)/api/goals.json"
    static let homeTimeLine = "\(APIBaseURL)/api/goals/home_timeline.json"
}

class APIClient {
    static let sharedInstance = APIClient()
    static let currentUserToken: String = "3dedef7c35a8d2549b3982c5276d1cd1"
    
}