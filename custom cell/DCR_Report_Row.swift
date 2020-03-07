//
//  DCR_Report_Row.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 18/04/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class DCR_Report_Row: UITableViewCell {

   
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var workStation: UILabel!
    
    @IBOutlet weak var totalDR: CustomeUIButton!
    
    @IBOutlet weak var Dr_Reminder: CustomeUIButton!

    @IBOutlet weak var totalChemist: CustomeUIButton!
    
    @IBOutlet weak var totalStockist: CustomeUIButton!
    
    @IBOutlet weak var nonListedCall: CustomeUIButton!
    
    @IBOutlet weak var DairyBtn: CustomeUIButton!
    
    @IBOutlet weak var PolutaryBtn: CustomeUIButton!
    
    @IBOutlet weak var MissedBtn: CustomeUIButton!
    
    @IBOutlet weak var RxBtn: CustomeUIButton!
    
    

    @IBOutlet weak var DAType: CustomeUIButton!
    
    @IBOutlet weak var remark: UILabel!
    
    
    @IBOutlet weak var DaTypeStackView: UIStackView!
    
    @IBOutlet weak var totalDRStackView: UIStackView!
    
    
    @IBOutlet weak var dr_ReminderStackView: UIStackView!
    
    
    @IBOutlet weak var totalChemistStackView: UIStackView!
    
    @IBOutlet weak var totalStockistStackView: UIStackView!
    
    
    @IBOutlet weak var nonListedCallStackView: UIStackView!
    
    @IBOutlet weak var DairyLayout: UIStackView!
    
    @IBOutlet weak var PolutaryLayout: UIStackView!
    
    
    @IBOutlet weak var MissedLayout: UIStackView!
    
    @IBOutlet weak var RxLayout: UIStackView!
    
    
    
    @IBOutlet weak var DrTxt: UILabel!
    
    @IBOutlet weak var DrRcTxt: UILabel!
    
    @IBOutlet weak var ChemTxt: UILabel!
    
    @IBOutlet weak var StkTxt: UILabel!
    
    @IBOutlet weak var DairyTxt: UILabel!
    
    @IBOutlet weak var PolutaryTxt: UILabel!
    
    @IBOutlet weak var NonListedTxt: UILabel!
    
    @IBOutlet weak var MissedTxt: UILabel!
    
    @IBOutlet weak var TaniviaTxt: UILabel!
    
}
