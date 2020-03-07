//
//  ReminderRow.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class ReminderRow: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Qty: UIButton!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var leftline: UIImageView!
    @IBOutlet weak var rightline: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
