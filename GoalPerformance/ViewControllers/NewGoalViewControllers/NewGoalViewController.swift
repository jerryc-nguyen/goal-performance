//
//  NewGoalViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController {

    var categories: Array<Category>?
    var buttons: Array<UIButton>? = Array<UIButton>()
    var _currentX: CGFloat = 10
    var _currentY: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        APIClient.sharedInstance.categories { [unowned self] (result) in
            if result != nil {
                self.categories = result as? Array<Category>
                for category in self.categories! {
                    self._createButtonWithTitle(category.name!)
                }
            }
        }

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        APIClient.sharedInstance.categories { [unowned self] (result) in
//            if result != nil {
//                self.categories = result as? Array<Category>
//                for category in self.categories! {
//                    self._createButtonWithTitle(category.name!)
//                }
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    // MARK: - Private methods
    private func _createButtonWithTitle(title: String) {
        let button = UIButton(type: .System)
        button.setTitle(title, forState: .Normal)
        button.backgroundColor = UIColor.whiteColor()
        button.sizeToFit()
        button.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        let width = button.frame.size.width + 20
        button.frame = CGRectMake(_currentX, _currentY, width, width)
        
        button.layer.cornerRadius = width/2
        button.layer.masksToBounds = true
        
        button.layer.borderWidth = 1
      //  btn.layer.borderColor = UIColor.orangeColor().CGColor
        
        if _currentX > 10 {
            _currentX = 10
        } else {
            _currentX = UIScreen.mainScreen().bounds.size.width/2
        }
        _currentY += width/4*3
        
        self.view.addSubview(button)
        
        self.buttons?.append(button)
        
        button.addTarget(self, action: #selector(NewGoalViewController.categoryselectedAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func categoryselectedAction() {
        let defineGoalViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DefineGoalViewController") as? DefineGoalViewController
        if let defineGoalViewController = defineGoalViewController {
        self.navigationController?.pushViewController(defineGoalViewController, animated: true)
        }
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
