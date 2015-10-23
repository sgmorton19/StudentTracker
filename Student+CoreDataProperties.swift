//
//  Student+CoreDataProperties.swift
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

extension Student {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var mileStonesComplete: NSSet
    @NSManaged var mileStonesIncomplete: NSSet
    @NSManaged var notes: NSSet
    @NSManaged var studentType: StudentType

}
