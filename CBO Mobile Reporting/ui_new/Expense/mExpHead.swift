//
//  mExpHead.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/05/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
public class mExpHead {
    private var Id = 0;
    private var Name = "";
    private var MANDATORY = 0;
    private var DA_ACTION = 0;
    private var EXP_TYPE_STR = "0";
    private var EXP_TYPE : eExpanse = eExpanse.None;
    private var ATTACHYN = 0;
    private var MAX_AMT : Double = 0;
    private var MasterValidate = 0;
    private var RATE : Double = 0;
    private var SHOW_IN_TA_DA : eExpanse = eExpanse.None;
    private var KMYN = "0";
    private var HEADTYPE_GROUP = "0";
    
    public init( id : Int,  name : String) {
        Id = id;
        Name = name;
    }
    
    /// getter
    
    public func getId() -> Int {
        return Id;
    }
    
    public func getName() -> String{
        return Name;
    }
    
    public func getMANDATORY() -> Int {
        return MANDATORY;
    }
    
    public func getDA_ACTION() -> Int {
        return DA_ACTION;
    }
    
    public func getEXP_TYPE_STR() -> String {
        return EXP_TYPE_STR;
    }
    
    public func getEXP_TYPE() -> eExpanse {
        return EXP_TYPE;
    }
    
    public func getATTACHYN() -> Int {
        return ATTACHYN;
    }
    
    public func getMAX_AMT() ->  Double {
        return MAX_AMT;
    }
    
    public func getMasterValidate() -> Int{
        return MasterValidate;
    }
    
    
    public func getRATE() -> Double {
        return RATE;
    }
    
    public func getSHOW_IN_TA_DA() -> eExpanse {
        return SHOW_IN_TA_DA;
    }
    
    public func getKMYN() -> String {
        return KMYN;
    }
    
    public func getHEADTYPE_GROUP() -> String{
        return HEADTYPE_GROUP;
    }
    /// setter
    
    
    
    public func setMANDATORY(MANDATORY : Int) -> mExpHead{
        self.MANDATORY = MANDATORY;
        return self;
    }
    
    public func setDA_ACTION(DA_ACTION : Int) -> mExpHead {
        self.DA_ACTION = DA_ACTION;
        return self;
    }
    
    public func setEXP_TYPE(EXP_TYPE : eExpanse ) -> mExpHead{
        self.EXP_TYPE = EXP_TYPE;
        return self;
    }
    
    public func setEXP_TYPE_STR(EXP_TYPE_STR : String ) -> mExpHead{
        self.EXP_TYPE_STR = EXP_TYPE_STR;
        return self;
    }
    
    public func setATTACHYN(ATTACHYN : Int) -> mExpHead{
        self.ATTACHYN = ATTACHYN;
        return self;
    }
    
    public func setMAX_AMT( MAX_AMT : Double) -> mExpHead{
        self.MAX_AMT = MAX_AMT;
        return self;
    }
    
    public func setMasterValidate( masterValidate : Int) -> mExpHead{
        MasterValidate = masterValidate;
        return self;
    }
    
    public func setRATE(RATE : Double)-> mExpHead {
        self.RATE = RATE;
        return self;
    }
    
    public func setSHOW_IN_TA_DA( SHOW_IN_TA_DA : eExpanse) -> mExpHead{
        self.SHOW_IN_TA_DA = SHOW_IN_TA_DA;
        return self;
    }
    
    public func setKMYN( KMYN : String)-> mExpHead {
        self.KMYN = KMYN;
        return self;
    }
    
    public func setHEADTYPE_GROUP( HEADTYPE_GROUP : String)-> mExpHead {
        self.HEADTYPE_GROUP = HEADTYPE_GROUP;
        return self;
    }
}
