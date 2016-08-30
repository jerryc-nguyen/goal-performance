//
//  Comments.swift
//  GoalPerformance
//
//  Created by sophie on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func getComments(goaldSessionID:Int, completed: (comment: [Comment]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.getComments, goaldSessionID)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var comments = [Comment]()
                    for commentDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let comment = Comment(dictionary: commentDictionary)
                        comments.append(comment)
                    }
                    
                    completed(comment: comments)
                }
        }
    }
}