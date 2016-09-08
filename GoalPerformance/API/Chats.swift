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
    
    func myChats(page: Int, completed: (items: [ChatItem]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        let requestUrl = String(format: API_URLS.myChats, page)
        
        Alamofire.request(.GET, requestUrl, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var items = [ChatItem]()
                    
                    if (JSON["data"] != nil) {
                        for itemDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                            let chatItem = ChatItem(dictionary: itemDictionary)
                            items.append(chatItem)
                        }
                        completed(items: items)
                    }
                }
        }
    }
    
    func chatList(params: [String : AnyObject], completed: (items: [ChatItem]) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        Alamofire.request(.GET, API_URLS.chatList, parameters: params, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    var items = [ChatItem]()
                    for itemDictionary in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let chatItem = ChatItem(dictionary: itemDictionary)
                        items.append(chatItem)
                    }
                    completed(items: items)
                }
        }
    }
    
    func createChat(params: Dictionary<String, AnyObject>, completed: (ChatItem?) -> ()) {
        let headers = [
            "X-Api-Token": APIClient.currentUserToken
        ]
        
        Alamofire.request(.POST, API_URLS.chatting, parameters: params, headers: headers)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if JSON["status"] as! Int == 200 {
                        if let chatData = JSON["data"] as? NSDictionary {
                            let chat = ChatItem(dictionary: chatData)
                            completed(chat)
                        } else  {
                            completed(nil)
                        }
                    } else {
                        print(response.result.error?.localizedDescription)
                        completed(nil)
                    }
                }
        }
        
    }
    
    
}