//
//  MainTableViewController.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MainTableViewController: UITableViewController {
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var studentNames:[Student]!

    @IBAction func addNewStudent(sender: AnyObject) {
        let titlePrompt = UIAlertController(title: "Student Name",
            message: nil,
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "John Smith"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.addStudent(textField.text!)
                    self.save()
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func addStudent(name: String){
        let fullNameArr = split(name.characters){$0 == " "}.map{String($0)}
        var firstname = name
        var lastname = name
        
        if fullNameArr.count > 1 {
            lastname = fullNameArr[1] + ", " + fullNameArr[0]
            firstname = fullNameArr[0] + " " + fullNameArr[1]
        }
        
        studentNames.append(Student.createInManagedObjectContext(moc, fName: firstname, lName: lastname))
        sortReload()
    }
    
    func save() {
        do {
            try self.moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    
    func sortReload(){
        studentNames.sortInPlace( { $0.firstName < $1.firstName})
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        sortReload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Student")
        
        // Create a sort descriptor object that sorts on the "title"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [Student]
            studentNames = fetchResults
        } catch {
            print("Uh Oh")
        }
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
        return studentNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentCell", forIndexPath: indexPath)
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("sortByFirstName") {
            cell.textLabel!.text = studentNames[indexPath.row].firstName
            
        }else{
            cell.textLabel!.text = studentNames[indexPath.row].lastName
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStudent" {
            let view = segue.destinationViewController as! ViewController
            
            let index = tableView.indexPathForSelectedRow!.row
            
            view.navigationItem.title = studentNames[index].firstName
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
