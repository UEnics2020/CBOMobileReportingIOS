//
//  FinalSubmit.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 17/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation
class FinalSubmit: CustomUIViewController {
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var loc: CustomDisableTextView!
    
    @IBOutlet weak var Dcr_Date: CustomDisableTextView!
    
    @IBOutlet weak var work_type: CustomDisableTextView!
    
    @IBOutlet weak var remark_layout: CustomBoarder!
    @IBOutlet weak var remark: UITextView!
    
    @IBOutlet weak var Submit: CustomeUIButton!
    
    @IBOutlet weak var loc_layout: UIStackView!
    let customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    let cbohelp : CBO_DB_Helper =  CBO_DB_Helper.shared
    
    var mRemark = "" ,back_allowed="Y";
    var DCR_REMARK_NA = "N"
    let MESSAGE_INTERNET_FINAL_SUBMIT=0;
    let GPS_TIMMER=4;
    var address = ""
    var PA_ID = 0
    
    private var cboFinalTask_new : CBOFinalTask_New!
    var dcr_latCommit = [String : String]()
    var dcr_Commititem = [String : String]()
    var dcr_Commit_rx = [String : String]()
    var dcr_CommitDr =  [String : String]()
    var dcr_CommitChem_Reminder = [String : String]()
    var dcr_ChemistCommit = [String : String]()
    var dcr_StkCommit = [String : String]()
    var dcr_CommitDr_Reminder = [String : String]()
    var Lat_Long_Reg = [String : String]()
    var dcr_Dairy = [String : String]()
    
    var sb_DCRLATCOMMIT_KM, sb_DCRLATCOMMIT_LOC_LAT, sb_sDCRLATCOMMIT_IN_TIME, sDCRLATCOMMIT_ID, sDCRLATCOMMIT_LOC : String!
    
    var sDCRITEM_DR_ID, sDCRITEM_ITEMIDIN, sDCRITEM_ITEM_ID_ARR, sDCRITEM_QTY_ARR, sDCRITEM_ITEM_ID_GIFT_ARR, sDCRITEM_QTY_GIFT_ARR, sDCRITEM_POB_QTY, sDCRITEM_POB_VALUE, sDCRITEM_VISUAL_ARR,sDCRITEM_NOC_ARR : String!
    
    var sDCRDR_DR_ID, sDCRDR_WW1, sDCRDR_WW2, sDCRDR_WW3, sDCRDR_LOC, sDCRDR_IN_TIME, sDCRDR_BATTERY_PERCENT, sDCRDR_REMARK, sDCRDR_KM, sDCRDR_SRNO,sDCRDR_FILE,sDCRDR_CALLTYPE,sDR_REF_LAT_LONG : String!
    
    var sDCRCHEM_CHEM_ID, sDCRCHEM_POB_QTY, sDCRCHEM_POB_AMT, sDCRCHEM_ITEM_ID_ARR, sDCRCHEM_QTY_ARR, sDCRCHEM_LOC, sDCRCHEM_IN_TIME, sDCRCHEM_SQTY_ARR, sDCRCHEM_ITEM_ID_GIFT_ARR, sDCRCHEM_QTY_GIFT_ARR, sDCRCHEM_BATTERY_PERCENT, sDCRCHEM_KM, sDCRCHEM_SRNO,sDCRCHEM_REMARK,sDCRCHEM_FILE,sCHEM_REF_LAT_LONG : String!
    var sCHEM_STATUS = "",sCOMPETITOR_REMARK = ""
    
    var sDCRSTK_STK_ID = "", sDCRSTK_POB_QTY = "", sDCRSTK_POB_AMT = "", sDCRSTK_ITEM_ID_ARR = "", sDCRSTK_QTY_ARR = "" , sDCRSTK_LOC = "" , sDCRSTK_IN_TIME = "", sDCRSTK_SQTY_ARR = "", sDCRSTK_ITEM_ID_GIFT_ARR = "", sDCRSTK_QTY_GIFT_ARR = "", sDCRSTK_BATTERY_PERCENT = "", sDCRSTK_KM = "", sDCRSTK_SRNO = "",sDCRSTK_REMARK = ""  ,sDCRSTK_FILE,sSTK_REF_LAT_LONG : String!
    
    var sDCRRC_IN_TIME = "", sDCRRC_LOC = "", sDCRRC_DR_ID = "", sDCRRC_KM = "", sDCRRC_SRNO = "",sDCRRC_BATTERY_PERCENT = "",sDCRRC_REMARK = "", sDCRRC_FILE,sRC_REF_LAT_LONG : String!
    
    var sDCR_DR_RX, sDCR_ITM_RX , sFinalKm , DCS_ID_ARR, LAT_LONG_ARR, DCS_TYPE_ARR, DCS_ADD_ARR, DCS_INDES_ARR : String!
    
    var DCRSTK_RATE, DCRDR_RATE, DCRCHEM_RATE : String!
    
    var sDAIRY_ID, sSTRDAIRY_CPID,sDCRDAIRY_LOC,sDCRDAIRY_IN_TIME,sDCRDAIRY_BATTERY_PERCENT,sDCRDAIRY_REMARK,sDCRDAIRY_KM,sDCRDAIRY_SRNO,sDAIRY_REF_LAT_LONG : String!
    
  
    
    var sDCRRC_CHEM_ID,sDCRRC_LOC_CHEM,sDCRRC_IN_TIME_CHEM,sDCRRC_KM_CHEM,sDCRRC_SRNO_CHEM,sDCRRC_BATTERY_PERCENT_CHEM,sDCRRC_REMARK_CHEM,sDCRRC_FILE_CHEM,sRC_REF_LAT_LONG_CHEM : String!
    
    var sDCRDAIRYITEM_DAIRY_ID,sDCRDAIRYITEM_ITEM_ID_ARR,sDCRDAIRYITEM_QTY_ARR,sDCRDAIRYITEM_ITEM_ID_GIFT_ARR,sDCRDAIRYITEM_QTY_GIFT_ARR : String!
    var sDCRDAIRYITEM_POB_QTY,sDAIRY_FILE,sDCRDAIRY_INTERSETEDYN : String!

    
    
    var Back_allowed = "Y"
    var context : CustomUIViewController!
    var progressHUD : ProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = self
        customVariablesAndMethod.betteryCalculator()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        myTopView.setText(title: VCIntent["title"]!)
        progressHUD = ProgressHUD(vc: self)
        cboFinalTask_new = CBOFinalTask_New(context: context)
        PA_ID = Custom_Variables_And_Method.PA_ID
        setAddressToUI();
        
