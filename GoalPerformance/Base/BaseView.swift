//
//  BaseView.swift
//  GoalPerformance
//
//  Created by sophie on 8/17/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

extension UIView {
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    func height() -> CGFloat {
        return self.frame.size.height
    }
    
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func makeCircle() {
        cornerRadius(self.width()/2)
    }
}