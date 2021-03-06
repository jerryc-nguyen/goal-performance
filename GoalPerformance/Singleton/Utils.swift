//
//  Utils.swift
//  GoalPerformance
//
//  Created by Welcome on 8/7/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import Foundation

class Utils {
    
    static func displayTabbarVCFor(selectedTabbarIndex: Int) {
        let tabbarVC = StoryboardManager.sharedInstance.getInitialViewController("Main") as! MainTabBarController
        tabbarVC.configTabbar()
        tabbarVC.selectedIndex = selectedTabbarIndex
        APP_DELEGATE.window?.rootViewController = tabbarVC
    }
    
    static let WeekDaysMap: [String: Int] = [
        "sunday": 1,
        "monday": 2,
        "tuesday": 3,
        "wednesday": 4,
        "thursday": 5,
        "friday": 6,
        "saturday": 7
    ]
    
    static func dateFromRailsString(str: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.dateFromString(str)
    }
    
    static func stringCountDownFromTimeInterval(interval: NSTimeInterval) -> String {
        let ti = NSInteger(interval)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
    }
    
    static func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}