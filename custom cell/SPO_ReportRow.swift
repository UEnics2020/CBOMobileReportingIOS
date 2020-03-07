//
//  SPO_ReportRow.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 08/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class SPO_ReportRow: UITableViewCell {

    @IBOutlet weak var consignee: CustomUIButtonWithBoarder!
    @IBOutlet weak var salAmt: UILabel!
    @IBOutlet weak var salReturn: UILabel!
    @IBOutlet weak var breakage_Exp: UILabel!
    @IBOutlet weak var creaditNt_Other: UILabel!
    @IBOutlet weak var netSales: UILabel!
    @IBOutlet weak var secSales: UILabel!
    @IBOutlet weak var recipt: UILabel!
    @IBOutlet weak var outStnding: UILabel!
    @IBOutlet weak var stkAmt: CustomUIButtonWithBoarder!
   
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 5, 0, 5))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
