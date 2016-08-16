//
//  Categories.swift
//  GoalPerformance
//
//  Created by sophie on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Alamofire

extension APIClient {
    
    func categories(completed: CompletedBlock) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        Alamofire.request(.GET, API_URLS.getCategories, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if JSON["status"] as! Int == 200 {
                        
                        var categories = [Category]()
                        
                        let categoriesDict = JSON["data"] as! [Dictionary<String, AnyObject>]
                        for categoryDictionary in categoriesDict {
                            let category = Category(dictionary: categoryDictionary)
                            categories.append(category)
                        }
                        if let completed = completed {
                            completed(result: categories)
                        }
                    }
                    else {
                        if let completed = completed {
                            completed(result: nil)
                        }
                    }
                }
        }
    }
    
}
