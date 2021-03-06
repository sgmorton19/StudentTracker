//
//  CategoryColorTVC.swift
//  StudentTracker
//
//  Created by Admin on 10/31/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class CategoryColorTVC: UITableViewController {

    var colors:[Color]!
    
    
    @IBAction func addTapped(sender: AnyObject) {
        colors.append(Color.createInManagedObjectContext(Util.moc, r: 255, g: 255, b: 255))
        Util.save()
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colors = Util.getAllColors()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return colors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("catColorCell", forIndexPath: indexPath) as! CategoryColorTVCell
        
        
        cell.rSlider.value = colors[indexPath.row].red.floatValue
        cell.gSlider.value = colors[indexPath.row].green.floatValue
        cell.bSlider.value = colors[indexPath.row].blue.floatValue
        cell.aSlider.value = colors[indexPath.row].alpha.floatValue
        cell.catLabel.text = "Category \(indexPath.row + 1)"
        cell.index = indexPath.row
        cell.vc = self
        cell.sliderChanged()
        

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
            Util.moc.deleteObject(colors.removeAtIndex(indexPath.row))
            tableView.reloadData()
            Util.save()
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
