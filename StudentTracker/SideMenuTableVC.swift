//
//  SideMenuTableVC.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class SideMenuTableVC: UITableViewController {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var destinationVC:UITableViewController!
        
        if indexPath.row == 1 {
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("StudentTypeTVC") as! StudentTypeTVC
        } else {
            destinationVC = storyboard.instantiateViewControllerWithIdentifier("MainTableViewController") as! MainTableViewController
        }
        
        sideMenuController()?.setContentViewController(destinationVC)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
