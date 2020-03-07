//
//  Lead_Dialog.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 06/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//


import UIKit
import Foundation
class Lead_Dialog{
    
    let vc : CustomUIViewController!
    let dr_List : [SpinnerModel]
    let responseCode : Int!
    var lead_names="";
    var lead_names_previous="";
    
    init(vc : CustomUIViewController ,  dr_List : [SpinnerModel]  , responseCode : Int ,  lead_names : String  ) {
        self.vc = vc
        self.dr_List = dr_List
        self.responseCode = responseCode
        self.lead_names = lead_names
    }
    
    
    func setPrevious(lead_names_previous : String )-> Lead_Dialog {
        self.lead_names_previous = lead_names_previous
        return self
    }
    
    
    func show(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "LeadController") as! LeadController
       
        myviewcontroller.VCIntent["sample_name"] = lead_names
        myviewcontroller.VCIntent["sample_name_previous"] = lead_names_previous
        myviewcontroller.vc = vc
        myviewcontroller.dr_List = dr_List
        myviewcontroller.responseCode = responseCode
        vc.present(myviewcontroller, animated: true, completion:  nil)
    }
    
    
}

