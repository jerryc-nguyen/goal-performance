//
//  NewGoalViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

//protocol NewGoalViewControllerDelegate: class {
//    func newGoalViewController(newGoalVC: NewGoalViewController, categoryId: Int?, categoryName: String?)
//}


class NewGoalViewController: UIViewController {
    
//    weak var delegate: NewGoalViewControllerDelegate?
    var categories: Array<Category>?
    var buttons: Array<UIButton>? = Array<UIButton>()
    var _currentX: CGFloat = 10
    var _currentY: CGFloat = 70
    var categoryId:Int? = 0
    var categoryName:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        APIClient.sharedInstance.categories { [unowned self] (result) in
            if result != nil {
                self.categories = result as? Array<Category>
                for category in self.categories! {
                    self._createButtonWithTitle(category.name!, index: (self.categories?.indexOf(category))!)
                }
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    // MARK: - Private methods
    private func _createButtonWithTitle(title: String, index: Int) {
        
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
        if _currentX > 10 {
            _currentX = 10
        } else {
            _currentX = UIScreen.mainScreen().bounds.size.width/2
        }
        _currentY += width/4*3
        
        button.tag = index
        
        self.view.addSubview(button)
        
        self.buttons?.append(button)
        
        button.addTarget(self, action: #selector(categoryselectedAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func categoryselectedAction(sender: UIButton) {
        let defineGoalViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DefineGoalViewController") as? DefineGoalViewController
        
        if let categories = self.categories {
            let category = categories[sender.tag]
            print(category.id)
            print(category.name)
            self.categoryName = category.name
            self.categoryId = category.id
        }
//        performSegueWithIdentifier("DefineGoalSegue", sender: self)
        
        if let defineGoalViewController = defineGoalViewController {
            
            defineGoalViewController.categoryID = self.categoryId
            defineGoalViewController.categoryName = self.categoryName
            self.navigationController?.pushViewController(defineGoalViewController, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "DefineGoalSegue" {
//            let defineGoalVC = segue.destinationViewController as! DefineGoalViewController
//            defineGoalVC.categoryID = self.categoryId
//            defineGoalVC.categoryName = self.categoryName
//        }
//
//    }
//  
}
