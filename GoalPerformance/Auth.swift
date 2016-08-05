//
//  Auth.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    func loginFacebook() {
        let parameters = ["token" : "token"]
        
        Alamofire.request(.POST, API_URLS.loginFacebook, parameters: parameters)
            .response { request, response, data, error in
                print(request)
                print(response)
                print(data)
                print(error)
        }
        
    }
}
