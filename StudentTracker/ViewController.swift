//
//  ViewController.swift
//  StudentTracker
//
//  Created by Admin on 7/10/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var mileStoneTable: UITableView!
    
    var student:Student!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == notesTable {
            return student.notes.count
        }else{
            //todo
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return UITableViewCell()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

