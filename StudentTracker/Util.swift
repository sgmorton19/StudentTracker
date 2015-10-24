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

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

struct Util {
    static let Colors = [
    UIColorFromRGB(0xFFFFFF),
    UIColorFromRGB(0xFFB266),
    UIColorFromRGB(0xB2FF66),
    UIColorFromRGB(0x66FFFF),
    UIColorFromRGB(0xB266FF),
    UIColorFromRGB(0xFF66B2),
    ]
    
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
}