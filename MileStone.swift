//
//  MileStone.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class MileStone: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String, category: Int, orderIndex: Int) -> MileStone {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("MileStone", inManagedObjectContext: moc) as! MileStone
        newItem.name = name
        newItem.category = category
        newItem.orderIndex = orderIndex
        newItem.studentsCompleted = NSSet()
        newItem.studentsIncompleted = NSSet()
        
        return newItem
    }

}
