//
//  Constants.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

let APP_DELEGATE             = UIApplication.sharedApplication().delegate as! AppDelegate
let DocumentPath             = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]


struct ScreenSize {
    static let Width            = UIScreen.mainScreen().bounds.size.width
    static let Height           = UIScreen.mainScreen().bounds.size.height
    static let MaxLength       = max(ScreenSize.Width, ScreenSize.Height)
    static let MinLength       = min(ScreenSize.Width, ScreenSize.Height)
    static let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
    static let MarginSmall = 0.048*ScreenSize.Width
    static let MarginMedium = 0.0986*ScreenSize.Width
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MaxLength < 568.0
    static let IS_IPHONE_5         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MaxLength == 568.0
    static let IS_IPHONE_6         = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MaxLength == 667.0
    static let IS_IPHONE_6P        = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.MaxLength == 736.0
    static let IS_IPAD             = UIDevice.currentDevice().userInterfaceIdiom == .Pad && ScreenSize.MaxLength == 1024.0
}

//https://www.ralfebert.de/snippets/ios/swift-uicolor-picker/
struct UIColors {
    static let HomeTimelineChartLineColor = UIColor(hue: 14.0, saturation: 87.0, brightness: 100.0, alpha: 1.0)

    static let GoalDoingBackground = UIColor(hue: 14.0, saturation: 11.0, brightness: 100.0, alpha: 1.0)
    
//    static let ThemeOrange = UIColor(hue: 14.0, saturation: 87.0, brightness: 100.0, alpha: 1.0)
    static let ThemeOrange = UIColor(netHex: 0xff5722)
    
    static let BackgroundOrange = UIColor(hue: 13.0, saturation: 4.0, brightness: 100.0, alpha: 1.0)
    
}

