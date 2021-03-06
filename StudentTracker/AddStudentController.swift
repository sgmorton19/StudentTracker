//
//  AddStudent.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit
import CoreData

class AddStudentController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet var swiped: UISwipeGestureRecognizer!
    
    var studentTypes:[StudentType]!
    var currentType:Int!
    var parentView:MainTableViewController!
    
    
    func swiped(sender: UISwipeGestureRecognizer!){
        if sender.direction == UISwipeGestureRecognizerDirection.Left{
            if currentType != studentTypes.count - 1 {
                currentType = currentType + 1
                typeLabel.slideInFromRight(Util.slideAnimationSpeed, completionDelegate: nil)
                typeLabel.text = studentTypes[currentType].typeName
                if currentType == studentTypes.count - 1 {
                    nextButton.enabled = false
                }
            }
            prevButton.enabled = true
            
        }else if sender.direction == UISwipeGestureRecognizerDirection.Right{
            if currentType != 0 {
                currentType = currentType - 1
                typeLabel.slideInFromLeft(Util.slideAnimationSpeed, completionDelegate: nil)
                typeLabel.text = studentTypes[currentType].typeName
                if currentType == 0 {
                    prevButton.enabled = false
                }
            }
            nextButton.enabled = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        doSave()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipedLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipedLeft.direction = UISwipeGestureRecognizerDirection.Left
        let swipedRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipedRight.direction = UISwipeGestureRecognizerDirection.Right
        swipeView.addGestureRecognizer(swipedLeft)
        swipeView.addGestureRecognizer(swipedRight)
        swipeView.userInteractionEnabled = true
        nameTextField.autocapitalizationType = .Words
        
        studentTypes = Util.getAllStudentTypes()!
        
        typeLabel.text = studentTypes[0].typeName
        currentType = 0
        prevButton.enabled = false
        if currentType == studentTypes.count - 1 {
            nextButton.enabled = false
        }
        nameTextField.becomeFirstResponder()
        
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        currentType = currentType + 1
        if currentType == studentTypes.count - 1 {
            nextButton.enabled = false
        }
        prevButton.enabled = true
        
        typeLabel.slideInFromRight(Util.slideAnimationSpeed, completionDelegate: nil)
        typeLabel.text = studentTypes[currentType].typeName
        
    }

    @IBAction func prevButton(sender: AnyObject) {
        currentType = currentType - 1
        if currentType == 0 {
            prevButton.enabled = false
        }
        nextButton.enabled = true
        
        typeLabel.slideInFromLeft(Util.slideAnimationSpeed, completionDelegate: nil)
        typeLabel.text = studentTypes[currentType].typeName
        
    }
    
    @IBAction func addTypeTapped(sender: AnyObject) {
        let titlePrompt = UIAlertController(title: "Student Type",
            message: nil,
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Student Type Description"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.addStudentType(textField.text!)
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func addStudentType(name:String){
        self.studentTypes.append(StudentType.createInManagedObjectContext(Util.moc, name: name))
        let val = self.studentTypes.count - 1
        typeLabel.text = studentTypes[val].typeName
        currentType = val
        nextButton.enabled = false
        prevButton.enabled = true
        Util.save()
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        doSave()
    }
    
    func doSave(){
        if nameTextField.text! != "" {
            addStudent(nameTextField.text!)
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func addStudent(name: String){
        let fullNameArr = name.characters.split{$0 == " "}.map{String($0)}
        var firstname = name
        var lastname = name
        
        if fullNameArr.count > 1 {
            lastname = fullNameArr[1] + ", " + fullNameArr[0]
            firstname = fullNameArr[0] + " " + fullNameArr[1]
        } else if fullNameArr.count == 1 {
            firstname = fullNameArr[0]
            lastname = fullNameArr[0]
        }
        
        parentView.studentNames.append(Student.createInManagedObjectContext(Util.moc, fName: firstname, lName: lastname, type: studentTypes[currentType]))
        Util.save()
    }
}