        Back_allowed = VCIntent["Back_allowed"]!
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        } else {
            loc_layout.isHidden = true
        }
        
        
        DCR_REMARK_NA = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_REMARK_NA",defaultValue: "N");
        
        Dcr_Date.setText(text: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DATE_NAME",defaultValue: customVariablesAndMethod.currentDate()));
        work_type.setText(text: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_head",defaultValue: "Working"));
        //Toast.makeText(this,"javed "+DCR_REMARK_NA,Toast.LENGTH_LONG).show();
        mRemark = remark.text
        if (DCR_REMARK_NA.lowercased() ==  "y"){
            remark.isHidden = true
            mRemark="Remark Not Required";
        }
        
        
        Submit.addTarget(self, action: #selector(ValidateFinalSubmit), for: .touchUpInside )
    }
    
    @objc func ValidateFinalSubmit(){
        if (customVariablesAndMethod.internetConneted(context: context)) {
          
            
            if (Custom_Variables_And_Method.GLOBAL_LATLON == ("0.0,0.0")) {
                
                Custom_Variables_And_Method.GLOBAL_LATLON =  customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
            }
            setAddressToUI();
            
            
            if (loc.getText() == "") {
                loc.setText(text: "UnKnown Location");
            }
            address = loc.getText()
            
            if (DCR_REMARK_NA.lowercased() ==  "y") {
                mRemark = "Remark Not Required";
            } else {
                mRemark = remark.text
            }
            
            if (mRemark == "") {
                customVariablesAndMethod.msgBox(vc: context,msg: "Enter Remark....");
            }/*else if(customVariablesAndMethod.drChemEntryAllowed(context) && Late_Submit_remark.equals("") ){
                 customVariablesAndMethod.msgBox(context,"Enter Late Submit Remark....");
             }*/ else {
                
               // new GPS_Timmer_Dialog(context,mHandler,"Final Submit in Process...",GPS_TIMMER).show();
                finalSubmitNew()
            }
            
        }
    
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
        case MESSAGE_INTERNET_FINAL_SUBMIT:
            parser6(dataFromAPI : dataFromAPI)
            progressHUD.dismiss()
            break;
            
        case 99:
            progressHUD.dismiss()
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break;
        default:
            progressHUD.dismiss()
        }
        
    }
    
    func parser6(dataFromAPI: [String : NSArray]) {
     if(!dataFromAPI.isEmpty){
            do {
                let jsonArray1 =   dataFromAPI["Tables0"]!
                let c = jsonArray1[0] as! [String : AnyObject]
                if ( try c.getString(key: "STATUS") == "Y") {
                    setDataforFMCGandMenu(dataFromAPI : dataFromAPI);
//                    customMethod.stopAlarm10Sec();
//                    customMethod.stopAlarm10Minute();
//                    customMethod.stopDOB_DOA_Remainder();
                      Multi_Class_Service_call().releseResources(mContext: self);
//
//                    Intent i = new Intent(getApplicationContext(), LoginFake.class);
//                    i.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                    startActivity(i);
                    
    //                if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"ASKUPDATEYN","N").equals("Y")) {
    //                    new GetVersionCode(FinalSubmitDcr_new.this).execute();
    //                }
                    customVariablesAndMethod.msgBox(vc: context,msg: "DCR Saved Sucessfully..", completion: {_ in self.myTopView.CloseAllVC(vc: self.context)})
                  
                //setAlertDialogifDataNotFound_2(""+result);
                } else {
                    try customVariablesAndMethod.getAlert(vc: context, title: "Alert !!!", msg: c.getString(key: "MESSAGE") , url: c.getString(key: "URL"))
                }
                
            } catch {
            
                customVariablesAndMethod.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription)
                
                let dataDict = ["Method Name":"Final Submit" , "Error Alert " : "Missing Field Error \n \(error.localizedDescription)"  ]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "Missing Field Error", vc: self)
                
                objBroadcastErrorMail.requestAuthorization()
            }
        }
    }
    
    func setDataforFMCGandMenu(dataFromAPI: [String : NSArray]) {
        do{
            // fmcgddl_20
            
            let jsonArray23 = dataFromAPI["Tables0"]!
            
            let jsonArray24 = dataFromAPI["Tables1"]!
            
            for  i in  0  ..< jsonArray23.count {
                
                let c = jsonArray23[i] as! [String : AnyObject]
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key : "fmcg_value", value: try c.getString(key: "FMCG"))
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key:  "root_needed", value:  try c.getString(key: "ROUTE"))
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key : "gps_needed", value:  try c.getString(key: "GPRSYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key :"version", value:  try c.getString(key: "VER"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self  ,key : "doryn", value : try c.getString(key: "DORYN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key : "dosyn", value:  try c.getString(key: "DOSYN")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key:  "internet",value:  try c.getString(key: "INTERNET_RQD") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "live_km",value:  try c.getString(key: "LIVE_KM") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key :"leave_yn", value:  try c.getString(key: "LEAVEYN")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "WEBSERVICE_URL",value:  try c.getString(key: "WEBSERVICE_URL") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "WEBSERVICE_URL_ALTERNATE",value:  try c.getString(key: "WEBSERVICE_URL_ALTERNATE"))
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FLASHYN",value: try  c.getString(key: "FLASHYN") )
                //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,"FLASHYN", c.getString("FLASHYN"as! String )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_REMARK_NA",value:  try c.getString(key: "DCR_REMARK_NA")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_DR_REMARKYN", value:  try c.getString(key: "DCR_DR_REMARKYN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ROUTEDIVERTYN", value:  try c.getString(key: "ROUTEDIVERTYN")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_ADDAREANA", value: try c.getString(key: "DCR_ADDAREANA") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAIDPDFYN", value: try c.getString(key: "VISUALAIDPDFYN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_POB_MANDATORY", value: try c.getString(key: "SAMPLE_POB_MANDATORY") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "REMARK_WW_MANDATORY", value: try c.getString(key: "REMARK_WW_MANDATORY")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_POB_INPUT_MANDATORY", value : try c.getString(key: "SAMPLE_POB_INPUT_MANDATORY")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "MISSED_CALL_OPTION", value : try c.getString(key: "MISSED_CALL_OPTION"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "APPRAISALMANDATORY", value : try c.getString(key: "APPRAISALMANDATORY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "USER_NAME", value : try c.getString(key: "USER_NAME")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "PASSWORD", value : try c.getString(key: "PASSWORD") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_DRSELITEMYN",value : try c.getString(key: "VISUALAID_DRSELITEMYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DOB_REMINDER_HOUR", value : try c.getString(key: "DOB_REMINDER_HOUR") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SYNCDRITEMYN", value : try c.getString(key: "SYNCDRITEMYN")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "GEO_FANCING_KM", value : try c.getString(key: "GEO_FANCING_KM")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FIRST_CALL_LOCK_TIME", value :  try c.getString(key: "FIRST_CALL_LOCK_TIME")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "mark", value : try c.getString(key: "FLASH_MESSAGE") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NOC_HEAD", value : try c.getString(key: "NOC_HEAD") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "USER_PIC",value : try c.getString(key: "USER_PIC") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_LETREMARK_LENGTH", value : try c.getString(key: "DCR_LETREMARK_LENGTH"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLEMAXQTY", value : try c.getString(key: "SAMPLEMAXQTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "POBMAXQTY", value : try c.getString(key: "POBMAXQTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ASKUPDATEYN", value : try c.getString(key: "ASKUPDATEYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "MOBILEDATAYN", value : try c.getString(key: "MOBILEDATAYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CALLWAITINGTIME", value : try c.getString(key: "CALLWAITINGTIME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "COMPANY_PIC", value : try c.getString(key: "COMPANY_PIC"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RE_REG_KM", value : try c.getString(key: "RE_REG_KM") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ERROR_EMAIL", value : try c.getString(key: "ERROR_EMAIL"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DIVERT_REMARKYN", value : try c.getString(key: "DIVERT_REMARKYN"))
                
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NLC_PIC_YN", value : try c.getString(key: "NLC_PIC_YN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RX_MAX_QTY", value : try c.getString(key: "RX_MAX_QTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SHOW_ADD_REGYN", value : try c.getString(key: "SHOW_ADD_REGYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "EXP_ATCH_YN", value : try c.getString(key: "EXP_ATCH_YN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FARMERADDFIELDYN", value : try c.getString(key: "FARMERADDFIELDYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NO_DR_CALL_REQ", value : try c.getString(key: "NO_DR_CALL_REQ"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_RX_ENTRY_YN", value : try c.getString(key: "DR_RX_ENTRY_YN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RETAILERCHAINYN", value : try c.getString(key: "RETAILERCHAINYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_SUBMIT_TIME", value : try c.getString(key: "DCR_SUBMIT_TIME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_SUBMIT_SPEACH", value : try c.getString(key: "DCR_SUBMIT_SPEACH"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ALLOWED_APP", value : try c.getString(key: "ALLOWED_APP")  )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRGIFT_QTY_VALIDATE", value : try c.getString(key: "DCRGIFT_QTY_VALIDATE"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_BTN_CAPTION", value : try c.getString(key: "SAMPLE_BTN_CAPTION") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "GIFT_BTN_CAPTION", value : try c.getString(key: "GIFT_BTN_CAPTION") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DIVERTWWYN", value : try c.getString(key: "DIVERTWWYN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "PIN_ALLOWED_MSG", value : try c.getString(key: "PIN_ALLOWED_MSG") )
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CMC3_GALLERY_REQ", value: try c.getString(key: "CMC3_GALLERY_REQ"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_COLOR", value: try c.getString(key: "DR_COLOR"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRPPNA", value: try c.getString(key: "DCRPPNA"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_SALE_URL", value: try c.getString(key: "DR_SALE_URL"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "REG_ADDRESS_KM", value: try c.getString(key: "REG_ADDRESS_KM"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_DIVISION_FILTER_YN", value: try c.getString(key: "DR_DIVISION_FILTER_YN"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_RXGEN_VALIDATE", value: try c.getString(key: "DR_RXGEN_VALIDATE"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FIREBASE_SYNCYN", value: try c.getString(key: "FIREBASE_SYNCYN"));
                
                
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRDRADDAREA_APP_MSG", value: try c.getString(key: "DCRDRADDAREA_APP_MSG"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DRGIFTMANDATORY", value: try c.getString(key: "DRGIFTMANDATORY"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_MULTIPLE_ROUTEYN", value: try c.getString(key: "DCR_MULTIPLE_ROUTEYN"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_LEAD_ENTRY_YN", value: try c.getString(key: "DCR_LEAD_ENTRY_YN"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_CALL_STATUS_YN", value: try c.getString(key: "DCR_CALL_STATUS_YN"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FY_FDATE", value: try c.getString(key: "FY_FDATE"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FY_TDATE", value: try c.getString(key: "FY_TDATE"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ORD_DISC_TYPE", value: try c.getString(key: "ORD_DISC_TYPE"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SALE_ORDER_REMARKYN", value: try c.getString(key: "SALE_ORDER_REMARKYN"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ORD_DISC_EDITCOLS", value: try c.getString(key: "ORD_DISC_EDITCOLS"));
                
                 customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DRCALLPRODUCT_MANDATORYYN", value: try c.getString(key: "DRCALLPRODUCT_MANDATORYYN"));
                 customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CALLNA_AFTEREXPSUBMIT", value: try c.getString(key: "CALLNA_AFTEREXPSUBMIT"));
                
                 customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRSAMPLE_AFTERVISUALAIDYN", value: try c.getString(key: "DCRSAMPLE_AFTERVISUALAIDYN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CHEMCALL_RCPABUTTONYN", value: try c.getString(key: "CHEMCALL_RCPABUTTONYN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "MANUAL_TA",value: "0.0");
                
                 customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_VERSION", value: try c.getString(key: "VISUALAID_VERSION"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "API_TOKEN", value: try c.getString(key: "API_TOKEN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "API_URL_MOBILE", value: try c.getString(key: "API_URL_MOBILE"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRSUMMARYONFINALSUBMIT", value: try c.getString(key: "DCRSUMMARYONFINALSUBMIT"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "GEO_FANCING_KM_FOR", value: try c.getString(key: "GEO_FANCING_KM_FOR"));
                
                
            }
            
            cbohelp.deleteMenu();
            for i in 0 ..< jsonArray24.count {
                
                let c =  jsonArray24[i] as! [String : AnyObject]
                let menu = try c.getString(key: "MAIN_MENU")
                let menu_code = try c.getString(key: "MENU_CODE")
                let menu_name = try c.getString(key: "MENU_NAME")
                let menu_url = try c.getString(key: "URL")
                let main_menu_srno = try c.getString(key: "MAIN_MENU_SRNO")
                
                cbohelp.insertMenu(menu: menu, menu_code: menu_code, menu_name: menu_name, menu_url: menu_url, main_menu_srno: main_menu_srno)
                
            }

        }catch{
           customVariablesAndMethod.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription)
            
            let dataDict = ["Method Name":"Final Submit" , "Error Alert " : "Missing Field Error \n \(error.localizedDescription)"  ]
    
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "Missing Field Error", vc: self)
            
            objBroadcastErrorMail.requestAuthorization()
            
        }
    }



    @objc func pressedBack(){
        
        if (Back_allowed == ("Y")){
            myTopView.CloseCurruntVC(vc: self)
        } else {
            customVariablesAndMethod.getAlert(vc: context,title: "Please Submit",msg: "Please complete your Final Submit");
        }
        
    }
    
    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }
    
    // MARK:- final submit
    
    private func finalSubmitNew() {
        
        let fmcg_Live_Km = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self , key: "live_km" ,defaultValue: "" )
        
        var routeValue = "";
        routeValue  = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "root_needed", defaultValue: "N");
        
        var locExtra = "";
        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
        
        if (currentBestLocation != CLLocation()) {
            locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
        }
        
        if (fmcg_Live_Km == ("5") || fmcg_Live_Km.uppercased() == ("Y5")) {
            //         customMethod.stopAlarm10Sec();
            //            customMethod.stopAlarm10Minute();
            //           customMethod.backgroundData();
            //          dcr_latCommit = customMethod.dataToServer(null);
            
        }
        
        
        if ((dcr_latCommit.isEmpty) || (dcr_latCommit.count == 0)) {
            
            sb_DCRLATCOMMIT_KM = "";
            sb_DCRLATCOMMIT_LOC_LAT = "";
            sb_sDCRLATCOMMIT_IN_TIME = "";
            sDCRLATCOMMIT_ID = "";
            sDCRLATCOMMIT_LOC = "";
            
        } else {
            
            sb_DCRLATCOMMIT_KM = dcr_latCommit["sb_DCRLATCOMMIT_KM"]
            sb_DCRLATCOMMIT_LOC_LAT = dcr_latCommit["sb_DCRLATCOMMIT_LOC_LAT"]
            sb_sDCRLATCOMMIT_IN_TIME = dcr_latCommit["sb_sDCRLATCOMMIT_IN_TIME"]
            sDCRLATCOMMIT_ID = dcr_latCommit["sDCRLATCOMMIT_ID"]
            sDCRLATCOMMIT_LOC = dcr_latCommit["sDCRLATCOMMIT_LOC"]
            
        }
        
        dcr_Commit_rx = cboFinalTask_new.drRx_Save()
        
        if ((dcr_Commit_rx.isEmpty) || (dcr_Commit_rx.count == 0)) {
            
            sDCR_DR_RX = "";
            sDCR_ITM_RX = "";
            
        } else {
            
            sDCR_DR_RX = dcr_Commit_rx["sDCRRX_DR_ARR"]
            sDCR_ITM_RX = dcr_Commit_rx["sDCRRX_ITEMID_ARR"]
            
        }
        
        
        dcr_Commititem = cboFinalTask_new.drItemSave();
        if ((dcr_Commititem.isEmpty) || (dcr_Commititem.count == 0)) {
            
            sDCRITEM_DR_ID = "";
            sDCRITEM_ITEMIDIN = "";
            sDCRITEM_ITEM_ID_ARR = "";
            sDCRITEM_QTY_ARR = "";
            sDCRITEM_ITEM_ID_GIFT_ARR = "";
            sDCRITEM_QTY_GIFT_ARR = "";
            sDCRITEM_POB_QTY = "";
            sDCRITEM_POB_VALUE = "";
            sDCRITEM_VISUAL_ARR = "";
            sDCRITEM_NOC_ARR = "";
            DCRDR_RATE = "";
            
        } else {
            
            sDCRITEM_DR_ID = dcr_Commititem["sb_sDCRITEM_DR_ID"]
            sDCRITEM_ITEMIDIN = dcr_Commititem["sb_sDCRITEM_ITEMIDIN"]
            sDCRITEM_ITEM_ID_ARR = dcr_Commititem["sb_sDCRITEM_ITEM_ID_ARR"]
            sDCRITEM_QTY_ARR = dcr_Commititem["sb_sDCRITEM_QTY_ARR"]
            sDCRITEM_ITEM_ID_GIFT_ARR = dcr_Commititem["sb_sDCRITEM_ITEM_ID_GIFT_ARR"]
            sDCRITEM_QTY_GIFT_ARR = dcr_Commititem["sb_sDCRITEM_QTY_GIFT_ARR"]
            sDCRITEM_POB_QTY = dcr_Commititem["sb_sDCRITEM_POB_QTY"]
            sDCRITEM_POB_VALUE = dcr_Commititem["sb_sDCRITEM_POB_VALUE"]
            sDCRITEM_VISUAL_ARR = dcr_Commititem["sb_sDCRITEM_VISUAL_ARR"]
            sDCRITEM_NOC_ARR = dcr_Commititem["sb_sDCRITEM_NOC_ARR"]
            DCRDR_RATE = dcr_Commititem["sb_DCRDR_RATE"];
            
        }
        
        dcr_CommitDr = cboFinalTask_new.dcr_doctorSave();
        if ((dcr_CommitDr.isEmpty) || (dcr_CommitDr.count == 0)) {
            sDCRDR_DR_ID = "";
            sDCRDR_WW1 = "";
            sDCRDR_WW2 = "";
            sDCRDR_WW3 = "";
            sDCRDR_LOC = "";
            sDCRDR_IN_TIME = "";
            sDCRDR_BATTERY_PERCENT = "";
            sDCRDR_REMARK = "";
            sDCRDR_KM = "";
            sDCRDR_SRNO="";
            sDCRDR_FILE="";
            sDCRDR_CALLTYPE="";
            sDR_REF_LAT_LONG="";
        } else {
            
            sDCRDR_DR_ID = dcr_CommitDr["sb_sDCRDR_DR_ID"]
            sDCRDR_WW1 = dcr_CommitDr["sb_sDCRDR_WW1"]
            sDCRDR_WW2 = dcr_CommitDr["sb_sDCRDR_WW2"]
            sDCRDR_WW3 = dcr_CommitDr["sb_sDCRDR_WW3"]
            sDCRDR_LOC = dcr_CommitDr["sb_sDCRDR_LOC"]
            sDCRDR_IN_TIME = dcr_CommitDr["sb_sDCRDR_IN_TIME"]
            sDCRDR_BATTERY_PERCENT = dcr_CommitDr["sb_sDCRDR_BATTERY_PERCENT"]
            sDCRDR_REMARK = dcr_CommitDr["sb_sDCRDR_Remark"]
            sDCRDR_KM = dcr_CommitDr["sb_sDCRDR_KM"]
            sDCRDR_SRNO=dcr_CommitDr["sb_sDCRDR_SRNO"]
            sDCRDR_FILE=dcr_CommitDr["sb_sDCRDR_FILE"]
            sDCRDR_CALLTYPE=dcr_CommitDr["sb_sDCRDR_CALLTYPE"]
            sDR_REF_LAT_LONG = dcr_CommitDr["sb_sDR_REF_LAT_LONG"]
            
        }
        
        dcr_CommitChem_Reminder = cboFinalTask_new.dcr_ChemReminder();
        print("dcr_CommitChem_Reminder ", dcr_CommitChem_Reminder)
        
        if ((dcr_CommitChem_Reminder.isEmpty) || (dcr_CommitChem_Reminder.count == 0)) {

            sDCRRC_CHEM_ID = "";
            sDCRRC_LOC_CHEM = "";
            sDCRRC_IN_TIME_CHEM = "";
            sDCRRC_KM_CHEM = "";
            sDCRRC_SRNO_CHEM = "";
            sDCRRC_BATTERY_PERCENT_CHEM="";
            sDCRRC_REMARK_CHEM="";
            sDCRRC_FILE_CHEM="";
            sRC_REF_LAT_LONG_CHEM = "";
            
        } else {

            sDCRRC_CHEM_ID = dcr_CommitChem_Reminder["sb_sDCRRC_CHEM_ID"]
            sDCRRC_LOC_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_LOC_CHEM"]
            sDCRRC_IN_TIME_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_IN_TIME_CHEM"]
            sDCRRC_KM_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_KM_CHEM"]
            sDCRRC_SRNO_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_SRNO_CHEM"]
            sDCRRC_BATTERY_PERCENT_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_BATTERY_PERCENT_CHEM"]
            sDCRRC_REMARK_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_REMARK_CHEM"]
            sDCRRC_FILE_CHEM = dcr_CommitChem_Reminder["sb_sDCRRC_FILE_CHEM"]
            sRC_REF_LAT_LONG_CHEM = dcr_CommitChem_Reminder["sb_sRC_REF_LAT_LONG_CHEM"]
            
        }
        
        dcr_ChemistCommit = cboFinalTask_new.dcr_chemSave();
        if ((dcr_ChemistCommit.isEmpty) || (dcr_ChemistCommit.count == 0)) {
            sDCRCHEM_CHEM_ID = "";
            sDCRCHEM_POB_QTY = "";
            sDCRCHEM_POB_AMT = "";
            sDCRCHEM_ITEM_ID_ARR = "";
            sDCRCHEM_QTY_ARR = "";
            sDCRCHEM_LOC = "";
            sDCRCHEM_IN_TIME = "";
            sDCRCHEM_SQTY_ARR = "";
            sDCRCHEM_ITEM_ID_GIFT_ARR = "";
            sDCRCHEM_QTY_GIFT_ARR = "";
            sDCRCHEM_BATTERY_PERCENT = "";
            sDCRCHEM_KM = "";
            sDCRCHEM_SRNO="";
            sDCRCHEM_REMARK="";
            sDCRCHEM_FILE="";
            sCHEM_REF_LAT_LONG="";
            DCRCHEM_RATE = "";
            
            sCHEM_STATUS="";
            sCOMPETITOR_REMARK="";
            
        } else {
            sDCRCHEM_CHEM_ID = dcr_ChemistCommit["sb_sDCRCHEM_CHEM_ID"]
            sDCRCHEM_POB_QTY = dcr_ChemistCommit["sb_sDCRCHEM_POB_QTY"]
            sDCRCHEM_POB_AMT = dcr_ChemistCommit["sb_sDCRCHEM_POB_AMT"]
            sDCRCHEM_ITEM_ID_ARR = dcr_ChemistCommit["sb_sDCRCHEM_ITEM_ID_ARR"]
            sDCRCHEM_QTY_ARR = dcr_ChemistCommit["sb_sDCRCHEM_QTY_ARR"]
            sDCRCHEM_LOC = dcr_ChemistCommit["sb_sDCRCHEM_LOC"]
            sDCRCHEM_IN_TIME = dcr_ChemistCommit["sb_sDCRCHEM_IN_TIME"]
            sDCRCHEM_SQTY_ARR = dcr_ChemistCommit["sb_sDCRCHEM_SQTY_ARR"]
            sDCRCHEM_ITEM_ID_GIFT_ARR = dcr_ChemistCommit["sb_sDCRCHEM_ITEM_ID_GIFT_ARR"]
            sDCRCHEM_QTY_GIFT_ARR = dcr_ChemistCommit["sb_sDCRCHEM_QTY_GIFT_ARR"]
            sDCRCHEM_BATTERY_PERCENT = dcr_ChemistCommit["sb_sDCRCHEM_BATTERY_PERCENT"]
            sDCRCHEM_KM = dcr_ChemistCommit["sb_sDCRCHEM_KM"]
            sDCRCHEM_SRNO=dcr_ChemistCommit["sb_sDCRCHEM_SRNO"]
            sDCRCHEM_REMARK = dcr_ChemistCommit["sb_sDCRCHEM_REMARK"]
            sDCRCHEM_FILE = dcr_ChemistCommit["sb_sDCRCHEM_FILE"]
            sCHEM_REF_LAT_LONG = dcr_ChemistCommit["sb_sCHEM_REF_LAT_LONG"]
            DCRCHEM_RATE = dcr_ChemistCommit["sb_DCRCHEM_RATE"];
            
            sCHEM_STATUS = dcr_ChemistCommit["sCHEM_STATUS"]!
            sCOMPETITOR_REMARK = dcr_ChemistCommit["sCOMPETITOR_REMARK"]!
        }
        
        
        dcr_StkCommit = cboFinalTask_new.dcr_stkSave()
        if ((dcr_StkCommit.isEmpty) || (dcr_StkCommit.count == 0)) {
            
            sDCRSTK_STK_ID = "";
            
            sDCRSTK_POB_QTY = "";
            sDCRSTK_POB_AMT = "";
            sDCRSTK_ITEM_ID_ARR = "";
            sDCRSTK_QTY_ARR = "";
            sDCRSTK_LOC = "";
            sDCRSTK_IN_TIME = "";
            sDCRSTK_SQTY_ARR = "";
            sDCRSTK_ITEM_ID_GIFT_ARR = "";
            sDCRSTK_QTY_GIFT_ARR = "";
            sDCRSTK_BATTERY_PERCENT = "";
            sDCRSTK_KM = "";
            sDCRSTK_SRNO = "";
            sDCRSTK_REMARK="";
            sDCRSTK_FILE="";
            sSTK_REF_LAT_LONG="";
            DCRSTK_RATE = "";
            
        } else {
            sDCRSTK_STK_ID = dcr_StkCommit["sb_sDCRSTK_STK_ID"]!
            sDCRSTK_POB_QTY = dcr_StkCommit["sb_sDCRSTK_POB_QTY"]!
            sDCRSTK_POB_AMT = dcr_StkCommit["sb_sDCRSTK_POB_AMT"]!
            sDCRSTK_ITEM_ID_ARR = dcr_StkCommit["sb_sDCRSTK_ITEM_ID_ARR"]!
            sDCRSTK_QTY_ARR = dcr_StkCommit["sb_sDCRSTK_QTY_ARR"]!
            sDCRSTK_LOC = dcr_StkCommit["sb_sDCRSTK_LOC"]!
            sDCRSTK_IN_TIME = dcr_StkCommit["sb_sDCRSTK_IN_TIME"]!
            sDCRSTK_SQTY_ARR = dcr_StkCommit["sb_sDCRSTK_SQTY_ARR"]!
            sDCRSTK_ITEM_ID_GIFT_ARR = dcr_StkCommit["sb_sDCRSTK_ITEM_ID_GIFT_ARR"]!
            sDCRSTK_QTY_GIFT_ARR = dcr_StkCommit["sb_sDCRSTK_QTY_GIFT_ARR"]!
            sDCRSTK_BATTERY_PERCENT = dcr_StkCommit["sb_sDCRSTK_BATTERY_PERCENT"]!
            sDCRSTK_KM = dcr_StkCommit["sb_sDCRSTK_KM"]!
            sDCRSTK_SRNO = dcr_StkCommit["sb_sDCRSTK_SRNO"]!
            sDCRSTK_REMARK = dcr_StkCommit["sb_sDCRSTK_REMARK"]!
            sDCRSTK_FILE = dcr_StkCommit["sb_sDCRSTK_FILE"]!
            sSTK_REF_LAT_LONG = dcr_StkCommit["sb_sSTK_REF_LAT_LONG"]
            DCRSTK_RATE = dcr_StkCommit["sb_DCRSTK_RATE"]
        }
        
        
        dcr_CommitDr_Reminder = cboFinalTask_new.dcr_DrReminder()
        if ((dcr_CommitDr_Reminder.isEmpty) || (dcr_CommitDr_Reminder.count  == 0)) {
            
            sDCRRC_IN_TIME = "";
            sDCRRC_LOC = "";
            sDCRRC_DR_ID = "";
            sDCRRC_KM = "";
            sDCRRC_SRNO = "";
            sDCRRC_BATTERY_PERCENT="";
            sDCRRC_REMARK="";
            sDCRRC_FILE="";
            sRC_REF_LAT_LONG="";
            
        } else {
            
            sDCRRC_DR_ID = dcr_CommitDr_Reminder["sb_sDCRRC_DR_ID"]!
            sDCRRC_LOC = dcr_CommitDr_Reminder["sb_sDCRRC_LOC"]!
            sDCRRC_IN_TIME = dcr_CommitDr_Reminder["sb_sDCRRC_IN_TIME"]!
            sDCRRC_KM = dcr_CommitDr_Reminder["sb_sDCRRC_KM"]!
            sDCRRC_SRNO = dcr_CommitDr_Reminder["sb_sDCRRC_SRNO"]!
            sDCRRC_BATTERY_PERCENT = dcr_CommitDr_Reminder["sb_sDCRRC_BATTERY_PERCENT"]!
            sDCRRC_REMARK=dcr_CommitDr_Reminder["sb_sDCRRC_REMARK"]!
            sDCRRC_FILE=dcr_CommitDr_Reminder["sb_sDCRRC_FILE"]!
            sRC_REF_LAT_LONG = dcr_CommitDr_Reminder["sb_sRC_REF_LAT_LONG"]
            
        }
        
        Lat_Long_Reg = cboFinalTask_new.get_Lat_Long_Reg(updated: "0")
        if ((Lat_Long_Reg.isEmpty) || (Lat_Long_Reg.count == 0)) {
            
            DCS_ID_ARR = "";
            LAT_LONG_ARR = "";
            DCS_TYPE_ARR = "";
            DCS_ADD_ARR = "";
            DCS_INDES_ARR = "";
            
        } else {
            
            DCS_ID_ARR = Lat_Long_Reg["DCS_ID_ARR"]
            LAT_LONG_ARR = Lat_Long_Reg["LAT_LONG_ARR"]
            DCS_TYPE_ARR = Lat_Long_Reg["DCS_TYPE_ARR"]
            DCS_ADD_ARR = Lat_Long_Reg["DCS_ADD_ARR"]
            DCS_INDES_ARR = Lat_Long_Reg["DCS_INDES_ARR"]
            
        }
        
        
        dcr_Dairy = cboFinalTask_new.get_phdairy_dcr();
        
        
        if ((dcr_Dairy.isEmpty) || (dcr_Dairy.count == 0)) {
            
            sDAIRY_ID = "";
            sSTRDAIRY_CPID = "";
            sDCRDAIRY_LOC = "";
            sDCRDAIRY_IN_TIME = "";
            sDCRDAIRY_BATTERY_PERCENT = "";
            sDCRDAIRY_REMARK = "";
            sDCRDAIRY_KM = "";
            sDCRDAIRY_SRNO = "";
            sDCRDAIRYITEM_DAIRY_ID = "";
            sDCRDAIRYITEM_ITEM_ID_ARR = "";
            sDCRDAIRYITEM_QTY_ARR = "";
            sDCRDAIRYITEM_ITEM_ID_GIFT_ARR = "";
            sDCRDAIRYITEM_QTY_GIFT_ARR = "";
            sDCRDAIRYITEM_POB_QTY = "";
            sDAIRY_FILE = "";
            sDCRDAIRY_INTERSETEDYN = "";
            sDAIRY_REF_LAT_LONG = "";
        } else {
            
            sDAIRY_ID = dcr_Dairy["sDAIRY_ID"]
            sSTRDAIRY_CPID  = dcr_Dairy["sSTRDAIRY_CPID"]
            sDCRDAIRY_LOC  = dcr_Dairy["sDCRDAIRY_LOC"]
            sDCRDAIRY_IN_TIME = dcr_Dairy["sDCRDAIRY_IN_TIME"]
            sDCRDAIRY_BATTERY_PERCENT = dcr_Dairy["sDCRDAIRY_BATTERY_PERCENT"]
            sDCRDAIRY_REMARK = dcr_Dairy["sDCRDAIRY_REMARK"]
            sDCRDAIRY_KM = dcr_Dairy["sDCRDAIRY_KM"]
            sDCRDAIRY_SRNO = dcr_Dairy["sDCRDAIRY_SRNO"]
            sDCRDAIRYITEM_DAIRY_ID = dcr_Dairy["sDAIRY_ID"]
            sDCRDAIRYITEM_ITEM_ID_ARR = dcr_Dairy["sDCRDAIRYITEM_ITEM_ID_ARR"]
            sDCRDAIRYITEM_QTY_ARR = dcr_Dairy["sDCRDAIRYITEM_QTY_ARR"]
            sDCRDAIRYITEM_ITEM_ID_GIFT_ARR = dcr_Dairy["sDCRDAIRYITEM_ITEM_ID_GIFT_ARR"]
            sDCRDAIRYITEM_QTY_GIFT_ARR = dcr_Dairy["sDCRDAIRYITEM_QTY_GIFT_ARR"]
            sDCRDAIRYITEM_POB_QTY = dcr_Dairy["sDCRDAIRYITEM_POB_QTY"]
            sDAIRY_FILE = dcr_Dairy["sDAIRY_FILE"]
            sDCRDAIRY_INTERSETEDYN = dcr_Dairy["sDCRDAIRY_INTERSETEDYN"]
            sDAIRY_REF_LAT_LONG = dcr_Dairy["sDAIRY_REF_LAT_LONG"]
        }
        //customMethod.getDataFromFromAllTables(]
        //sFinalKm = mycon.getDataFrom_FMCG_PREFRENCE("final_km");
        // ArrayList<String> array=customMethod.kmWithWayPoint();
        sFinalKm = "0"; // array[0);
        let sAPI_Pattern="0"  // array[1);
        
        if (Custom_Variables_And_Method.DCR_ID == ("0")) {
            
            Custom_Variables_And_Method.DCR_ID = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self , key: "DCR_ID", defaultValue:  "" );
        }
        
        var ACTUALFARE=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self , key: "ACTUALFARE" , defaultValue: "")
        
        if (ACTUALFARE == ""){
            ACTUALFARE = "0"
        }
            
            Custom_Variables_And_Method.GCMToken=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self , key :"GCMToken", defaultValue: "")
            
            customVariablesAndMethod.getBatteryLevel()
        
            var request = [String : String]()
            
            request["sCompanyFolder"] = cbohelp.getCompanyCode()
            request["iDcrId"] = "" + Custom_Variables_And_Method.DCR_ID
            request["iNoChemist"] = "1"
            request["iNoStockist"] = "1"
            request["sChemistRemark"] = ""
            request["sStockistREmark"] = ""
            request["iPob"] = "0.0"
            request["iPobQty"] = "0"
            request["iActualFareAmt"] = ACTUALFARE
            request["sDatype"] = "NA"
            request["iDistanceId"] = "99999"
            
            request["sRemark"] = mRemark
            
            request["sLoc"] = Custom_Variables_And_Method.GLOBAL_LATLON + "@" + locExtra + "!^" + address //mLatLong +"@"+locExtra+ "!^" + mAddress
            request["iOuttime"] = "99"
            
            request["sRouteYn"] = routeValue
            
            request["sDCRLATCOMMIT_ID"] = sDCRLATCOMMIT_ID
            request["sDCRLATCOMMIT_IN_TIME"] = sb_sDCRLATCOMMIT_IN_TIME
            request["sDCRLATCOMMIT_LOC_LAT"] = sb_DCRLATCOMMIT_LOC_LAT
            request["sDCRLATCOMMIT_LOC"] = sDCRLATCOMMIT_LOC
            request["sDCRLATCOMMIT_KM"] = sb_DCRLATCOMMIT_KM
            
            request["sDCRITEM_DR_ID"] = sDCRITEM_DR_ID
            request["sDCRITEM_ITEMIDIN"] = sDCRITEM_ITEMIDIN
            request["sDCRITEM_ITEM_ID_ARR"] = sDCRITEM_ITEM_ID_ARR
            request["sDCRITEM_QTY_ARR"] = sDCRITEM_QTY_ARR
            request["sDCRITEM_ITEM_ID_GIFT_ARR"] = sDCRITEM_ITEM_ID_GIFT_ARR
            request["sDCRITEM_QTY_GIFT_ARR"] = sDCRITEM_QTY_GIFT_ARR
            
            request["sDCRITEM_POB_QTY"] = sDCRITEM_POB_QTY
            request["sDCRITEM_POB_VALUE"] = sDCRITEM_POB_VALUE
            request["sDCRITEM_VISUAL_ARR"] = sDCRITEM_VISUAL_ARR
            request["sDCRITEM_NOC_ARR"] = sDCRITEM_NOC_ARR
            
            request["sDCRDR_DR_ID"] = sDCRDR_DR_ID
            request["sDCRDR_WW1"] = sDCRDR_WW1
            request["sDCRDR_WW2"] = sDCRDR_WW2
            request["sDCRDR_WW3"] = sDCRDR_WW3
            request["sDCRDR_LOC"] = sDCRDR_LOC
            request["sDCRDR_IN_TIME"] = sDCRDR_IN_TIME
            request["sDCRDR_BATTERY_PERCENT"] = sDCRDR_BATTERY_PERCENT
            request["sDCRDR_REMARK"] = sDCRDR_REMARK
            request["sDCRDR_KM"] = sDCRDR_KM
            request["sDCRDR_SRNO"] = sDCRDR_SRNO
            request["sDCRDR_FILE"] = sDCRDR_FILE
            request["sDCRDR_CALLTYPE"] = sDCRDR_CALLTYPE
            
            
            request["sDCRRC_CHEM_ID"] = sDCRRC_CHEM_ID
            request["sDCRRC_LOC_CHEM"] = sDCRRC_LOC_CHEM
            request["sDCRRC_IN_TIME_CHEM"] = sDCRRC_IN_TIME_CHEM
            request["sDCRRC_KM_CHEM"] = sDCRRC_KM_CHEM
            request["sDCRRC_SRNO_CHEM"] = sDCRRC_SRNO_CHEM
            request["sDCRRC_BATTERY_PERCENT_CHEM"] = sDCRRC_BATTERY_PERCENT_CHEM
            request["sDCRRC_REMARK_CHEM"] = sDCRRC_REMARK_CHEM
            request["sDCRRC_FILE_CHEM"] = sDCRRC_FILE_CHEM
            request["sRC_REF_LAT_LONG_CHEM"] = sRC_REF_LAT_LONG_CHEM
            
            request["sDCRCHEM_CHEM_ID"] = sDCRCHEM_CHEM_ID
            request["sDCRCHEM_POB_QTY"] = sDCRCHEM_POB_QTY
            request["sDCRCHEM_POB_AMT"] = sDCRCHEM_POB_AMT
            request["sDCRCHEM_ITEM_ID_ARR"] = sDCRCHEM_ITEM_ID_ARR
            request["sDCRCHEM_QTY_ARR"] = sDCRCHEM_QTY_ARR
            request["sDCRCHEM_LOC"] = sDCRCHEM_LOC
            request["sDCRCHEM_IN_TIME"] = sDCRCHEM_IN_TIME
            request["sDCRCHEM_SQTY_ARR"] = sDCRCHEM_SQTY_ARR
            request["sDCRCHEM_ITEM_ID_GIFT_ARR"] = sDCRCHEM_ITEM_ID_GIFT_ARR
            request["sDCRCHEM_QTY_GIFT_ARR"] = sDCRCHEM_QTY_GIFT_ARR
            request["sDCRCHEM_BATTERY_PERCENT"] = sDCRCHEM_BATTERY_PERCENT
            request["sDCRCHEM_KM"] = sDCRCHEM_KM
            request["sDCRCHEM_SRNO"] = sDCRCHEM_SRNO
            request["sDCRCHEM_REMARK"] = sDCRCHEM_REMARK
            request["sDCRCHEM_FILE"] = sDCRCHEM_FILE
            
            
            request["sDCRSTK_STK_ID"] = sDCRSTK_STK_ID
            request["sDCRSTK_POB_QTY"] = sDCRSTK_POB_QTY
            request["sDCRSTK_POB_AMT"] = sDCRSTK_POB_AMT
            request["sDCRSTK_ITEM_ID_ARR"] = sDCRSTK_ITEM_ID_ARR
            request["sDCRSTK_QTY_ARR"] = sDCRSTK_QTY_ARR
            request["sDCRSTK_LOC"] = sDCRSTK_LOC
            request["sDCRSTK_IN_TIME"] = sDCRSTK_IN_TIME
            request["sDCRSTK_SQTY_ARR"] = sDCRSTK_SQTY_ARR
            request["sDCRSTK_ITEM_ID_GIFT_ARR"] = sDCRSTK_ITEM_ID_GIFT_ARR
            request["sDCRSTK_QTY_GIFT_ARR"] = sDCRSTK_QTY_GIFT_ARR
            request["sDCRSTK_BATTERY_PERCENT"] = sDCRSTK_BATTERY_PERCENT
            request["sDCRSTK_KM"] = sDCRSTK_KM
            request["sDCRSTK_SRNO"] = sDCRSTK_SRNO
            request["sDCRSTK_REMARK"] = sDCRSTK_REMARK
            request["sDCRSTK_FILE"] = sDCRSTK_FILE
            
            request["sDCRRC_DR_ID"] = sDCRRC_DR_ID
            request["sDCRRC_LOC"] = sDCRRC_LOC
            request["sDCRRC_IN_TIME"] = sDCRRC_IN_TIME
            request["sDCRRC_KM"] = sDCRRC_KM
            request["sDCRRC_SRNO"] = sDCRRC_SRNO
            request["sDCRRC_BATTERY_PERCENT"] = sDCRRC_BATTERY_PERCENT
            request["sDCRRC_REMARK"] = sDCRRC_REMARK
            request["sDCRRC_FILE"] = sDCRRC_FILE
            
            
            
            request["sDCRRX_DR_ARR"] = sDCR_DR_RX
            request["sDCRRX_ITEMID_ARR"] = sDCR_ITM_RX
            
            request["iFinalKM"] = sFinalKm
            request["iPaId"] = "\(PA_ID)"
            
            request["sGCM_TOKEN"] = Custom_Variables_And_Method.GCMToken
            request["sAPI_PATTERN"] = sAPI_Pattern
            request["sBATTERY_PERCENT"] = Custom_Variables_And_Method.BATTERYLEVEL
            
            request["REG_ID_ARR"] = DCS_ID_ARR
            request["REG_LAT_LONG_ARR"] = LAT_LONG_ARR
            request["REG_TYPE_ARR"] = DCS_TYPE_ARR
            request["REG_ADD_ARR"] = DCS_ADD_ARR
            request["REG_INDES_ARR"] = DCS_INDES_ARR
            
            
            request["sDAIRY_ID"] = sDAIRY_ID
            request["sSTRDAIRY_CPID"] = sSTRDAIRY_CPID
            request["sDCRDAIRY_LOC"] = sDCRDAIRY_LOC
            request["sDCRDAIRY_IN_TIME"] = sDCRDAIRY_IN_TIME
            request["sDCRDAIRY_BATTERY_PERCENT"] = sDCRDAIRY_BATTERY_PERCENT
            
            
            request["sDCRDAIRY_REMARK"] = sDCRDAIRY_REMARK
            request["sDCRDAIRY_KM"] =  sDCRDAIRY_KM
            
            request["sDCRDAIRY_SRNO"] = sDCRDAIRY_SRNO
            request["sDCRDAIRYITEM_DAIRY_ID"] = sDCRDAIRYITEM_DAIRY_ID
            request["sDCRDAIRYITEM_ITEM_ID_ARR"] = sDCRDAIRYITEM_ITEM_ID_ARR
            request["sDCRDAIRYITEM_QTY_ARR"] = sDCRDAIRYITEM_QTY_ARR
            request["sDCRDAIRYITEM_ITEM_ID_GIFT_ARR"] = sDCRDAIRYITEM_ITEM_ID_GIFT_ARR
            request["sDCRDAIRYITEM_QTY_GIFT_ARR"] = sDCRDAIRYITEM_QTY_GIFT_ARR
            request["sDCRDAIRYITEM_POB_QTY"] =  sDCRDAIRYITEM_POB_QTY
            request["sDAIRY_FILE"] = sDAIRY_FILE
            request["sDCRDAIRY_INTERSETEDYN"] = sDCRDAIRY_INTERSETEDYN
        
        
            request["SDCR_DATE"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DATE",defaultValue: "")
            request["sDR_REF_LAT_LONG"] = sDR_REF_LAT_LONG
            request["sCHEM_REF_LAT_LONG"] = sCHEM_REF_LAT_LONG
            request["sSTK_REF_LAT_LONG"] = sSTK_REF_LAT_LONG
            request["sDAIRY_REF_LAT_LONG"] =  sDAIRY_REF_LAT_LONG
            request["sRC_REF_LAT_LONG"] =  sRC_REF_LAT_LONG
        
        
        
            request["DCRSTK_RATE"] =  DCRSTK_RATE
            request["DCRDR_RATE"] =  DCRDR_RATE
            request["DCRCHEM_RATE"] =  DCRCHEM_RATE
        
            request["sCHEM_STATUS"] = sCHEM_STATUS
            request["sCOMPETITOR_REMARK"] = sCOMPETITOR_REMARK
        
        
            request["aDCRDRRX_DOC_DATE"] = ""
            request["aDCRDRRX_DR_ID"] = ""
            request["aDCRDRRX_ITEM_ID"] = ""
            request["aDCRDRRX_QTY"] = ""
            request["aDCRDRRX_AMOUNT"] = ""
            request["ISSUPPORTLOGIN"] = ""
        
            var tables = [Int]()
            tables.append(-1)
            
            progressHUD.show(text: "Please wait ...\n Checking your DCR Status" )
            
            
            CboServices().customMethodForAllServices(params: request, methodName: "DCRCommitFinal_New_23", tables: tables, response_code: MESSAGE_INTERNET_FINAL_SUBMIT, vc : context )
            
            //  commitDialog = new ProgressDialog(FinalSubmitDcr_new.this);
            //    commitDialog.setMessage("Please Wait..");
            //    commitDialog.setCanceledOnTouchOutside(false);
            //    commitDialog.setCancelable(false);
            // commitDialog.show();
            
            
            // new CboServices(this, mHandler).customMethodForAllServices(request, "DCRCommitFinal_New_14", MESSAGE_INTERNET_FINAL_SUBMIT, tables);
            
            //End of call to service
            
        
    }
    
    
    
}

