//
//  mExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 13/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
public class mExpense {
    
    private var DA_TYPE : String!;
    private var DA_TYPE_Display = "";
    private var FARE = "";
    private var ACTUALFAREYN : String!;
    private var ACTUALDA_FAREYN = "";
    private var ROUTE_CLASS = "";
    private var ACTUALFAREYN_MANDATORY = "";
    private var ACTUALFARE_MAXAMT : Double = 0;
    private var DA_TYPE_MANUALYN : String!;
    private var TA_TYPE_MANUALYN : String!;
    private var MANUAL_TAYN_MANDATORY : String!;
    private var MANUAL_TAYN_KM = "";
    private var MANUAL_TAYN_STATION = "";
    private var DISTANCE_TYPE_MANUALYN = "";
    private var MANUAL_DAYN : String!;
    private var selected_da =  mDA();
    private var selected_distance =  mDistance();
    private var expHeads =  [mExpHead]();
    private var DAs = [mDA]();
    private var distances = [mDistance]();
    private var othExpenses = [mOthExpense]();
    private var TA_Expenses = [mOthExpense]();
    private var DA_Expenses = [mOthExpense]();
    private var rates = [mRate]();
    private var DA_Amt : Double!;
    private var TA_Amt : Double!;
    private var Rate : Double = 0;
    private var Km : Double = 0;
    private var Station = "";
    private var Attachment = "";
    
    
    ///getter
    
    
    public func getDA_TYPE()-> String {
        if (DA_TYPE == nil){
            DA_TYPE = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DA_TYPE",defaultValue: "-");
        }
        return DA_TYPE;
    }
    
    public func getDA_TYPE_Display() -> String{
        return DA_TYPE_Display;
    }
    
    public func getSelectedDA() -> mDA{
        return selected_da;
    }
    
    public func getSelectedDistance()-> mDistance{
        return selected_distance;
    }
    
    public func getFARE()-> String {
        return FARE;
    }
    
