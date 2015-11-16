//
//  CategoryColorTVCell.swift
//  StudentTracker
//
//  Created by Admin on 10/31/15.
//  Copyright © 2015 Stephen. All rights reserved.
//

import UIKit

class CategoryColorTVCell: UITableViewCell {
    @IBOutlet weak var aSlider: UISlider!

    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    
    var vc:CategoryColorTVC!
    var index:Int!
    
    
    @IBAction func rSliderChanged(sender: AnyObject) {
        sliderChanged()
        vc.colors[index].red = rSlider.value
    }
    
    @IBAction func gSliderChanged(sender: AnyObject) {
        sliderChanged()
        vc.colors[index].green = gSlider.value
    }
    
    @IBAction func aSliderChanged(sender: AnyObject) {
        sliderChanged()
        vc.colors[index].alpha = aSlider.value
    }
    
    @IBAction func bSliderChanged(sender: AnyObject) {
        sliderChanged()
        vc.colors[index].blue = bSlider.value
    }
    
    func sliderChanged(){
        let color = Util.UIColorFromRGB(rSlider.value, gValue: gSlider.value, bValue: bSlider.value, aValue: aSlider.value)
        catLabel.backgroundColor = color
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
