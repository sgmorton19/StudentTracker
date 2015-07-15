//
//  Note.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData

@objc(Note)
class Note: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, note: String, student: Student) -> Note {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! Note
        newItem.note = note
        newItem.student = student
        
        return newItem
    }

}
