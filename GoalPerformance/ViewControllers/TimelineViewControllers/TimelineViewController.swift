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
    var cellIndex: Int?
    var items = [TimelineItem]()
    var apiClient = APIClient.sharedInstance
    let refreshControl = UIRefreshControl()
    var isMoreDataLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    var currentPage = 1
    var hasMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), forControlEvents: UIControlEvents.ValueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        registerNibs()
        loadHomeTimelineItems()
        navigationItem.title = "Home Timeline"
    }
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "TimelineItemTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "TimelineItemTableViewCell")
    }
        
    func pullToRefresh() {
        currentPage = 1
        hasMoreData = true
        loadHomeTimelineItems()
    }
    
    func loadHomeTimelineItems() {
        apiClient.homeTimeLine(currentPage) { (items) in
            if self.isMoreDataLoading {
                self.items += items
                self.hasMoreData = items.count != 0
            } else {
                self.items = items
            }
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
            // Update flag
            self.isMoreDataLoading = false
            
            // Stop the loading indicator
            self.loadingMoreView!.stopAnimating()
        }
    }
}

extension TimelineViewController : UITableViewDelegate {
    
}

extension TimelineViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading && hasMoreData) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                
                currentPage += 1
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                loadHomeTimelineItems()
            }
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
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let currentTimelineItem = items[indexPath.row]
        let storyboardManager = StoryboardManager.sharedInstance
        let commentVC = storyboardManager.getViewController("CommentViewController", storyboard: "Timeline") as? CommentViewController
        commentVC?.showFullChart = false
        commentVC?.timeLineItem = currentTimelineItem
        commentVC?.from = .Timeline
        if let commentVC = commentVC {
            self.navigationController?.pushViewController(commentVC, animated: true)
        }
    }
}

class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.hidden = true
    }
    
    func startAnimating() {
        self.hidden = false
        self.activityIndicatorView.startAnimating()
    }
}

extension TimelineViewController: TimelineItemTableViewCellDelegate {
    func starButtonPressed(goalID: Int) -> Void {
        apiClient.star(goalID) { (successed, likeCount, message) in
            if successed {
                self.apiClient.goalDetail(["goal_id": goalID], completed: { (goal) in
                    for item in self.items {
                        if item.currentGoalSession?.goalId == goalID {
                            item.currentGoalSession?.goal.likeCount = goal.likeCount
                            self.tableView.reloadData()
                        }
                    }
                })
            } else {
                HLKAlertView.show("", message: message, accessoryView: nil, cancelButtonTitle: "OK", otherButtonTitles: nil, handler: nil)
            }
        }

    }
}
