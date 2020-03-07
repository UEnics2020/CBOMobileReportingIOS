//
//  RCPACell.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 09/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit

class RCPACell: UITableViewCell {
    
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var remark: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
