//
//  Comments.swift
//  GoalPerformance
//
//  Created by sophie on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func getComments(goalID:Int, completed: (comment: [Comment]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.getComments, goalID)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var comments = [Comment]()
                    let data = JSON["data"]
                    for commentDictionary in data as! [Dictionary<String, AnyObject>] {
                        let comment = Comment(dictionary: commentDictionary)
                        comments.append(comment)
                    }
                    completed(comment: comments)
                }
        }
    }
    
    func star(goalID: Int, completed: (successed: Bool, likeCount: Int,message: String) -> ()) {
        
        let header = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        let requestUrl = String(format: API_URLS.postStar, goalID)
        
        Alamofire.request(.POST, requestUrl, headers: header, parameters: nil)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON["status"] as! Int
                    
                    if status == 200 {
                        let data = JSON["data"] as? Dictionary<String, AnyObject>
                        let count = data!["likes_count"] as! Int
                        completed(successed: true, likeCount: count, message: "")
                    } else {
                        completed(successed: false, likeCount: 0, message: "Failed to star this goal")
                    }
                }
        }
    }
    
   
    func postComments(goalID: Int, comment: String, completed: (successed: Bool, comment: Comment?, message: String) -> ()) {
        
        let header = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        let requestUrl = String(format: API_URLS.postComments, goalID)
        let params = ["comment[content]": comment]
        
        Alamofire.request(.POST, requestUrl, headers: header, parameters: params)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON["status"] as! Int
                    
                    if status == 200 {
                        let data = JSON["data"] as? Dictionary<String, AnyObject>
                        let responseComment = Comment(dictionary: data!)
                        completed(successed: true, comment: responseComment, message: "")

                    } else {
                        let error = JSON["error_message"] as! String
                        completed(successed: false, comment: nil, message: error)
                    }
                }
        }
    }
    
}