//
//  mDA.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 13/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

public class mDA {

    private var Id = 0;
    private var Name = "--Select--";
    private var Code = "";
    private var multipleFactor  : Double  = 1;
    private var DAAmount : Double = 0;
    private var TA_Rate  : Double = 0;
    private var TA_Km  : Double = 0;
    private var TAAmount  : Double = 0;
    private var MANUAL_DISTANCEYN = "";
    private var MANUAL_TAYN = "";
    private var MANUAL_TAYN_MANDATORY = "";
    
    //getter
    
    
    public func getId() -> Int {
        return Id;
    }
    
    public func getName()  -> String {
        return Name;
    }
    
    public func getCode()  -> String {
        return Code;
    }
    
    public func getMultipleFactor() -> Double  {
        return multipleFactor;
    }
    
    public func getDAAmount()  -> Double {
        return DAAmount;
    }
    
    public func getTA_Rate() -> Double  {
        return TA_Rate;
    }
    
    public func getTA_Km()  -> Double {
        return TA_Km;
    }
    
    public func getTAAmount() -> Double {
        return TAAmount;
    }
    
    public func getMANUAL_DISTANCEYN() -> String {
        return MANUAL_DISTANCEYN;
    }
    
    public func getMANUAL_TAYN()  -> String {
        return MANUAL_TAYN;
    }
    
    public func getMANUAL_TAYN_MANDATORY()  -> String {
        return MANUAL_TAYN_MANDATORY;
    }
    
    //setter
    
    
    public func setId( id : Int)-> mDA {
        Id = id;
        return self;
    }
    
    public func setName( name : String) -> mDA{
        Name = name;
        return self;
    }
    
    public func setCode( code : String)-> mDA {
        Code = code;
        return self;
    }
    
    public func setMultipleFactor( multipleFactor : Double) -> mDA{
        self.multipleFactor = multipleFactor;
        return self;
    }
    
    public func setDAAmount( DAAmount : Double)-> mDA {
        self.DAAmount = DAAmount;
        return self;
    }
    
    public func setTA_Rate(TA_Rate : Double)-> mDA {
        self.TA_Rate = TA_Rate;
        setTAAmount(TAAmount: CalculateTA());
        return self;
    }
    
    public func setTA_Km( TA_Km : Double) -> mDA{
        self.TA_Km = TA_Km * getMultipleFactor();
        setTAAmount(TAAmount: CalculateTA());
        return self;
    }
    
    public func CalculateTA() -> Double{
        return getTA_Km() * getTA_Rate();
    }
    
    public func setTAAmount( TAAmount : Double) -> mDA{
        self.TAAmount = TAAmount;
        return self;
    }
    
    public func setMANUAL_DISTANCEYN( MANUAL_DISTANCEYN : String) -> mDA{
        self.MANUAL_DISTANCEYN = MANUAL_DISTANCEYN;
        return self;
    }
    
    public func setMANUAL_TAYN( MANUAL_TAYN : String) -> mDA{
        self.MANUAL_TAYN = MANUAL_TAYN;
        return self;
    }
    
    public func setMANUAL_TAYN_MANDATORY( MANUAL_TAYN_MANDATORY : String) -> mDA {
        self.MANUAL_TAYN_MANDATORY = MANUAL_TAYN_MANDATORY;
        return self;
    }
}
