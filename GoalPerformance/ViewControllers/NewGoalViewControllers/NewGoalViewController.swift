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
    
    var goalsViewList: Array<GoalsView>? = []
    
    
    @IBOutlet var containView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
        APIClient.sharedInstance.categories { [unowned self] (result) in
            if result != nil {
                self.categories = result as? Array<Category>
                self._createGoalsView(self.categories)
                self._drawGoalViews()
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
    
    @IBAction func showCategoriesAction(sender: UIButton) {
        _moveGoalsView()
    }
    

    // MARK: - Private methods
    private func _createGoalsView(categories: [Category]?) {
        guard let categories = categories else { return }
        let numberOfCategory = categories.count
        if numberOfCategory > 0 {
            let numberOfGoalsView = Int(numberOfCategory/5 + 1)
            var currentCategory: Int = 0
            for i in 0..<numberOfGoalsView {
                if (i + 1) == numberOfGoalsView {
                    let goalsView = GoalsView.initFromNib()
                    let subCategories = Array(categories[currentCategory..<categories.count])
                    goalsView.createCategories(subCategories)
                    goalsView.delegate = self
                    goalsViewList?.append(goalsView)
                } else {
                    let goalsView = GoalsView.initFromNib()
                    let subCategories = Array(categories[currentCategory..<currentCategory+5])
                    goalsView.createCategories(subCategories)
                    goalsView.delegate = self
                    goalsViewList?.append(goalsView)
                }
                currentCategory += 5
            }
        }
    }

    private func _drawGoalViews() {
        var y: CGFloat = 0
        for goalsView in self.goalsViewList! {
            var frame = containView.bounds
            frame.origin.y += y
            goalsView.frame = frame
            y += frame.height
            self.containView.addSubview(goalsView)
            self.containView.contentSize = CGSize(width: containView.width(), height: y)
        }
    }
    
    private func _moveGoalsView() {
        guard let goalsViewList = goalsViewList else {
            return
        }
        let contentOffset = containView.contentOffset
        let nextIndex = Int(contentOffset.y/containView.height()) + 1
        if nextIndex < goalsViewList.count {
            let goalsView = goalsViewList[nextIndex]
            containView.scrollRectToVisible(goalsView.frame, animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "DefineGoalSegue" {
//            
//        }
//    }
}


extension NewGoalViewController: GoaldViewDelegate {
    func selectedCategoryAtIndex(index: Int) {
        let defineGoalViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DefineGoalViewController") as? DefineGoalViewController
        
        if let categories = self.categories {
            let category = categories[index]
            print(category.id)
            print(category.name)
            if self.categoryName == self.categoryName {
                self.categoryName = category.name
            }
            self.categoryId = category.id
        }
        //        performSegueWithIdentifier("DefineGoalSegue", sender: self)
        
        if let defineGoalViewController = defineGoalViewController {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            defineGoalViewController.categoryID = self.categoryId
            defineGoalViewController.categoryName = self.categoryName
            defineGoalViewController.hasGoal = false
            self.navigationController?.pushViewController(defineGoalViewController, animated: true)
        }
    }
}
