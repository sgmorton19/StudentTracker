//
//  SettingsVC.swift
//  StudentTracker
//
//  Created by Admin on 10/30/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortToggle: UISwitch!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBAction func sortToggled(sender: AnyObject) {
        let x = defaults.boolForKey("sortByFirstName")
        defaults.setBool(!x, forKey: "sortByFirstName")
        
        if sortToggle.on {
            sortLabel.text = "Sort By: First Name"
        }else {
            sortLabel.text = "Sort By: Last Name"
        }
    }
    
    @IBAction func menuTapped(sender: AnyObject) {
        toggleSideMenuView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let x = defaults.boolForKey("sortByFirstName")
        if x {
            sortToggle.setOn(true, animated: false)
            sortLabel.text = "Sort By: First Name"
        }else{
            sortToggle.setOn(false, animated: false)
            sortLabel.text = "Sort By: Last Name"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
