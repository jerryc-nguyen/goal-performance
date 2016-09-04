//
//  MyChatsViewController.swift
//  GoalPerformance
//
//  Created by Welcome on 8/29/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class MyChatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [ChatItem]()
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
        tableView.estimatedRowHeight = 60
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
        loadMyChatItems()
    }
    
    func registerNibs() {
        tableView.registerNib(UINib(nibName: "MyChatTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MyChatTableViewCell")
        tableView.registerNib(UINib(nibName: "ChatBuddiesTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "ChatBuddiesTableViewCell")
    }
    
    func pullToRefresh() {
        currentPage = 1
        hasMoreData = true
        loadMyChatItems()
    }
    
    func loadMyChatItems() {
        apiClient.myChats(currentPage) { (items) in
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

extension MyChatsViewController : UITableViewDelegate {
    
}

extension MyChatsViewController: UIScrollViewDelegate {
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
                loadMyChatItems()
            }
        }
    }
}

extension MyChatsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let chatItem = items[indexPath.row]
        
        if let _ = chatItem.goal {
            let cell = tableView.dequeueReusableCellWithIdentifier("ChatBuddiesTableViewCell") as! ChatBuddiesTableViewCell
            cell.myChatItem = chatItem
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyChatTableViewCell") as! MyChatTableViewCell
            
            
            cell.myChatItem = chatItem
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboardManager = StoryboardManager.sharedInstance
        let chatVC = storyboardManager.getViewController("ChatViewController", storyboard: "Chat") as! ChatViewController
        let chatItem = items[indexPath.row]
        
        if let goal = chatItem.goal {
            chatVC.goal = goal
        } else {
            chatVC.receiver = chatItem.actor
        }
        
        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
}
