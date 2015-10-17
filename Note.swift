//
//  Note.swift
//  StudentTracker
//
//  Created by Admin on 10/13/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class Note: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, note: String, student: Student) -> Note {
        var theOrder = 0
        let fetchRequest = NSFetchRequest(entityName: "Note")
        let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let predicate = NSPredicate(format: "ANY student.firstName == %@", student.firstName)
            fetchRequest.predicate = predicate
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [Note]
            if let val = fetchResults {
                if val.count > 0{
                    theOrder = val[0].orderIndex.integerValue + 1
                }
            }
        }catch {
            print("Uh Oh")
        }
        
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: moc) as! Note
        newItem.note = note
        newItem.student = student
        newItem.orderIndex = theOrder
        
        return newItem
    }

}
