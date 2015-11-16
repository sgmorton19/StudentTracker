//
//  ViewController.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var mileStoneTable: UITableView!
    
    var student:Student!
    var notes:[Note]!
    var completed:[MileStone]!
    var incomplete:[MileStone]!
    
    @IBAction func addNoteButton(sender: AnyObject) {
        
        let titlePrompt = UIAlertController(title: "New Note",
            message: nil,
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.autocapitalizationType = .Sentences
            textField.placeholder = "Type Note Here"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.notes.insert(Note.createInManagedObjectContext(Util.moc, note: textField.text!, student: self.student), atIndex: 0)
                    Util.save()
                    self.notesTable.reloadData()
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == notesTable {
            return notes.count
        }else{
            if section == 0 {
                return incomplete.count
            }else{
                return completed.count
            }
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == mileStoneTable {
            if section == 0 {
                if incomplete.count < 1 {
                    return nil
                }else {
                    return "Incomplete"
                }
            }else{
                if completed.count < 1 {
                    return nil
                }else{
                    return "Completed"
                }
            }
        }
        return nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == notesTable {
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if tableView == notesTable {
            let retval = tableView.dequeueReusableCellWithIdentifier("notesCell") as! NotesTableViewCell
            let testing = notes[indexPath.row].note
            retval.textValue.text = testing
            return retval
        }else{
            let retval = tableView.dequeueReusableCellWithIdentifier("mileStoneCell")!
            if indexPath.section == 0 {
                retval.textLabel?.text = incomplete[indexPath.row].name
                retval.backgroundColor = Util.getColor(incomplete[indexPath.row].category.integerValue)
            }else{
                retval.textLabel?.text = completed[indexPath.row].name
                retval.backgroundColor = Util.getColor(completed[indexPath.row].category.integerValue)
            }
            for view in retval.contentView.subviews
            {
                view.backgroundColor = UIColor.clearColor();
            }
            return retval
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == mileStoneTable{
            if indexPath.section == 0{
                swap(false, index: indexPath.row)
            }else{
                swap(true, index: indexPath.row)
            }
            tableView.reloadData()
        }
    }
    
    func swap(completedBool: Bool, index: Int){
        if completedBool {
            let temp = completed[index]
            completed.removeAtIndex(index)
            incomplete.append(temp)
            student.swapComplete(temp)
            incomplete.sortInPlace( { $0.orderIndex.compare($1.orderIndex) == NSComparisonResult.OrderedAscending } )
        }else{
            let temp = incomplete[index]
            incomplete.removeAtIndex(index)
            completed.append(temp)
            student.swapComplete(temp)
            completed.sortInPlace( { $0.orderIndex.compare($1.orderIndex) == NSComparisonResult.OrderedAscending } )
        }
        Util.save()
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if tableView == notesTable{
            return true
        }
        return false
    }

    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            Util.moc.deleteObject(notes[indexPath.row])
            notes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            Util.save()
        }   //else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            //}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.estimatedRowHeight = 300.0
        notesTable.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        notesTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editNote" {
            let view = segue.destinationViewController as! EditNoteVC
            
            let index = notesTable.indexPathForSelectedRow!.row
            
            view.text = notes[index].note
            view.index = index
            view.parentView = self
        }
    }


}

