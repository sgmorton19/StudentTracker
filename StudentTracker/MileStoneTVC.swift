//
//  MileStoneTVC.swift
//  StudentTracker
//
//  Created by Admin on 10/24/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class MileStoneTVC: UITableViewController {

    var mileStones:[MileStone]!
    var categories:Int!
    var catArr:[Int]!
    var studentType:StudentType!
    
    @IBAction func addMStapped(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        
        tableView.addGestureRecognizer(longpress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return categories
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArr[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mileStoneCell", forIndexPath: indexPath)

        cell.textLabel?.text = mileStones[getArrPos(indexPath)].name

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category \(section + 1)"
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let temp = mileStones.removeAtIndex(getArrPos(fromIndexPath))
        let index = getArrPos(toIndexPath)
        if index < mileStones.count {
            mileStones.insert(temp, atIndex: index)
        }else{
            mileStones.append(temp)
        }
        catArr[fromIndexPath.section]--
        catArr[toIndexPath.section]++
    }
    
    func getArrPos(path: NSIndexPath) -> Int {
        return getArrPos(path.section, row: path.row)
    }
    
    func getArrPos(section:Int, row:Int) -> Int{
        let sec = section
        var i = 0
        var num = 0
        while (i < sec && i < catArr.count - 1) {
            num += catArr[i]
            i++
        }
        num += row
        return num
    }
    
    func saveCatIndex(){
        var index = 0
        var cat = 0
        var catindex = 0
        for ms in mileStones {
            if catindex == catArr[cat] {
                catindex = 0
                cat++
            }
            ms.orderIndex = index
            ms.category = cat
            index++
            catindex++
        }
        Util.save()
    }
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            self.editing = !self.editing
            saveCatIndex()
        }
    }

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newMileStone" {
            let view = segue.destinationViewController as! NewMileStoneVC
            
            view.parentView = self
            view.studentType = studentType
        }
    }

}
