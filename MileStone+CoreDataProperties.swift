//
//  MileStone+CoreDataProperties.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
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
    @NSManaged var studentType: StudentType

}
