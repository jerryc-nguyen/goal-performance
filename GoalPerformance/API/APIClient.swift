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
//let APIBaseURL = "http://192.168.1.93:3000"
//let APIBaseURL = "http://localhost:3000"

struct API_URLS {
    //AUTH
    static let loginFacebook = "\(APIBaseURL)/api/auth/facebook.json"
    
    //FRIENDS
    static let friends = "\(APIBaseURL)/api/friends.json"
    static let suggestFriends = "\(APIBaseURL)/api/goal_sessions/%d/suggest_buddies.json"
    static let buddiesFriends = "\(APIBaseURL)/api/friends/buddies.json"
    
    //FRIENDSHIPS
    static let requestFriend = "\(APIBaseURL)/api/friendships/request_friend.json"
    static let acceptFriend = "\(APIBaseURL)/api/friendships/accept_friend.json"
    static let rejectFriend = "\(APIBaseURL)/api/friendships/reject_friend.json"
    static let pendingFriend = "\(APIBaseURL)/api/friendships/incomming.json"
    
    //GOALS SESSION
    static let inviteGoal = "\(APIBaseURL)/api/goal_sessions/%d/invite.json"
    static let inviteGoalByEmail = "\(APIBaseURL)/api/goal_sessions/%d/invite_by_email.json"
    static let acceptGoal = "\(APIBaseURL)/api/goal_sessions/%d/accept.json"
    static let deleteGoal = "\(APIBaseURL)/api/goal_sessions/%d.json"
    static let pendingBuddies = "\(APIBaseURL)/api/goal_sessions/pending_accept.json"
    
    //GOALS
    static let createGoal = "\(APIBaseURL)/api/goals.json"
    static let goalDetail = "\(APIBaseURL)/api/goals/%d.json"
    
    //CATEGORIES
    static let getCategories = "\(APIBaseURL)/api/categories.json"

    //SETUP GOAL
    static let goalSetup = "\(APIBaseURL)/api/goals.json"

    //USERS
    static let homeTimeLine = "\(APIBaseURL)/api/users/home_timeline.json?page=%d"
    static let userTimeLine = "\(APIBaseURL)/api/users/%d/timeline.json"
    
    //GOAL START-END
    static let goalStartEnd = "\(APIBaseURL)/api/goal_sessions/handle_start_end.json"
}

typealias CompletedBlock = ((result: AnyObject?) -> Void)?

class APIClient {
    static var currentUser: User = User(dictionary: NSDictionary())
    static let sharedInstance = APIClient()
    static var currentUserToken: String = "3dedef7c35a8d2549b3982c5276d1cd1"
    
}