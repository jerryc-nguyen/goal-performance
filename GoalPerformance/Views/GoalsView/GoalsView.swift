//
//  GoalsView.swift
//  GoalPerformance
//
//  Created by sophie on 8/17/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

protocol GoaldViewDelegate: class {
    func selectedCategoryAtIndex(index: Int)
    
}

class GoalsView: UIView {

    weak var delegate: GoaldViewDelegate?
    
    class func initFromNib() -> GoalsView! {
        return UINib(nibName:"GoalsView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! GoalsView
    }
    
    func createCategories(categories: [Category]) {
        for i in 0..<categories.count {
            let category = categories[i]
            let button = self.viewWithTag(i+1) as! UIButton
            button.makeCircle()
            button.setTitle(category.name, forState: .Normal)
            button.addTarget(self, action: #selector(categoryselectedAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.hidden = false
        }
    }

    func categoryselectedAction(sender: UIButton) {
        delegate?.selectedCategoryAtIndex(sender.tag - 1)
    }
}
