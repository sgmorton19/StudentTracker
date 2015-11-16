//
//  StudentTypeTVC.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit
import CoreData

class StudentTypeTVC: UITableViewController {
    
    var studentTypes:[StudentType]!
    
    @IBAction func menuTapped(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    @IBAction func addTypeTapped(sender: AnyObject) {
        let titlePrompt = UIAlertController(title: "Student Type",
            message: nil,
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.autocapitalizationType = .Words
            textField.placeholder = "Student Type Description"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.addStudentType(textField.text!)
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func addStudentType(name:String){
        studentTypes.append(StudentType.createInManagedObjectContext(Util.moc, name: name))
        Util.save()
        tableView.reloadData()
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
            
            let titlePrompt = UIAlertController(title: "Warning!",
                message: "Deleting Student Type will delete all Students and Mile Stones that are of that type.",
                preferredStyle: .Alert)
            
            titlePrompt.addAction(UIAlertAction(title: "Cancel",
                style: .Default,
            handler: { (action) -> Void in
                tableView.editing = false
            }))
            
            titlePrompt.addAction(UIAlertAction(title: "Ok",
                style: .Default,
                handler: { (action) -> Void in
                    Util.moc.deleteObject(self.studentTypes[indexPath.row])
                    Util.save()
                    self.studentTypes.removeAtIndex(indexPath.row)
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

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toMileStones" {
            let view = segue.destinationViewController as! MileStoneTVC
            
            let index = tableView.indexPathForSelectedRow!.row
            
            view.studentType = studentTypes[index]
            
            let fetchRequest = NSFetchRequest(entityName: "MileStone")
            let predicate = NSPredicate(format: "studentType.typeName == %@", studentTypes[index].typeName)
            let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.predicate = predicate
            do {
                let fetchResults = try Util.moc.executeFetchRequest(fetchRequest) as! [MileStone]
                view.mileStones = fetchResults
                
                var i = 0
                var temp = 0
                var catArray = [Int]()
                for val in fetchResults {
                    if val.category.integerValue != i {
                        catArray.append(temp)
                        temp = 1
                        i++
                    }else{
                        temp++
                    }
                }
                catArray.append(temp)
                view.catArr = catArray
                view.categories = i + 1
                
            }catch{
                print("Uh Oh")
            }
        }
    }
    
    
    @IBAction func saveMileStone(segue:UIStoryboardSegue) {
        print("hi")
        let vc = segue.sourceViewController as! MileStoneTVC
        vc.saveCatIndex()
    }
    

}
