//
//  APIResponse.swift
//  GoalPerformance
//
//  Created by Welcome on 8/3/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation

class APIResponse: NSObject {
    var dataObject: NSDictionary?
    var status: Int = 200
    var message: String = ""
    
    override init() {
        super.init()
    }
    
    init(json: NSDictionary?){
        if let json = json {
            if let status = json["status"] as? Int {
                self.status = status
            }
            if let message = json["message"] as? String {
                self.message = message
            }
            if let messages = json["message"] as? NSArray {
                if messages.count > 0 {
                    if let message = messages[0] as? String {
                        self.message = message
                    }
                }
            }
            if let data = json["data"] as? NSDictionary {
                self.dataObject = data
            }
        }
    }
}