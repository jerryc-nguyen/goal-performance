//
//  FriendViewController.swift
//  GoalPerformance
//
//  Created by Lam Tran on 8/14/16.
//  Copyright © 2016 Group 7. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var viewSegment: UISegmentedControl!
    
    @IBOutlet weak var friendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
