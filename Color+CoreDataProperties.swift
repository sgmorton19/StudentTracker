//
//  Color+CoreDataProperties.swift
//  StudentTracker
//
//  Created by Admin on 11/3/15.
//  Copyright © 2015 Stephen. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Color {

    @NSManaged var alpha: NSNumber
    @NSManaged var red: NSNumber
    @NSManaged var green: NSNumber
    @NSManaged var blue: NSNumber
    @NSManaged var orderIndex: NSNumber
}
