//
//  MainTabBarController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    lazy var timeLineVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("Timeline") as! UINavigationController
        vc.tabBarItem.image = UIImage(named: "excited")
        vc.tabBarItem.title = "Time Line"
        return vc
    }()
    
    lazy var userVC: UINavigationController  = {
        let vc = StoryboardManager.sharedInstance.getInitialViewController("User") as! UINavigationController
        vc.tabBarItem.image = UIImage(named: "happy")
        vc.tabBarItem.title = "User"
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTabbar()
    }
    
    func configTabbar() {
        self.tabBar.translucent = false
        self.viewControllers = [timeLineVC, userVC]
    }

}
