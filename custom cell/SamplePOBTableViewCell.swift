//
//  SamplePOBTableViewCell.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 12/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class SamplePOBTableViewCell: UITableViewCell {

    @IBOutlet weak var Name_txt: UILabel!
    @IBOutlet weak var Promoted: CheckBox!
    @IBOutlet weak var Sample_txt: CustomTextView!
    @IBOutlet weak var POB_txt: CustomTextView!
    @IBOutlet weak var NOC_txt: CustomTextView!
    @IBOutlet weak var Pescribed: CheckBox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
