//
//  Student.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class Student: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, fName: String, lName: String, type: StudentType) -> Student {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: moc) as! Student
        newItem.firstName = fName
        newItem.lastName = lName
        newItem.notes = NSSet()
        newItem.mileStonesComplete = NSSet()
        
        let fetchRequest = NSFetchRequest(entityName: "MileStone")
        let predicate = NSPredicate(format: "studentType.typeName == %@", type.typeName)
        fetchRequest.predicate = predicate
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as! [MileStone]
            newItem.mileStonesIncomplete = Set(fetchResults)
        }catch
        {
            newItem.mileStonesIncomplete = NSSet()
        }
        newItem.studentType = type
        
        return newItem
    }
    
    func swapComplete(value: MileStone){
        if self.mileStonesComplete.containsObject(value) {
            self.mutableSetValueForKey("mileStonesComplete").removeObject(value)
            self.mutableSetValueForKey("mileStonesIncomplete").addObject(value)
        }
        else{
            self.mutableSetValueForKey("mileStonesIncomplete").removeObject(value)
            self.mutableSetValueForKey("mileStonesComplete").addObject(value)
        }
    }
}
