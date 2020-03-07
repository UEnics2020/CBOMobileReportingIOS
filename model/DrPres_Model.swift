//
//  DrPres_Model.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 01/02/19.
//  Copyright © 2019 rahul sharma. All rights reserved.
//

import UIKit
public class DrPres_Model {
    
    var id : String = ""
    var name : String = ""
    var qty  : String = ""
    var amt  : String = ""
    var name_amt : String = ""
    
    
    
    init ( name : String,  id : String, name_amt : String) {
        self.name = name;
        self.id = id;
        self.name_amt = name_amt;
    
    }
    
    func getId() -> String {
        return id;
    }
    
    func  setId( id  : String){
        self.id = id;
    }
    
    func getName()  -> String{
        return name;
    }
    
    func setName( name : String) {
        self.name = name;
    }
    
    func getQty()  -> String{
        return qty;
    }
    
    func setQty( qty : String) {
        self.qty = qty;
    }
    
    func getName_amt()  -> String{
        return name_amt;
    }
    
    func setName_amt( name_amt : String) {
        self.name_amt = name_amt;
    }
    
    func getamt()  -> String{
        return amt;
    }
    
    func setamt( amt : String) {
        self.amt = amt;
    }
}
