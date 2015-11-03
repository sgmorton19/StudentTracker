//
//  Colors.swift
//  StudentTracker
//
//  Created by Admin on 10/17/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct Util {
    
    static func UIColorFromRGB(rValue: Float, gValue: Float, bValue: Float) -> UIColor {
        return UIColor(
            red: CGFloat(rValue) / 255.0,
            green: CGFloat(gValue) / 255.0,
            blue: CGFloat(bValue) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func getColor(val: Int) -> UIColor{
        let colors = getAllColors()
        if val < colors.count {
            return UIColorFromRGB(colors[val].red.floatValue, gValue: colors[val].green.floatValue, bValue: colors[val].blue.floatValue)
        }else{
            return UIColorFromRGB(255, gValue: 255, bValue: 255)
        }
    }
    
    static func getAllColors() -> [Color]{
        let fetchRequest = NSFetchRequest(entityName: "Color")
        
        let sortDescriptor = NSSortDescriptor(key: "orderIndex", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as! [Color]
            let colors = fetchResults
            return colors
        } catch {
            print("Uh Oh")
        }
        return [Color]()
    }
    
    static let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    static func save() {
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    static func getAllStudentTypes() -> [StudentType]? {
        let fetchRequest = NSFetchRequest(entityName: "StudentType")
        let sortDescriptor = NSSortDescriptor(key: "typeName", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let fetchResults = try moc.executeFetchRequest(fetchRequest) as! [StudentType]
            let studentTypes = fetchResults
            return studentTypes
        } catch {
            print("Uh Oh")
        }
        
        return nil
    }
    
    static func createDefaultMileStones(type: StudentType) -> [(String, Int, Int, StudentType)]{
        return [("Test 1", 0, 0, type),
            ("Test 2", 0, 1, type),
            ("Test 3", 1, 2, type),
            ("Test 4", 2, 3, type),
            ("Test 5", 2, 4, type)]
    }
}