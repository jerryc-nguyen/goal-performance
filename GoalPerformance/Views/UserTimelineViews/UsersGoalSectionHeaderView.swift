//
//  UsersGoalSectionHeaderView.swift
//  GoalPerformance
//
//  Created by Welcome on 8/13/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class UsersGoalSectionHeaderView: UIView {

    @IBOutlet weak var sectionHeaderLabel: UILabel!
    
    class func initFromNib() -> UsersGoalSectionHeaderView! {
        return UINib(nibName:"UsersGoalSectionHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UsersGoalSectionHeaderView
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
