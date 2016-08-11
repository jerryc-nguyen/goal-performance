//
//  WeekdayCell.swift
//  GoalPerformance
//
//  Created by sophie on 8/10/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class WeekdayCell: UITableViewCell {

   
    var isSelected :Bool? = false
    
    @IBOutlet weak var weekdayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
