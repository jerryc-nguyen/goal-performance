//
//  Chats.swift
//  GoalPerformance
//
//  Created by Welcome on 8/30/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import Alamofire

extension APIClient {
    
    func myChats(page: Int, completed: (items: [MyChatItem]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.listChats, page)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var items = [MyChatItem]()
                    for itemDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let chatItem = MyChatItem(dictionary: itemDictionary)
                        items.append(chatItem)
                    }
                    completed(items: items)
                }
        }
    }
    
    
}