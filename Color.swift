//
//  Color.swift
//  StudentTracker
//
//  Created by Admin on 11/3/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import CoreData


class Color: NSManagedObject {

    class func createInManagedObjectContext(moc: NSManagedObjectContext, r: Float, g: Float, b: Float) -> Color {
        var theOrder = 0
        let fetchRequest = NSFetchRequest(entityName: "Color")
        let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as? [Color]
            if let val = fetchResults {
                if val.count > 0{
                    theOrder = val[0].orderIndex.integerValue + 1
                }
            }
        }catch {
            print("Uh Oh")
        }

        
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Color", inManagedObjectContext: moc) as! Color
        newItem.alpha = 1
        newItem.red = r
        newItem.blue = b
        newItem.green = g
        newItem.orderIndex = theOrder
        return newItem
    }

}
