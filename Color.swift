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
        let index = getIndex()
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Color", inManagedObjectContext: moc) as! Color
        newItem.alpha = 1
        newItem.red = r
        newItem.blue = b
        newItem.green = g
        newItem.orderIndex = index
        return newItem
    }
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, r: Float, g: Float, b: Float, a: Float) -> Color {
        let index = getIndex()
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Color", inManagedObjectContext: moc) as! Color
        newItem.alpha = a
        newItem.red = r
        newItem.blue = b
        newItem.green = g
        newItem.orderIndex = index
        return newItem
    }
    
    class func getIndex() -> Int {
        var theOrder = 0
        let fetchRequest = NSFetchRequest(entityName: "Color")
        let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let fetchResults = try Util.moc.executeFetchRequest(fetchRequest) as? [Color]
            if let val = fetchResults {
                if val.count > 0{
                    theOrder = val[0].orderIndex.integerValue + 1
                }
            }
        }catch {
            print("Uh Oh")
        }
        return theOrder
    }

}