    public func getACTUALFAREYN() -> String{
        if (ACTUALFAREYN == nil){
            ACTUALFAREYN = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "ACTUALFAREYN",defaultValue: "");
        }
        return ACTUALFAREYN;
    }
    
    public func getACTUALDA_FAREYN()-> String {
        return ACTUALDA_FAREYN;
    }
    
    public func getROUTE_CLASS() -> String{
        return ROUTE_CLASS;
    }
    
    public func getACTUALFAREYN_MANDATORY() -> String{
        return ACTUALFAREYN_MANDATORY;
    }
    
    public func getACTUALFARE_MAXAMT() -> Double{
        return ACTUALFARE_MAXAMT;
    }
    
    public func getDA_TYPE_MANUALYN() -> String{
        if (DA_TYPE_MANUALYN == nil){
            DA_TYPE_MANUALYN = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DA_TYPE_MANUALYN",defaultValue: "");
        }
        return DA_TYPE_MANUALYN;
    }
    
    public func getTA_TYPE_MANUALYN()-> String {
        if (TA_TYPE_MANUALYN == nil){
            TA_TYPE_MANUALYN = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "TA_TYPE_MANUALYN",defaultValue: "");
        }
        return TA_TYPE_MANUALYN;
    }
    
    public func getMANUAL_TAYN_MANDATORY()-> String{
        
        if (MANUAL_TAYN_MANDATORY == nil){
            MANUAL_TAYN_MANDATORY = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "MANUAL_TAYN_MANDATORY",defaultValue: "");
        }
        return MANUAL_TAYN_MANDATORY;
    }
    
    public func getMANUAL_TAYN_KM()-> String {
        return MANUAL_TAYN_KM;
    }
    
    public func getMANUAL_TAYN_STATION() -> String{
        return MANUAL_TAYN_STATION;
    }
    
    public func getDISTANCE_TYPE_MANUALYN() -> String{
        return DISTANCE_TYPE_MANUALYN;
    }
    
    public func getDAs() -> [mDA]{
        return DAs;
    }
    
    public func getDistances() -> [mDistance]{
        return distances;
    }
    
    public func getExpHeads() -> [mExpHead]{
        return expHeads;
    }
    
    public func getOthExpenses() -> [mOthExpense]{
        return othExpenses;
    }
    
    public func getTA_Expenses() -> [mOthExpense]{
        return TA_Expenses;
    }
    
    public func getDA_Expenses() -> [mOthExpense]{
        return DA_Expenses;
    }
    
    public func getRates() -> [mRate]{
        return rates;
    }
    
    public func getRate()-> Double{
        return Rate;
    }
    
    public func getKm()-> Double{return Km;}
    
    public func getDA_Amt() -> Double{
        if (DA_Amt == nil){
            DA_Amt = Double(Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "da_val",defaultValue: "0"));
        }
        return DA_Amt;
    }
    
    public func getTA_Amt() -> Double{
        if (TA_Amt == nil){
            TA_Amt = Double(Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "distance_val",defaultValue: "0"));
        }
        return TA_Amt;
    }
    
    public func getStation() -> String{
        return Station;
    }
    
    public func getMANUAL_DAYN()-> String{
        if (MANUAL_DAYN == nil){
            MANUAL_DAYN = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "MANUAL_DAYN",defaultValue: "");
        }
        return MANUAL_DAYN;
    }
    
    public func getAttachment() -> String{
        return Attachment;
    }
    
    /// setter
    
    
    public func setDA_TYPE( DA_TYPE: String) -> mExpense{
        self.DA_TYPE = DA_TYPE;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DA_TYPE",value: DA_TYPE);
        return self;
    }
    
    public func setDA_TYPE_Display( DA_TYPE_Display : String)-> mExpense{
        self.DA_TYPE_Display = DA_TYPE_Display;
        return self;
    }
    
    public func setFARE( FARE : String) -> mExpense{
        self.FARE = FARE;
        return self;
    }
    
    public func setACTUALFAREYN( ACTUALFAREYN : String) -> mExpense{
        self.ACTUALFAREYN = ACTUALFAREYN;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "ACTUALFAREYN",value: ACTUALFAREYN);
        return self;
    }
    
    public func setACTUALDA_FAREYN( ACTUALDA_FAREYN : String)-> mExpense {
        self.ACTUALDA_FAREYN = ACTUALDA_FAREYN;
        return self;
    }
    
    public func setROUTE_CLASS( ROUTE_CLASS : String)-> mExpense {
        self.ROUTE_CLASS = ROUTE_CLASS;
        return self;
    }
    
    public func setACTUALFAREYN_MANDATORY( ACTUALFAREYN_MANDATORY : String)-> mExpense {
        self.ACTUALFAREYN_MANDATORY = ACTUALFAREYN_MANDATORY;
        return self;
    }
    
    public func setACTUALFARE_MAXAMT( ACTUALFARE_MAXAMT : Double) -> mExpense{
        self.ACTUALFARE_MAXAMT = ACTUALFARE_MAXAMT;
        return self;
    }
    
    public func setDA_TYPE_MANUALYN( DA_TYPE_MANUALYN : String) -> mExpense{
        self.DA_TYPE_MANUALYN = DA_TYPE_MANUALYN;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DA_TYPE_MANUALYN",value: DA_TYPE_MANUALYN);
        return self;
    }
    
    public func setTA_TYPE_MANUALYN( TA_TYPE_MANUALYN : String) -> mExpense{
        self.TA_TYPE_MANUALYN = TA_TYPE_MANUALYN;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "TA_TYPE_MANUALYN",value: TA_TYPE_MANUALYN);
        return self;
    }
    
    public func setMANUAL_TAYN_MANDATORY( MANUAL_TAYN_MANDATORY : String)-> mExpense{
        self.MANUAL_TAYN_MANDATORY = MANUAL_TAYN_MANDATORY;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "MANUAL_TAYN_MANDATORY",value: MANUAL_TAYN_MANDATORY);
        return self;
    }
    
    public func setMANUAL_TAYN_KM( MANUAL_TAYN_KM : String)-> mExpense {
        self.MANUAL_TAYN_KM = MANUAL_TAYN_KM;
        return self;
    }
    
    public func setMANUAL_TAYN_STATION( MANUAL_TAYN_STATION : String) -> mExpense{
        self.MANUAL_TAYN_STATION = MANUAL_TAYN_STATION;
        return self;
    }
    
    public func setDISTANCE_TYPE_MANUALYN( DISTANCE_TYPE_MANUALYN : String) -> mExpense{
        self.DISTANCE_TYPE_MANUALYN = DISTANCE_TYPE_MANUALYN;
        return self;
    }
    public func setDAs( DAs : [mDA]) -> mExpense{
        self.DAs = DAs;
        return self;
    }
    
    public func setDistances( distances : [mDistance]) -> mExpense{
        self.distances = distances;
        return self;
    }
    
    public func setExpHeads(expHeads : [mExpHead]) -> mExpense{
        self.expHeads = expHeads;
        return self;
    }
    
    public func setOthExpenses(othExpenses : [mOthExpense]) -> mExpense{
        self.othExpenses = othExpenses;
        return self;
    }
    
    public func setTA_Expenses(TA_Expenses : [mOthExpense]) -> mExpense{
        self.TA_Expenses = TA_Expenses;
        return self;
    }
    
    public func setDA_Expenses( DA_Expenses : [mOthExpense]) -> mExpense{
        self.DA_Expenses = DA_Expenses;
        return self;
    }
    
    public func setDA_Amt( DA_Amt : Double) -> mExpense{
        self.DA_Amt = DA_Amt;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "da_val",value: "\(DA_Amt)");
        return self;
    }
    
    public func setDA( da : mDA)-> mExpense{
        selected_da = da;
        return self;
    }
    
    public func setDistance( distance : mDistance)-> mExpense{
        selected_distance = distance;
        return self;
    }
    public func setRates( rates : [mRate]) -> mExpense{
        self.rates = rates;
        return self;
    }
    
    public func setTA_Amt( TA_Amt: Double) -> mExpense{
        self.TA_Amt = TA_Amt;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "distance_val",value: "/(TA_Amt)");
        return self;
    }
    
    public func setRate( rate: Double) -> mExpense{
        self.Rate = rate;
        return self;
    }
    
    public func setKm( km: Double) -> mExpense{
        self.Km = km;
        return self;
    }
    
    public func setMANUAL_DAYN( MANUAL_DAYN : String)-> mExpense {
        self.MANUAL_DAYN = MANUAL_DAYN;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "MANUAL_DAYN",value: MANUAL_DAYN);
        return self;
    }
    
    public func setStation( station  : String) -> mExpense{
        self.Station = station;
        return self;
    }
    
    public func setAttachment( attachment : String) -> mExpense{
        Attachment = attachment;
        return self;
    }
    
    public func getRateFor( km : Double) -> mRate{
        let rate =  mRate();
        //rates.forEach { (rate1) in
        for rate1 in rates{
            if (km>=rate1.getFKm() && km <= rate1.getTKm()){
                return rate1;
            }
        }
       
        return rate;
    }
}

