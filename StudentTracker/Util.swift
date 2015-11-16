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
    
    static func UIColorFromRGB(rValue: Float, gValue: Float, bValue: Float, aValue: Float) -> UIColor {
        return UIColor(
            red: CGFloat(rValue) / 255.0,
            green: CGFloat(gValue) / 255.0,
            blue: CGFloat(bValue) / 255.0,
            alpha: CGFloat(aValue) / 255.0
        )
    }
    
    static func getColor(val: Int) -> UIColor{
        let colors = getAllColors()
        if val < colors.count {
            return UIColorFromRGB(colors[val].red.floatValue, gValue: colors[val].green.floatValue, bValue: colors[val].blue.floatValue, aValue: colors[val].alpha.floatValue)
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
    static let slideAnimationSpeed = 0.5
    
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
        return [("Written Exam", 0, 0, type),
            ("3rd Class Medical", 0, 1, type),
            ("Driver's Lisence", 0, 2, type),
            ("Passport or Birth Certificate", 0, 3, type),
            ("4 Fundamentals", 1, 4, type),
            ("Rectangular Course", 1, 5, type),
            ("S Turns", 1, 6, type),
            ("Turns about a Point", 1, 7, type),
            ("Power Off Stall Clean", 1, 8, type),
            ("Power Off Stall Dirty", 1, 9, type),
            ("Approach to Landing Stall", 1, 10, type),
            ("Power on Stall Clean", 1, 11, type),
            ("Departure Stall", 1, 12, type),
            ("Slow Flight Clean", 1, 13, type),
            ("Slow Flight Dirty", 1, 14, type),
            ("Steep Turns", 1, 15, type),
            ("Go Around", 1, 16, type),
            ("Emergency Landing", 1, 17, type),
            ("Slips to a Landing", 1, 18, type),
            ("First Solo!", 1, 19, type),
            ("3 Solo's in Pattern", 1, 20, type),
            ("Solo in Practice Area", 2, 21, type),
            ("Controlled Airspace", 2, 22, type),
            ("Controlled Airspace Solo", 2, 23, type),
            ("Dual XC", 2, 24, type),
            ("Dual Night XC", 2, 25, type),
            ("Short Field Landing", 2, 26, type),
            ("Soft Field Landing", 2, 27, type),
            ("Simulated Instrument: 4 Fundamentals", 2, 28, type),
            ("Solo XCs", 3, 29, type),
            ("Oral Exam Prep", 3, 30, type),
            ("Simulated Instrument: Unusual Atitudes", 3, 31, type),
            ("3 Hours Dual XC", 4, 32, type),
            ("3 Hours Dual Night", 4, 33, type),
            ("Dual Night XC 100nm", 4, 34, type),
            ("Dual 10 Night Landings", 4, 35, type),
            ("3 Hours Simulated Instrument", 4, 36, type),
            ("10 Hours Solo", 5, 37, type),
            ("5 Hours Solo XC", 5, 38, type),
            ("Solo XC 150nm", 5, 39, type),
            ("3 Solo Controlled Airspace Landings", 5, 40, type),
            ("Checkride!", 6, 41, type)]
    }
    
    static func createDefaultColors() -> [(Float, Float, Float, Float)] {
        return [(255, 255, 255, 0),
                (255, 0, 0, 128),
                (0, 255, 0, 128),
                (0, 0, 255, 128),
                (255, 255, 0, 128),
                (0, 255, 255, 128),
                (128, 128, 128, 128)]
    }
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    
    func slideInFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromRightTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromRightTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromRightTransition.type = kCATransitionPush
        slideInFromRightTransition.subtype = kCATransitionFromRight
        slideInFromRightTransition.duration = duration
        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromRightTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.addAnimation(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
}



