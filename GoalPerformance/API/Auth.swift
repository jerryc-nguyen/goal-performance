//
//  Auth.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    func loginFacebook(accessToken: String, completed: (currentUser: User) -> () ) {
        let parameters = ["token" : accessToken]
        
        Alamofire.request(.POST, API_URLS.loginFacebook, parameters: parameters)
            .responseJSON { response in
                if let JSON = response.result.value {
                    let userDictionary = JSON["data"] as! Dictionary<String, AnyObject>
                    let loggedUser = User(dictionary: userDictionary)
                    completed(currentUser: loggedUser)
                }
        }
        
    }
}
