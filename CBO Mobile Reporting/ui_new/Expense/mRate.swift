//
//  mRate.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 13/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
public class mRate {
    private var rate : Double = 0;
    private var FKm  : Double = 0;
    private var TKm  : Double = 99999;
    
    
    //getter
    
    public func getRate() -> Double{
        return rate;
    }
    
    public func getFKm()-> Double {
        return FKm;
    }
    
    public func getTKm()-> Double {
        return TKm;
    }
    
    //setter
    
    public func setRate( rate: Double)-> mRate {
        self.rate = rate;
        return self;
    }
    
    public func setFKm( FKm: Double) -> mRate{
        self.FKm = FKm;
        return self;
    }
    
    public func setTKm( TKm: Double) -> mRate{
        self.TKm = TKm;
        return self;
    }
}
