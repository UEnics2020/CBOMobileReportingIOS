//
//  mDistance.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 13/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//
import UIKit
public class mDistance {
    private var Id = "";
    private var Name = "--Select--";
    private var Km : Double = 0;
    private var MANUAL_TAYN = "";
    private var MANUAL_TAYN_MANDATORY = "";
    
    
    //getter
    
    
    public func getId() -> String {
        return Id;
    }
    
    public func getName() -> String {
        return Name;
    }
    
    public func getKm() -> Double {
        return Km;
    }
    
    public func getMANUAL_TAYN() -> String {
        return MANUAL_TAYN;
    }
    
    public func getMANUAL_TAYN_MANDATORY() -> String {
        return MANUAL_TAYN_MANDATORY;
    }
    
    //setter
    
    public func setId( id : String) -> mDistance {
        Id = id;
        return self;
    }
    
    public func setName( name: String) -> mDistance {
        Name = name;
        return self;
    }
    
    public func setKm( km : Double) -> mDistance {
        Km = km;
        return self;
    }
    
    public func setMANUAL_TAYN( MANUAL_TAYN : String)-> mDistance  {
        self.MANUAL_TAYN = MANUAL_TAYN;
        return self;
    }
    
    public func setMANUAL_TAYN_MANDATORY( MANUAL_TAYN_MANDATORY: String)-> mDistance  {
        self.MANUAL_TAYN_MANDATORY = MANUAL_TAYN_MANDATORY;
        return self;
    }
}
