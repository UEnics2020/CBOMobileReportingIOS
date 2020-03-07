//
//  tp_reports_row.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 11/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class tp_reports_row: UITableViewCell {

    @IBOutlet weak var tv_tp_workwith: UILabel!
    @IBOutlet weak var tv_tp_date: UILabel!
    @IBOutlet weak var tv_tp_area: UILabel!
    @IBOutlet weak var DA_layout: UIView!
    @IBOutlet weak var tv_tp_remark: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
