//
//  CommentViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit
import NextGrowingTextView

class CommentViewController: UIViewController {

    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputContainerViewBottom: NSLayoutConstraint!
    @IBOutlet weak var growingTextView: NextGrowingTextView!
    @IBOutlet weak var tableView: UITableView!
    var items = [TimelineItem]()
    var timeLineItem: TimelineItem?
    var goal: Goal?
    var cellIndex: Int?
    var goalID: Int?
    var displayName: String?
    var comments = [Comment]()
    var apiClient = APIClient.sharedInstance
    var showFullChart: Bool?
    enum pushFrom {
        case Timeline
        case User
    }
    var from: pushFrom?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CommentViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        self.growingTextView.layer.cornerRadius = 4
        self.growingTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.growingTextView.textContainerInset = UIEdgeInsets(top: 16, left: 0, bottom: 4, right: 0)
        self.growingTextView.placeholderAttributedText = NSAttributedString(string: "Placeholder text",
                                                                            attributes: [NSFontAttributeName: self.growingTextView.font!,
                                                                                NSForegroundColorAttributeName: UIColor.grayColor()
            ]
        )
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        if self.from == .Timeline {
            loadCommentsHomeTimeline()
        } else {
            loadCommentUser()
        }
        
        
        
        tableView.reloadData()
    }
    func loadCommentsHomeTimeline() {
        if let goalID = self.timeLineItem?.currentGoalSession?.goalId {
                apiClient.getComments(goalID, completed: { (comments) in
                self.comments = comments
                self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
            })
        }
    }
    
    func loadCommentUser() {
        if let goalID = self.goalID {
            apiClient.getComments(goalID, completed: { (comment) in
                self.comments = comment
                //self.tableView.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
                self.tableView.reloadData()
            })
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func handleSendButton(sender: AnyObject) {
        self.view.endEditing(true)
        let message = self.growingTextView.text
        if message.characters.count > 0 {
            if let goalId = self.timeLineItem?.currentGoalSession?.goalId
            {
                apiClient.postComments(goalId, comment: message, completed: { (successed, comment, message) in
                    if successed {
                        //update message list
                        if let _ = comment {
                            self.comments.insert(comment!, atIndex: 0)
                            self.tableView.reloadData()
                        }
                    } else {
                        HLKAlertView.show("Error", message: "Can't comment on this goal now. Please try again.", accessoryView: nil, cancelButtonTitle: "Try again", otherButtonTitles: nil, handler: nil)
                    }
                })
            } 
            
            if let _ = goal?.id {
                apiClient.postComments(goal!.id, comment: message, completed: { (successed, comment, message) in
                    if successed {
                        //update message list
                        if let _ = comment {
                            self.comments.insert(comment!, atIndex: 0)
                            self.tableView.reloadData()
                        }
                    } else {
                        HLKAlertView.show("Error", message: "Can't comment on this goal now. Please try again.", accessoryView: nil, cancelButtonTitle: "Try again", otherButtonTitles: nil, handler: nil)
                    }
                })
            }
        } else {
            HLKAlertView.show("Warning", message: "Please input message", accessoryView: nil, cancelButtonTitle: "OK", otherButtonTitles: nil, handler: nil)
        }
        
        self.growingTextView.text = ""
    }
    
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let _ = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                //key point 0,
                self.inputContainerViewBottom.constant =  0
                //textViewBottomConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in self.view.layoutIfNeeded() })
            }
        }
    }
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size.height {
                self.inputContainerViewBottom.constant = (keyboardHeight - 44)
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }


    func registerNibs() {
        tableView.registerNib(UINib(nibName: "TimelineItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineItemTableViewCell")
        tableView.registerNib(UINib(nibName: "CommentViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CommentTableViewCell")
        tableView.registerNib(UINib(nibName: "UserGoalTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "UserGoalTableViewCell")
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

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
                if (showFullChart != nil && showFullChart! == true) {
                    let cell = tableView.dequeueReusableCellWithIdentifier("UserGoalTableViewCell") as! UserGoalTableViewCell
                    if let goal = goal {
                        cell.goal = goal
                    }
                    return cell
                } else {
                   let cell = tableView.dequeueReusableCellWithIdentifier("TimelineItemTableViewCell") as! TimelineItemTableViewCell
                    if let timelineItem = timeLineItem {
                        cell.timeLineItem = timelineItem
                        cell.delegate = self
                    }
                    return cell
                }
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
            let commentItem = self.comments[indexPath.row]
            cell.commentItem = commentItem
           
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return comments.count
        
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if showFullChart != nil && showFullChart == true {
                return 50
            } else {
                return 0
            }
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            if showFullChart != nil && showFullChart == true {
                let view = UsersGoalSectionHeaderView.initFromNib()
                view.goal = goal
                return view
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}


extension CommentViewController: TimelineItemTableViewCellDelegate {
    func starButtonPressed(goalID: Int) -> Void {
        apiClient.star(goalID) { (successed, likeCount, message) in
            if successed {
                self.apiClient.goalDetail(["goal_id": goalID], completed: { (goal) in
                    self.timeLineItem?.currentGoalSession?.goal.likeCount = goal.likeCount
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                })
            } else {
                HLKAlertView.show("", message: message, accessoryView: nil, cancelButtonTitle: "OK", otherButtonTitles: nil, handler: nil)
            }
        }
        
    }
}
