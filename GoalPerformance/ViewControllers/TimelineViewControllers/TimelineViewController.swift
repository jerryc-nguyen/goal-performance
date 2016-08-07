//
//  TimelineViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/1/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var items = [TimelineItem]()
    
    var apiClient = APIClient.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        registerNibs()
        loadHomeTimelineItems()
        self.navigationItem.title = "Home Timeline"
    }
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "TimelineItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineItemTableViewCell")
    }
    
    func loadHomeTimelineItems() {
        apiClient.homeTimeLine { (items) in
            
            self.items = items
            self.tableView.reloadData()
        }
    }
    
}

extension TimelineViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimelineItemTableViewCell") as! TimelineItemTableViewCell
        let timelineItem = items[indexPath.row]
        cell.timeLineItem = timelineItem
        return cell
    }
}
