//
//  CommentViewController.swift
//  GoalPerformance
//
//  Created by sophie on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var items = [TimelineItem]()
    var cellIndex: Int?
    var goalID: Int?
    var comments = [Comment]()
    var apiClient = APIClient.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        registerNibs()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        loadComments()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func loadComments() {
        if let goalID = goalID {
            apiClient.getComments(goalID, completed: { (comments) in
                for comment in comments {
                    print(comment.id)
                    
                }
            })
        }
    }

    func registerNibs() {
        tableView.registerNib(UINib(nibName: "TimelineItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineItemTableViewCell")
        tableView.registerNib(UINib(nibName: "CommentViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CommentTableViewCell")
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
            let cell = tableView.dequeueReusableCellWithIdentifier("TimelineItemTableViewCell") as! TimelineItemTableViewCell
            if let cellIndex = cellIndex {
                let timelineItem = items[cellIndex]
                cell.timeLineItem = timelineItem

            }
            return cell
        default:
            //2
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
            return cell
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
