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
    var categoryId:Int? = 0
    var categoryName:String! = ""
    
    @IBOutlet var containView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        APIClient.sharedInstance.categories { [unowned self] (result) in
            if result != nil {
                self.categories = result as? Array<Category>
                self._createButtons(self.categories)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    // MARK: - Private methods
    private func _createButtons(categories: [Category]?) {
        if let categories = categories {
            if categories.count > 0 { //ToDO
                for i in 0..<5 {
                    let category = categories[i]
                    let button = self.view.viewWithTag(i+1) as! UIButton
                    button.makeCircle()
                    button.setTitle(category.name, forState: .Normal)
                    button.addTarget(self, action: #selector(categoryselectedAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                }
            }
        }
    }
    
    
    func categoryselectedAction(sender: UIButton) {
        let defineGoalViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DefineGoalViewController") as? DefineGoalViewController
        
        if let categories = self.categories {
            let category = categories[sender.tag]
            print(category.id)
            print(category.name)
            if self.categoryName == self.categoryName {
            self.categoryName = category.name
            }
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
