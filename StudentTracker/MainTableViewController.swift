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

    @IBAction func MenuTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    
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

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            moc.deleteObject(studentNames[indexPath.row])
            studentNames.removeAtIndex(indexPath.row)
            save()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toStudent" {
            let view = segue.destinationViewController as! ViewController
            
            let index = tableView.indexPathForSelectedRow!.row
            
            view.navigationItem.title = studentNames[index].firstName
            let theStudent = studentNames[index]
            view.student = theStudent
            
            let completed = Array(theStudent.mileStonesComplete) as! [MileStone]
            view.completed = completed.sort( { $0.orderIndex.compare($1.orderIndex) == NSComparisonResult.OrderedAscending } )
            
            let incomplete = Array(theStudent.mileStonesIncomplete) as! [MileStone]
            view.incomplete = incomplete.sort( { $0.orderIndex.compare($1.orderIndex) == NSComparisonResult.OrderedAscending } )
            
            let notes = Array(theStudent.notes) as! [Note]
            view.notes = notes.sort( { $0.orderIndex.compare($1.orderIndex) == NSComparisonResult.OrderedDescending } )
            
            
            /*
            //
            //Alternate way to do it without using NSComparisonResult
            //
            
            let x:[Note] = notes.sort( { $0.orderIndex! < $1.orderIndex! } )
            view.notes = x
            
            //
            //Old, Bad way to do it
            //
            
            let fetchRequest = NSFetchRequest(entityName: "MileStone")
            let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                let predicate = NSPredicate(format: "ANY studentsCompleted.firstName == %@", theStudent.firstName)
                fetchRequest.predicate = predicate
                let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [MileStone]
                view.completed = fetchResults
            } catch {
                print("Uh Oh")
            }
            
            do {
                let predicate = NSPredicate(format: "ANY studentsIncompleted.firstName == %@", theStudent.firstName)
                fetchRequest.predicate = predicate
                let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [MileStone]
                view.incomplete = fetchResults
            } catch {
                print("Uh Oh")
            }
            
            let fetchRequest2 = NSFetchRequest(entityName: "Note")
            do {
                let predicate = NSPredicate(format: "ANY student.firstName == %@", theStudent.firstName)
                fetchRequest2.predicate = predicate
                let fetchResults = try moc.executeFetchRequest(fetchRequest2) as? [Note]
                view.notes = fetchResults
            } catch {
                print("Uh Oh")
            }

            */

        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
