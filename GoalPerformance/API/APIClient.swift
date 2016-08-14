//
//  APIClient.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import Alamofire //https://github.com/Alamofire/Alamofire


let APIBaseURL = "https://goal-api.herokuapp.com/"
//let APIBaseURL = "http://localhost:3000"

struct API_URLS {
    //AUTH
    static let loginFacebook = "\(APIBaseURL)/api/auth/facebook.json"
    
    //FRIENDS
    static let friends = "\(APIBaseURL)/api/friends.json"
    static let suggestFriends = "\(APIBaseURL)/api/suggested.json"
    
    //FRIENDSHIPS
    static let requestFriend = "\(APIBaseURL)/api/friendships/request_friend.json"
    static let acceptFriend = "\(APIBaseURL)/api/friendships/accept_friend.json"
    
    //GOALS
    static let createGoal = "\(APIBaseURL)/api/goals.json"
    

    //CATEGORIES
    static let getCategories = "\(APIBaseURL)/api/categories.json"
    

    //SETUP GOAL
    static let goalSetup = "\(APIBaseURL)api/goals.json"

    //USERS
    static let homeTimeLine = "\(APIBaseURL)/api/users/home_timeline.json"
    static let userTimeLine = "\(APIBaseURL)/api/users/%d/timeline.json"

}


typealias CompletedBlock = ((result: AnyObject?) -> Void)?

class APIClient {
    static var currentUser: User = User(dictionary: NSDictionary())
    static let sharedInstance = APIClient()
    static var currentUserToken: String = "3dedef7c35a8d2549b3982c5276d1cd1"
    
}