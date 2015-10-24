//
//  StudentTypeTVC.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class StudentTypeTVC: UITableViewController {
    
    var studentTypes:[StudentType]!
    
    @IBAction func menuTapped(sender: AnyObject) {
        toggleSideMenuView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        studentTypes = Util.getAllStudentTypes()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentTypes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("typeCell", forIndexPath: indexPath)

        cell.textLabel!.text = studentTypes[indexPath.row].typeName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            
            
            let titlePrompt = UIAlertController(title: "Warning!",
                message: "Deleting Student Type will delete all Students and Mile Stones that are of that type",
                preferredStyle: .Alert)
            
            titlePrompt.addAction(UIAlertAction(title: "Cancel",
                style: .Default,
            handler: { (action) -> Void in
                //nothing happens
            }))
            
            titlePrompt.addAction(UIAlertAction(title: "Ok",
                style: .Default,
                handler: { (action) -> Void in
                    self.studentTypes.removeAtIndex(indexPath.row)
                    //Util.moc.deleteObject(self.studentTypes[indexPath.row])
                    //Util.save()
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }))
            
            self.presentViewController(titlePrompt,
                animated: true,
                completion: nil)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
