//
//  MileStone.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class MileStone: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, type: StudentType, name: String, category: Int, orderIndex: Int) -> MileStone {
        var incomplete:NSSet!
        let fetchRequest = NSFetchRequest(entityName: "Student")
        let predicate = NSPredicate(format: "studentType.typeName == %@", type.typeName)
        fetchRequest.predicate = predicate
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [Student]
            if fetchResults?.count > 0 {
                incomplete = Set(fetchResults!)
            }else{
                incomplete = NSSet()
            }
        }catch {
            print("Uh Oh")
            incomplete = NSSet()
        }
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MileStone", inManagedObjectContext: moc) as! MileStone
        newItem.studentType = type
        newItem.name = name
        newItem.category = category
        newItem.orderIndex = orderIndex
        newItem.studentsCompleted = NSSet()
        newItem.studentsIncompleted = incomplete
        
        return newItem
    }
}
