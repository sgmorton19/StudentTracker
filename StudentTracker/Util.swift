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
        return [("Test 1", 0, 0, type),
            ("Test 2", 0, 1, type),
            ("Test 3", 1, 2, type),
            ("Test 4", 2, 3, type),
            ("Test 5", 2, 4, type)]
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



