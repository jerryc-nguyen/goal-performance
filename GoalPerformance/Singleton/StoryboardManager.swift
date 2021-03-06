//
//  StoryboardManager.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit


class StoryboardManager {
    
    static let sharedInstance = StoryboardManager()
    
    func getViewController(viewControllerID: String, storyboard:String) -> UIViewController{
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        return sb.instantiateViewControllerWithIdentifier(viewControllerID)
    }
    
    func getInitialViewController(storyboard:String) -> UIViewController {
        let mainView = UIStoryboard(name:storyboard, bundle: nil)
        return mainView.instantiateInitialViewController()!
    }
    
    func initViewFromNib(nibName: String) -> UIView! {
        return UINib(nibName: nibName, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    func initViewControllerFromNib(nibName: String) -> UIViewController! {
        return UINib(nibName: nibName, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIViewController
    }
    
}