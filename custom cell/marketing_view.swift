//
//  marketing_view.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class marketing_view: UITableViewCell {

    @IBOutlet weak var remark: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var amount_cumm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 40, 0, 10))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
