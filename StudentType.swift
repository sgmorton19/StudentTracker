//
//  StudentType.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class StudentType: NSManagedObject {
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, name: String) -> StudentType {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("StudentType", inManagedObjectContext: moc) as! StudentType
        newItem.typeName = name
        newItem.students = NSSet()
        newItem.mileStones = NSSet()
        
        return newItem
    }

}
