//
//  IChemist_R.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
public protocol IChemist_R : class {
    
    func setTitle(text : String);
    func setChemist(text : String);
    func remarkEnabled(enabled : Bool);
    func locationEnabled(enabled : Bool);
    func On_Summary_TabClicked();
    func On_Call_TabClicked();
    func addChemist();
    func onChemistDropDown();
    
    func updateCollapseHeader(collapse: [Bool], header: [String],list : [[String : [String : [String]]]]);
    
}
