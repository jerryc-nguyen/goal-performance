//
//  Goal.swift
//  GoalPerformance
//
//  Created by Welcome on 8/6/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import Foundation
import UIKit

class Goal: NSObject {
    
    let id: Int!
    let name: String!
    var startAt: NSDate?
    var repeatEvery: [String]? = []
    var duration: Int = 0
    let soundName: String?
    var isChallenge: Bool = false
    var isDefault: Bool = false
    let token: String?
    let detailName: String?
    let categoryColor: String?
    var startAtInterval: Int = 0
    var endAtInterval: Int = 0
    var startAtHour: Int = 0
    var startAtMinute: Int = 0
    var startAtSecond: Int = 0
    
    let localNotificationManager = LocalNotificationsManager.sharedInstance
    
    var sessionsHistory: SessionsHistory?
    
    let DefaultWeekDayIndex = 1 //Sunday
    
    var notificationStartKey: String {
        return "goal-\(self.id)-start"
    }
    
    var notificationEndKey: String {
        return "goal-\(self.id)-end"
    }
    
    var isDoingTime: Bool {
        get {
            let currentDateTime = NSDate()
            let currentWeekDay = currentDateTime.dayOfTheWeek()?.lowercaseString
            if currentWeekDay != nil && (repeatEvery?.indexOf(currentWeekDay!))! != -1 {
                let currentInterval = NSDate().timeIntervalSince1970
    
                if currentInterval >= startIntervalFrom1970 && currentInterval <= endIntervalFrom1970 {
                    return true
                }
                return false
            }
            return false
        }
    }
    
    var startIntervalFrom1970: Double {
        return NSDate().beginningOfDay().timeIntervalSince1970 + Double(startAtInterval)
    }
    
    var endIntervalFrom1970: Double {
        return NSDate().beginningOfDay().timeIntervalSince1970 + Double(endAtInterval)
    }
    
    var remainingTime: String {
        get {
            let remainingInterval = endIntervalFrom1970 -  NSDate().timeIntervalSince1970
            if remainingInterval < 0 {
                return "00:00"
            }
            return Utils.stringCountDownFromTimeInterval(remainingInterval)
        }
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        soundName = dictionary["sound_name"] as? String
        token = dictionary["token"] as? String
        detailName = dictionary["detail_name"] as? String
        categoryColor = dictionary["category_selected_color"] as? String
        
        if let repeatEvery = dictionary["repeat_every"] as? [String] {
            self.repeatEvery = repeatEvery
        }
        
        if let startAtStr = dictionary["start_at"] as? String {
            if let startAtDate = Utils.dateFromRailsString(startAtStr) {
                startAt = startAtDate
            }
        }

        if let isChallenge = dictionary["is_challenge"] as? Bool {
            self.isChallenge = isChallenge
        }
        
        if let isDefault = dictionary["is_default"] as? Bool {
            self.isDefault = isDefault
        }
        
        if let duration = dictionary["duration"] as? Int {
            self.duration = duration
        }
        
        if let startAtInterval = dictionary["start_at_interval"] as? Int {
            self.startAtInterval = startAtInterval
        }
        
        if let endAtInterval = dictionary["end_at_interval"] as? Int {
            self.endAtInterval = endAtInterval
        }
        
        if let startAtHour = dictionary["start_at_hour"] as? Int {
            self.startAtHour = startAtHour
        }
        
        if let startAtMinute = dictionary["start_at_minute"] as? Int {
            self.startAtMinute = startAtMinute
        }
        
        if let startAtSecond = dictionary["start_at_second"] as? Int {
            self.startAtSecond = startAtSecond
        }
        
        if let sessionsHistoryData = dictionary["sessions_history"] as? NSDictionary {
            sessionsHistory = SessionsHistory(dictionary: sessionsHistoryData)
        }
    }
    
    static func initFromArrayData(goalsData: [NSDictionary]) -> [Goal] {
        var results = [Goal]()
        for goalData in goalsData {
            results.append(Goal(dictionary: goalData))
        }
        return results
    }
    
    
    func registerStartGoalNotifications() {
        localNotificationManager.removeNotificationHasKeyContains(notificationStartKey)
        for repeatDay in repeatEvery! {
            let weekdayIndex = Utils.WeekDaysMap[repeatDay] ?? DefaultWeekDayIndex
            registerStartGoalNotification(weekdayIndex)
        }
    }
    
    func registerStartGoalNotification(weekdayIndex: Int) {
        let key = notificationStartKey + "-day-" + String(weekdayIndex)
        let notification = UILocalNotification()
        let message = "Goal \(name) ending time!"
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.weekday = weekdayIndex // sunday = 1 ... saturday = 7
        dateComponents.hour = startAtHour
        dateComponents.minute = startAtMinute
        dateComponents.second = startAtSecond
        
        notification.alertBody = message
        notification.alertAction = "open"
        notification.fireDate = calendar.dateFromComponents(dateComponents)
        notification.soundName = "\(AlarmSoundName).\(AlarmSoundExtension)"
        notification.userInfo = ["message": message, "UUID": key, "notificationName": LocalNotificationName.StartGoal]
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func registerEndGoalNotifications() {
        localNotificationManager.removeNotificationHasKeyContains(notificationEndKey)
        for repeatDay in repeatEvery! {
            let weekdayIndex = Utils.WeekDaysMap[repeatDay] ?? DefaultWeekDayIndex
            registerEndGoalNotification(weekdayIndex)
        }
    }
    
    func registerEndGoalNotification(weekdayIndex: Int) {
        let key = notificationEndKey + "-day-" + String(weekdayIndex)
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let dateComponents: NSDateComponents = NSDateComponents()
        dateComponents.weekday = weekdayIndex // sunday = 1 ... saturday = 7
        dateComponents.hour = startAtHour
        dateComponents.minute = startAtMinute
        dateComponents.second = startAtSecond
        
        let notification = UILocalNotification()
        let message = "Goal \(name) ending time!"
        notification.alertBody = message
        notification.alertAction = "open"
        notification.fireDate = calendar.dateFromComponents(dateComponents)
        notification.soundName = "\(AlarmSoundName).\(AlarmSoundExtension)"
        notification.userInfo = ["message": message, "UUID": key, "notificationName": LocalNotificationName.EndGoal]
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}