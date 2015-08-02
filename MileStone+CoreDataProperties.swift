//
//  MileStone+CoreDataProperties.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension MileStone {

    @NSManaged var category: NSNumber
    @NSManaged var name: String
    @NSManaged var orderIndex: NSNumber
    @NSManaged var studentsCompleted: NSSet
    @NSManaged var studentsIncompleted: NSSet

}
