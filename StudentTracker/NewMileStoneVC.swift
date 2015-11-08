//
//  NewMileStoneVC.swift
//  StudentTracker
//
//  Created by Admin on 10/25/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class NewMileStoneVC: UIViewController {
    
    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var catSlider: UISlider!
    @IBOutlet weak var mileStoneTextField: UITextField!
    
    var studentType:StudentType!
    var parentView:MileStoneTVC!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catSlider.minimumValue = 0
        catSlider.maximumValue = Float(parentView.catArr.count)
        catSlider.value = 0
        catLabel.backgroundColor = Util.getColor(0)
        mileStoneTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        if mileStoneTextField.text != "" {
            let slideVal = Int(catSlider.value)
            let newMS = MileStone.createInManagedObjectContext(Util.moc, type: studentType, name: mileStoneTextField.text!, category: slideVal, orderIndex: 0)
            Util.save()
            
            let cat = parentView.catArr.count
            if cat == Int(catSlider.value){
                parentView.catArr.append(0)
                parentView.categories = cat + 1
            }
            let insertPos = parentView.getArrPos(slideVal, row: parentView.catArr[slideVal])
            parentView.mileStones.insert(newMS, atIndex: insertPos)
            parentView.catArr[slideVal]++
            parentView.saveCatIndex()
            parentView.tableView.reloadData()
            navigationController?.popViewControllerAnimated(true)
        }
    }

    @IBAction func sliderMoved(sender: UISlider) {
        sender.setValue(Float(lroundf(catSlider.value)), animated: true)
        catLabel.text = "\(Int(catSlider.value) + 1)"
        catLabel.backgroundColor = Util.getColor(Int(catSlider.value))
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
