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
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MileStone", inManagedObjectContext: moc) as! MileStone
        newItem.studentType = type
        newItem.name = name
        newItem.category = category
        newItem.orderIndex = orderIndex
        newItem.studentsCompleted = NSSet()
        newItem.studentsIncompleted = NSSet()
        
        return newItem
    }
}
