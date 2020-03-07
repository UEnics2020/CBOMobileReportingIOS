//
//  LoggedUnloggedDetailsView.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 13/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class LoggedUnloggedDetailsView: CustomUIViewController {

    private var loggedBriefAdaptor : LoggedBriefAdaptor!
    private var unLoggedAdaptor : UnLogedReportAdaptor!
    private var loggedAdaptor : LoggedReportAdaptor!
    
    private var customVariablesAndMethod: Custom_Variables_And_Method!
    private let cbohelp = CBO_DB_Helper.shared
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var backButton: CustomeUIButton!
    var progressHUD :  ProgressHUD!
    var context : CustomUIViewController!
    
    let DCRUNLOGGED_MOBILE = 0,DCRLOGGED_MOBILE = 1,DCRCALLDETMOBILEGRID = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
        }
        
        context = self
        progressHUD = ProgressHUD(vc : self )
        
        
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
    
      
        
        
        
        if VCIntent["title"] == "UnLogged" {
            unloggedReports()
        }else if  VCIntent["title"] == "Logged"{
             myReports()
        } else  {
            myBriefReports()
        }
    
        tableView.separatorStyle = .none
    }
    
    
    func unloggedReports() {
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"]  = cbohelp.getCompanyCode()
        params["iPaId"] = "\(Custom_Variables_And_Method.PA_ID)"
        params["sDATE"] = VCIntent["sDATE"]!
       
        var tables =  [Int]()
        tables.append(0)
        
        progressHUD.show(text: "Please Wait.. \n Fetching data")
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCRUNLOGGED_MOBILE", tables: tables, response_code: DCRUNLOGGED_MOBILE, vc : context)
        
        //End of call to service
    }
    
    func myBriefReports() {
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"]  = cbohelp.getCompanyCode()
        params["iPaId"] = VCIntent["emp_id"]!
        params["sDATE"] = VCIntent["sDATE"]!
        
        var tables =  [Int]()
        tables.append(0)
        
        progressHUD.show(text: "Please Wait.. \n Fetching data")
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCRLOGGED_MOBILE", tables: tables, response_code: DCRLOGGED_MOBILE, vc : context,multiTableResponse: false)
        
        //End of call to service
    }
    
    
    func myReports() {
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"]  = cbohelp.getCompanyCode()
        params["iPaId"] = VCIntent["emp_id"]!
        params["sFDATE"] = VCIntent["sDATE"]!
        params["sTDATE"] = VCIntent["sDATE"]!
        params["sAREA"] = "0"
        params["iTime"] = VCIntent["time"]!
        params["sTEAMYN"] = ""
        
        var tables =  [Int]()
        tables.append(0)
        
        progressHUD.show(text: "Please Wait.. \n Fetching data")
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCRCALLDETMOBILEGRID", tables: tables, response_code: DCRCALLDETMOBILEGRID, vc : context,multiTableResponse: false)
        
        //End of call to service
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        switch response_code {
        case DCRUNLOGGED_MOBILE:
            parser_logged( dataFromAPI  : dataFromAPI)
        case DCRLOGGED_MOBILE:
            parser_unlogged( dataFromAPI  : dataFromAPI)
        case DCRCALLDETMOBILEGRID:
            parser_loggedBrief( dataFromAPI  : dataFromAPI)
        case 99:
            progressHUD.dismiss()
            customVariablesAndMethod1.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            progressHUD.dismiss()
            print("Error")
        }
    }

    public func parser_logged( dataFromAPI :[ String :NSArray]) {
        if (!dataFromAPI.isEmpty) {
            do{
                
                var data = [[String: String]]();
                let jsonArray = dataFromAPI["Tables0"]!
                
                for i in 0 ..< jsonArray.count{
                    let jasonObj1 = jsonArray[i] as! [String : AnyObject]
                    var datanum = [String : String]();
                    
            
                    datanum["type"] =  try jasonObj1.getString(key: "TYPE") as! String
                    datanum["name"] =  try jasonObj1.getString(key: "DR_NAME") as! String
                    datanum["time"] =  try jasonObj1.getString(key: "TIME") as! String
                    datanum["rarea"] =  try jasonObj1.getString(key: "AREA") as! String
                    
                    datanum["marea"] =  try jasonObj1.getString(key: "AREA_MOBILE") as! String
                
                    data.append(datanum);
                    
                }
                
                loggedAdaptor = LoggedReportAdaptor(vc: self, tableView: tableView,data: data)
                
            }catch{
                customVariablesAndMethod1.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription)
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                objBroadcastErrorMail.requestAuthorization()
            }
        }
         progressHUD.dismiss()
    }
    
    
    public func parser_unlogged( dataFromAPI :[ String :NSArray]) {
        if (!dataFromAPI.isEmpty) {
            do{
                var data = [[String: String]]();
                let jsonArray = dataFromAPI["Tables0"]!
                
                for i in 0 ..< jsonArray.count{
                    let jasonObj1 = jsonArray[i] as! [String : AnyObject]
                    var datanum = [String : String]();

                    datanum["sno"] = "\(i)"
                    datanum["name"] =  try jasonObj1.getString(key: "PA_NAME") as! String
                    datanum["hq"] =  try jasonObj1.getString(key: "HEAD_QTR") as! String
                    datanum["id"] =  try jasonObj1.getString(key: "PA_ID") as! String
            
                    data.append(datanum);
                    
                }
                
                unLoggedAdaptor = UnLogedReportAdaptor(vc: self, tableView: tableView,data: data)
                
            }catch{
                customVariablesAndMethod1.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription)
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                objBroadcastErrorMail.requestAuthorization()
            }
        }
         progressHUD.dismiss()
    }
    
    public func parser_loggedBrief( dataFromAPI :[ String :NSArray]) {
        if (!dataFromAPI.isEmpty) {
            do{
                 var data = [[String: String]]();
                let jsonArray = dataFromAPI["Tables0"]!
                
                for i in 0 ..< jsonArray.count{
                    let jasonObj1 = jsonArray[i] as! [String : AnyObject]
                    var datanum = [String : String]();
                    
                    datanum["sno"] = "\(i)"
                    datanum["Emp_Name"] =  try jasonObj1.getString(key: "PA_NAME") as! String
                    datanum["WORKING_TYPE"] =  try jasonObj1.getString(key: "WORKING_TYP") as! String
                    datanum["joining_area"] =  try jasonObj1.getString(key: "MOBILE_AREA") as! String
                    datanum["join_time"] =  try jasonObj1.getString(key: "IN_TIME") as! String
                    
                    datanum["route"] =  try jasonObj1.getString(key: "ROUTE") as! String
                    datanum["WORK_WITH"] =  try jasonObj1.getString(key: "WORK_WITH") as! String
                    datanum["Head_Qtr"] =  try jasonObj1.getString(key: "HEAD_QTR") as! String
                    datanum["TP_PLANE"] =  try jasonObj1.getString(key: "TP_PLANE") as! String
                    datanum["FIRST_CALL"] =  try jasonObj1.getString(key: "FIRST_CALL") as! String
                    datanum["DCR_DATE"] =  try jasonObj1.getString(key: "DCR_DATE") as! String
                    datanum["TOTAL_CALL"] =  try jasonObj1.getString(key: "TOTAL_CALL") as! String
        
                    data.append(datanum);
                  
                }
                
                loggedBriefAdaptor = LoggedBriefAdaptor(vc: self, tableView: tableView,data: data)
                
            }catch{
                customVariablesAndMethod1.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription)
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                objBroadcastErrorMail.requestAuthorization()
            }
        }
         progressHUD.dismiss()
    }
    @objc func closeVC(){
        myTopView.CloseCurruntVC(vc: self)
    }
}
