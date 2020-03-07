//
//  ReportingModel.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation

public class ReportingModel {
    
    private var ID = "0";
    private var PARICULARS = "";
    private var ADD_VALUE = "0";
    private var ADD_URL = "";
    private var EDIT_VALUE = "0";
    private var EDIT_URL = "";
    private var DELETE_VALUE = "0";
    private var DELETE_URL = "";
    
    func  getId() -> String{
        return ID;
    }
    
    func  setId( id : String) {
        self.ID = id;
    }
    
    
    func  getPARICULARS() -> String{
        return PARICULARS;
    }
    
    func  setPARICULARS( PARICULARS : String) {
        self.PARICULARS = PARICULARS;
    }
    

    func  getADD_VALUE() -> String{
        return ADD_VALUE;
    }
    
    func  setADD_VALUE( ADD_VALUE : String) {
        self.ADD_VALUE = ADD_VALUE;
    }
    
    func  getADD_URL() -> String{
        return ADD_URL;
    }
    
    func  setADD_URL( ADD_URL : String) {
        self.ADD_URL = ADD_URL;
    }
   
    func  getEDIT_VALUE() -> String{
        return EDIT_VALUE;
    }
    
    func  setEDIT_VALUE( EDIT_VALUE : String) {
        self.EDIT_VALUE = EDIT_VALUE;
    }
   

    func  getEDIT_URL() -> String{
        return EDIT_URL;
    }
    
    func  setEDIT_URL( EDIT_URL : String) {
        self.EDIT_URL = EDIT_URL;
    }

    
    func  getDELETE_VALUE() -> String{
        return DELETE_VALUE;
    }
    
    func  setDELETE_VALUE( DELETE_VALUE : String) {
        self.DELETE_VALUE = DELETE_VALUE;
    }
    
    
    func  getDELETE_URL() -> String{
           return DELETE_URL;
       }
       
       func  setDELETE_URL( DELETE_URL : String) {
           self.DELETE_URL = DELETE_URL;
       }
    
   
   

}
