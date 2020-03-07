//
//  DashboardTableViewCell.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class DoctorWiseRow: UITableViewCell {

    @IBOutlet weak var reamrk: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var amount_cumm: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 40, 0, 10))
    }
    
    //8920945262
    
}
