
//
//  ExpandableInnerCell.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 19/02/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class ExpandableInnerCell: UITableViewCell {

    @IBOutlet weak var workWithDetailsView: UIView!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var name : UILabel?
    
    @IBOutlet weak var calltime: UILabel!
    
    var collaps : Bool = true
    
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var myStackView: UIView!
    
    @IBOutlet weak var detailsP_View: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var watch: UIImageView!
    
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    

    @IBOutlet weak var remarkContraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomLineWorkWithDetailsView: CustomBoarder!
    
    @IBOutlet weak var topLineWorkWithDetailsView: CustomBoarder!
    
    
    @IBOutlet weak var remarkLabel: UILabel!
    
    @IBOutlet weak var bottomLineDetailsView: CustomBoarder!
    @IBOutlet weak var topLineDetailsView: CustomBoarder!
    
    
    
}
