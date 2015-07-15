//
//  Student.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData

@objc(Student)
class Student: NSManagedObject {
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, fName: String, lName: String) -> Student {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: moc) as! Student
        newItem.firstName = fName
        newItem.lastName = lName
        newItem.notes = NSSet()
        newItem.mileStonesComplete = NSSet()
        newItem.mileStonesIncomplete = NSSet()
        
        return newItem
    }

}
