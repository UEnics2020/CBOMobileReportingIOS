//
//  SpoModel.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 10/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class SpoModel {

    var id : String = ""
    var consignee : String = ""
    var salAmt  : String = ""
    var saleReturn  : String = ""
    var breageExpiry : String = ""
    var creditNotOrther : String = ""
    var netSales : String = ""
    var priSales : String = ""
    var recipt : String = ""
    var outStanding : String = ""
    var stockAmt : String = ""
    var target_Amount : String = ""
    var Spo_bill_url : String = ""
    
    
    
    
    init( id : String , consignee : String ,salAmt : String , saleReturn : String , breageExpiry : String , creditNotOrther : String , netSales : String , recipt : String ,outStanding : String , stockAmt : String , target_Amount  : String ){
        self.id = id;
        self.consignee = consignee;
        self.salAmt = salAmt;
        self.saleReturn = saleReturn;
        self.breageExpiry = breageExpiry;
        self.creditNotOrther = creditNotOrther;
        self.netSales = netSales;
        self.recipt = recipt;
        self.outStanding = outStanding;
        self.stockAmt = stockAmt;
        self.target_Amount = target_Amount;
    }
    
    init(){
    
    }
    
    func getId() -> String {
    return id;
    }
    
    func  setId( id  : String){
    self.id = id;
    }
    
    func getConsignee() -> String{
    return consignee;
    }
    
    func setConsignee( consignee  : String) {
    self.consignee = consignee;
    }
    
    func getSalAmt() -> String{
    return salAmt;
    }
    
    func setSalAmt( salAmt : String) {
    self.salAmt = salAmt;
    }
    
    func getBreageExpiry() -> String {
    return breageExpiry;
    }
    
    func setBreageExpiry( breageExpiry  : String) {
    self.breageExpiry = breageExpiry;
    }
    
    func getCreditNotOrther() -> String {
    return creditNotOrther;
    }
    
   func setCreditNotOrther( creditNotOrther  : String) {
    self.creditNotOrther = creditNotOrther;
    }
    
    func getNetSales() -> String{
    return netSales;
    }
    
    func setNetSales( netSales  : String) {
    self.netSales = netSales;
    }
    
    func getSecSales() -> String{
    return priSales;
    }
    
    func setSecSales( priSales : String) {
    self.priSales = priSales;
    }
    
    func getSaleReturn() -> String {
    return saleReturn;
    }
    
    func setSaleReturn( saleReturn  : String) {
    self.saleReturn = saleReturn;
    }
    
    func getRecipt() -> String{
    return recipt;
    }
    
    func setRecipt( recipt  : String) {
    self.recipt = recipt;
    }
    
    func getOutStanding() -> String{
    return outStanding;
    }
    
    func setOutStanding( outStanding  : String) {
    self.outStanding = outStanding;
    }
    
    func getStockAmt() -> String{
    return stockAmt;
    }
    
    func setStockAmt( stockAmt  : String) {
    self.stockAmt = stockAmt;
    }
    
    func getTarget_Amount() -> String{
    return target_Amount;
    }
    
    func setTarget_Amount( target_Amount : String) {
    self.target_Amount = target_Amount;
    }
    
    func getSpo_bill_url() -> String {
     return Spo_bill_url;
    }
    
    func setSpo_bill_url( url : String) {
     Spo_bill_url = url;
    }
}
