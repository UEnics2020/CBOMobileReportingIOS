//
//  mUser.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/02/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
import CoreLocation
public class mUser {
    private var Name : String? = nil;
    private var ID : String? = nil;
    private var Desgination : String? = nil;
    private var DesginationID : String? = nil;
    private var CompanyCode : String? = nil;
    private var HQ : String? = nil;
    private var ManagerName : String? = nil;
    private var ManagerId : String? = nil;
    
    private var DCRId : String? = nil;
    private var DCRDate : String? = nil;
    private var DCRDateDisplay : String? = nil;
    
    private var IMEI : String? = nil;
    private var OS : String? = nil;
    private var battery: String? = nil;
    private var AppVersion = "20190217";
    private var time: String? = nil;
    private var location: CLLocation? = nil;
    private var LoggedInAsSupport : Bool = false;
    //private Boolean showLatLong = false;
    
    public init( ID : String,  companyCode : String) {
        self.ID = ID.trimmingCharacters(in: .whitespacesAndNewlines);
        self.CompanyCode = companyCode.trimmingCharacters(in: .whitespacesAndNewlines);
    }
    
    
    
    //getter
    public func getName() -> String{
    return Name!;
    }
    
    public func getID() -> String {
    return ID!;
    }
    
    public func getDesgination() -> String {
    return Desgination!;
    }
    
    public func getDesginationID() -> String {
    return DesginationID!;
    }
    
    public func getCompanyCode()  -> String{
        return CompanyCode!.uppercased();
    }
    
    public func getHQ()  -> String{
        return HQ!;
    }
    
    public func getDCRId() -> String {
        return DCRId!;
    }
    
    public func getDCRDate()  -> String{
        return DCRDate!;
    }
    
    public func getDCRDateDisplay()  -> String{
        return DCRDateDisplay!;
    }
    
    public func getOS() -> String {
        return OS!;
    }
    
    public func getBattery() -> String {
        return battery!;
    }
    
    public func getAppVersion()  -> String{
    return AppVersion;
    }
    
    public func getTime()  -> String{
        time = "\( Date().timeIntervalSince1970)"
        return time!;
    }
    
    public func getLocation() -> CLLocation{
        return location!;
    }
    
    public func getLoggedInAsSupport()-> Bool {
        return LoggedInAsSupport;
    }
    
    public func getManagerName()  -> String{
        return ManagerName!;
    }
    
    public func getManagerId()  -> String{
        return ManagerId!;
    }
    
    /* public Boolean getShowLatLong() {
     return showLatLong;
     }*/
    
    public func getIMEI() -> String {
        return IMEI!;
    }
    ///setter
    
    public func setName( name : String) -> mUser {
    Name = name;
    return self;
    }
    
    
    public func setDesgination( desgination : String)-> mUser  {
    Desgination = desgination;
    return self;
    }
    
    public func setDesginationID( desginationID : String)-> mUser  {
    DesginationID = desginationID;
    return self;
    }
    
    
    public func setHQ( HQ : String)-> mUser  {
    self.HQ = HQ;
    return self;
    }
    
    public func setDCRId( DCRId : String)-> mUser  {
    self.DCRId = DCRId;
    return self;
    }
    
    public func setDCRDate( DCRDate : String) -> mUser {
    self.DCRDate = DCRDate;
    return self;
    }
    
    public func setDCRDateDisplay( DCRDateDisplay : String)-> mUser  {
    self.DCRDateDisplay = DCRDateDisplay;
    return self;
    }
    
    
    public func setOS( OS : String) -> mUser {
    self.OS = OS;
    return self;
    }
    
    public func setBattery( battery : String) -> mUser  {
    self.battery = battery;
    return self;
    }
    
    
    public func setLocation( location : CLLocation) -> mUser  {
    self.location = location;
    return self;
    }
    
    public func setLoggedInAsSupport( loggedInAsSupport : Bool)  -> mUser {
    LoggedInAsSupport = loggedInAsSupport;
    return self;
    }
    
    public func setManagerName( managerName : String) -> mUser  {
    ManagerName = managerName;
    return self;
    }
    
    public func setManagerId( managerId : String) -> mUser  {
    ManagerId = managerId;
    return self;
    }
    
    public func setIMEI( IMEI : String) -> mUser {
        self.IMEI = IMEI;
        return self;
    }

}
