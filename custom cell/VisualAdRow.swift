//
//  VisualAdRow.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 24/02/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class VisualAdRow: UITableViewCell {

    @IBOutlet weak var adName: UILabel!
    @IBOutlet weak var downloaddateTime: UILabel!
    @IBOutlet weak var uploaddateTime: UILabel!
   
    @IBOutlet weak var promoted: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var checkbox: CheckBox!
    @IBOutlet weak var imgwidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
