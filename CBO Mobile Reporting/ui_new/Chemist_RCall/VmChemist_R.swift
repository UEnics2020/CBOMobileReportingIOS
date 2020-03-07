//
//  VmChemist_R.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
import CoreLocation

class VmChemist_R {
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    //private var chemist : mChemist!;
    private var docList = [SpinnerModel]();
    let CALL_DILOG = 5, MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11
    
    var reminder_list = [String : [String]]()
    var  summary_list = [[String : [String : [String]]]]()
    var view: IChemist_R?
    var context : CustomUIViewController
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var progressHUD : ProgressHUD!
    
    init(del:IChemist_R, context: CustomUIViewController) {
        self.context = context
        self.view = del
         progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
    }
    
    func getChemistlist(context : CustomUIViewController ) -> [SpinnerModel]{
        
        do{
            let statement = try cbohelp.getRcChemListLocal()
            // chemist.add(new SpinnerModel("--Select--",""));
            let db = cbohelp
            docList.removeAll()
            
            while let c = statement.next() {
                docList.append(
                    
                    try SpinnerModel(name: c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_name")]! as! String,
                                     id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_id")]!)",
                                     last_visited: c[db.getColumnIndex(statement: statement, Coloumn_Name: "LAST_VISIT_DATE")]! as! String,
                                     DR_LAT_LONG: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG")]! as! String,
                                     DR_LAT_LONG2: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG2")]! as! String,
                                     DR_LAT_LONG3: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG3")]! as! String,
                                     CALLYN: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "CALLYN")]!)"
                    )
                );
                
            }
            
            Call_Dialog(vc: context, title: "Select ...", dr_List: docList, callTyp: "C", responseCode: CALL_DILOG).show()
            
        } catch {
            print(error)
        }
        
        return docList
    }
    
    
    func genrateSummary() {
        
        summary_list.removeAll()
        var headers = [String]()
        var isCollaps = [Bool]() //phdcrchem_rc   //phdcrdr_rc
        reminder_list = cbohelp.getCallDetail(table: "phdcrchem_rc",look_for_id: "",show_edit_delete: "1")
        
        print("reminder_list ",reminder_list)
        do {
            
            summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_CHEM_RCCALL").getString(key:"D_CHEM_RCCALL") : reminder_list])
        } catch {
            print(error)
        }
        
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        
        print("view ",view)
        print("summary_list",summary_list)
        //presenter = ParantSummaryAdaptor(tableView:reminderSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        view?.updateCollapseHeader(collapse: isCollaps, header: headers, list: summary_list)
      
        
    }
    
    
    func addChemistRcInLocal(che_id : String, address : String, call_latLong : String, remark : String, ref_latLong : String) {
         
         var locExtra = ""
         Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
         
         let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
         
         if (currentBestLocation != CLLocation()) {
             locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
         }
     
         if(che_id == "") {
            
             customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Chemist from List");
            
         } else {
             
             let dcrid = Custom_Variables_And_Method.DCR_ID;
             
             customVariablesAndMethod.getBatteryLevel()
             
             cbohelp.insertChemRem(dcrid: dcrid, chem_id: che_id, address: address, time: customVariablesAndMethod.currentTime(context: context), latLong: call_latLong, updated: "0", rc_km: "0", srno: customVariablesAndMethod.srno(context: context), batteryLevel: Custom_Variables_And_Method.BATTERYLEVEL, remark: remark, file: "", LOC_EXTRA: locExtra, Ref_latlong: ref_latLong)
            
            
           
             
             print("chemist reminder added");
    
         }
        
     }
    
    
    func DeleteChemist(id: String , name: String) {
        var msg = ""
        
        var alertViewController : UIAlertController!
        
        print(name)
        let delete = UIAlertAction(title: "Delete!!!", style: .default) { (action) in
     
            var params = [String : String]()
            params["sCompanyFolder"] = self.cbohelp.getCompanyCode()
            params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
            params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
            params["iDR_ID"] = id
            params["sTableName"] =  "CHEMISTRC"
                //011 61606161
            var tables = [Int]()
            tables.append(0)
            
            CboServices().customMethodForAllServices(params: params, methodName: "DRCHEMDELETE_MOBILE", tables: tables, response_code: self.MESSAGE_INTERNET_DRCHEMDELETE_MOBILE, vc : self.context)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        msg = "Do you Really want to delete " + name + " ?"
        
        alertViewController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        
        alertViewController.addAction(cancel)
        alertViewController.addAction(delete)
        
        context.present(alertViewController, animated: true, completion: nil)
        
    }
    
    
    
    
   

}
