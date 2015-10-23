//
//  SideMenuNavigation Controller.swift
//  StudentTracker
//
//  Created by Admin on 10/23/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class SideMenuNavigation_Controller: ENSideMenuNavigationController {
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let menu = storyboard.instantiateViewControllerWithIdentifier("SideMenuTableVC") as! SideMenuTableVC
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menu, menuPosition: ENSideMenuPosition.Left)
        sideMenu?.menuWidth = 180
        view.bringSubviewToFront(navigationBar)
    }
    
    
    
}
