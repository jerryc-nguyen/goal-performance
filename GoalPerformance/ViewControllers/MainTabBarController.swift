//
//  MainTabBarController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import FontAwesome_swift

let HomeTimelineTabbarIndex = 0
let UserTimelineTabbarIndex = 1
let FriendsTabbarIndex = 2

class MainTabBarController: UITabBarController {
    
    lazy var timeLineVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("Timeline") as! UINavigationController
        vc.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Globe, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        vc.tabBarItem.title = "Time Line"
        return vc
    }()
    
    lazy var userVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("User") as! UINavigationController
        vc.tabBarItem.image = UIImage.fontAwesomeIconWithName(.User, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        vc.tabBarItem.title = "You"
        return vc
    }()
    
    lazy var friendsVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("Friend") as! UINavigationController
        vc.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Users, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        vc.tabBarItem.title = "Friends"
        return vc
    }()
    
    lazy var searchVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("Map") as! UINavigationController
        vc.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Search, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        vc.tabBarItem.title = "Search"
        return vc
    }()
    
    lazy var chatVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("Chat") as! UINavigationController
        vc.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Comment, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        vc.tabBarItem.title = "Chat"
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTabbar()
    }
    
    func configTabbar() {
        self.tabBar.translucent = false
        self.viewControllers = [timeLineVC, userVC, friendsVC, chatVC, searchVC]
    }
    
    func goToUserTab(withUser: User?) {
        self.selectedIndex = UserTimelineTabbarIndex
        self.selectedViewController = self.viewControllers![UserTimelineTabbarIndex]
        if let navigation = self.selectedViewController as? UINavigationController {
            navigation.popToRootViewControllerAnimated(false)
            let userVC = navigation.viewControllers[0] as! UserViewController
            userVC.viewingUser = withUser
        }
    }
}
