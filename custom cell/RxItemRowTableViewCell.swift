//
//  RxItemRowTableViewCell.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 02/02/19.
//  Copyright © 2019 rahul sharma. All rights reserved.
//

import UIKit

class RxItemRowTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Qty: CustomTextView!
    @IBOutlet weak var Name_amt: UILabel!
    @IBOutlet weak var amt: CustomTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
