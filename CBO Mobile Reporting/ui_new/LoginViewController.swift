//
//  LoginViewController.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 13/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
class LoginViewController: CustomUIViewController  {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var mainView: UIView!
    var progressHUD :  ProgressHUD!
 
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    let cbohelp : CBO_DB_Helper  = CBO_DB_Helper.shared
    var company_code : String!
    var pin : String!
    var mylog : String!
    var mypass : String!
    var replyMsg = [String:[String : AnyObject]]()
    @IBOutlet weak var myView: UIView!
    let objApi = CboServices()
    //textFields
    var a : Int!
    @IBOutlet weak var scrollViewHeght: NSLayoutConstraint!
    @IBOutlet weak var tfCompanyName: CustomeUITextField!
    @IBOutlet weak var tfUserId: CustomeUITextField!
    @IBOutlet weak var tfPassword: CustomeUITextField!
    @IBOutlet weak var tfEnterPin: CustomeUITextField!
    @IBOutlet weak var tfReEnterPin: CustomeUITextField!
    let INTERNET_MSG_LOGIN = 1
    let MESSAGE_INTERNET_UTILITES=2
    
    
    @IBAction func pressedLoginButton(_ sender: CustomeUIButton) {
        allAlertHidden()
        checkValidations()
    }
    
    func checkValidations(){
        if (tfCompanyName.text?.isEmpty)!{
            customVariablesAndMethod.msgBox(vc: self, msg: "Enter Company Code..")
//            alertComapnyName.isHidden = false
        }else if (tfUserId.text?.isEmpty)!{
            customVariablesAndMethod.msgBox(vc: self, msg: "Enter User Id..")
//            alertUserId.isHidden = false
        }else if (tfPassword .text?.isEmpty)!{
            customVariablesAndMethod.msgBox(vc: self, msg: "Enter Password...")
//            alertPassword.isHidden = false
        }else if (tfEnterPin.text?.isEmpty)! {
            customVariablesAndMethod.msgBox(vc: self, msg: "Enter Pin...")
//            alertEnterPin.isHidden = false
        }else if (tfReEnterPin.text?.isEmpty)!{
            customVariablesAndMethod.msgBox(vc: self, msg: "Conform your Pin")
//            alertReEnterPin.isHidden = false
        }else if (tfReEnterPin.text != tfEnterPin.text){
            customVariablesAndMethod.msgBox(vc: self, msg: "Check your Pin \nPin does not match...")
            //            alertReEnterPin.isHidden = false
        } else {
            checkPin()
        }
        
    }
    
    func checkPin()
    {
        if tfEnterPin.text == tfReEnterPin.text{
            
            company_code = tfCompanyName.text!
            mylog = tfUserId.text!
            pin = tfEnterPin.text!
            mypass = tfPassword.text!
            
            Custom_Variables_And_Method.COMPANY_CODE = company_code
            Custom_Variables_And_Method.user_name = tfUserId.text
            
            cbohelp.deleteLoginDetail();
            cbohelp.deleteDoctorItemPrescribe();
            cbohelp.deleteUserDetail();
            cbohelp.deleteUserDetail2();
            cbohelp.deleteMenu();
            cbohelp.deleteResigned();
            cbohelp.deleteDoctorItem();
            cbohelp.deleteFinalDcr();
            cbohelp.deleteDCRDetails();
            cbohelp.deletedcrFromSqlite();
            cbohelp.deleteTempChemist();
            cbohelp.deleteChemistSample();
            cbohelp.deleteChemistRecordsTable();
            cbohelp.deleteStockistRecordsTable();
            cbohelp.deleteTempStockist();
            cbohelp.deleteTempDr();
            cbohelp.deleteDoctorRc();
            cbohelp.deleteDoctor();
            cbohelp.deleteDoctormore();
            
            cbohelp.delete_phitem();
            cbohelp.delete_phdoctoritem();
            //cbohelper.delete_phdoctor();
            cbohelp.delete_phallmst();
            cbohelp.delete_phparty();
            cbohelp.delete_phrelation();
            cbohelp.delete_phitemspl();
            cbohelp.deleteFTPTABLE();
            
            
            cbohelp.delete_Expense();
            cbohelp.delete_Nonlisted_calls();
            cbohelp.deleteDcrAppraisal();
            cbohelp.delete_tenivia_traker();
            cbohelp.notificationDeletebyID(id:"");
            cbohelp.delete_Lat_Long_Reg();
            
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self,key : "DCR_ID");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key : "DcrPlantime");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key :"D_DR_RX_VISITED");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key :"CHEMIST_NOT_VISITED");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key :"STOCKIST_NOT_VISITED");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key :"dcr_date_real");
            customVariablesAndMethod.deleteFmcg_ByKey(vc : self, key :"Dcr_Planed_Date");
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "DA_TYPE", value: "0");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "da_val", value : "0");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self ,key :"distance_val", value : "0");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self ,key : "CALL_UNLOCK_STATUS",value : "");
            
            
            //cbohelp.close();
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self ,key : "WEBSERVICE_URL",value : "");

            
            
            Login()
        }else{
            alertEnterPin.isHidden = false
            alertReEnterPin.isHidden = false
        }
    }
    
    // submit data
    func Login() {
        
        if(customVariablesAndMethod.internetConneted(context: self)){
            Custom_Variables_And_Method.GCMToken = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "GCMToken", defaultValue: "");

            let methodName = "LOGIN_MOBILE_2"
            var params = [String:String]()
            params["sCompanyFolder"]  = tfCompanyName.text!
            params["USERNAME"] = tfUserId.text!
            params["PASSWORD"] = tfPassword.text!
            params["MobileID"] = customVariablesAndMethod.getDeviceInfo()
            params["MobileVersion"]  = Custom_Variables_And_Method.VERSION
            params["GCM_TOCKEN"]  = Custom_Variables_And_Method.GCMToken
            
            let tables = [-1]
            // avoid deadlocks by not using .main queue here
            
            
            progressHUD.show(text: "Please Wait...\nVerifying your Login Details")
            
            
            self.objApi.customMethodForAllServices(params: params, methodName: methodName, tables: tables, response_code: INTERNET_MSG_LOGIN, vc : self)
            
        }
    
    }
    
   
    
    //alerts _____________________________________________________
    
    @IBOutlet weak var alertComapnyName: UIImageView!
    @IBOutlet weak var alertUserId: UIImageView!
    @IBOutlet weak var alertPassword: UIImageView!
    @IBOutlet weak var alertEnterPin: UIImageView!
    @IBOutlet weak var alertReEnterPin: UIImageView!
    
    func allAlertHidden()
    {
//        alertComapnyName.isHidden = true
//        alertUserId.isHidden = true
//        alertPassword.isHidden = true
//        alertEnterPin.isHidden = true
//        alertReEnterPin.isHidden = true
    }
    
    
   // var keyboardHeight : CGFloat!
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if(cbohelp.getCOMP_NAME() != "-1"){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainstoryboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainstoryboard.instantiateViewController(withIdentifier: "FakeLoginViewController") as! FakeLoginViewController
            appDelegate.window?.rootViewController = vc
            self.dismiss(animated: true, completion: nil)
        }else{
            let img = UIImage(named: "login_bg.png")
            self.myView.layer.contents = img?.cgImage
            progressHUD = ProgressHUD(vc : self )
            allAlertHidden()
            manageView(manage: false)
            customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
            
            print(cbohelp.getPaid())
        }
        
    }
    
    
    // viewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
           
        
    }
    
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        switch response_code {
                    case INTERNET_MSG_LOGIN:
                        parser_login( dataFromAPI  : dataFromAPI)
                        
                        break
                    case MESSAGE_INTERNET_UTILITES:
                        parser_utilites( dataFromAPI  : dataFromAPI)
                        break
                    case 99:
                        progressHUD.dismiss()
                        customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
                        break
                    default:
                        progressHUD.dismiss()
                        print("Error")
                    }
    }
    
    func parser_login(dataFromAPI :[ String :NSArray]){
//        print(dataFromAPI)
        
        // table 0-3 for login
        // table 4-8 for future use
        // table 9-10 for getDCRID
        

        let jsonArray0 = dataFromAPI["Tables0"]
        let jsonObject0 = jsonArray0![0] as! [String: AnyObject]
        if jsonObject0["STATUS"] as! String == "Y" {
            process_login_data (dataFromAPI: dataFromAPI )
        }
        else{
            progressHUD.dismiss()
            customVariablesAndMethod.getAlert(vc: self, title: "Alert", msg: (jsonObject0["STATUS"] as! String) )
        }
       
    }
    
    private func process_login_data(dataFromAPI :[ String : NSArray])  {

    //for login
    if (!dataFromAPI.isEmpty ) {

        let jsonArray0 = dataFromAPI["Tables0"]!
        for k in 0 ..< jsonArray0.count {
            let jsonObject0 = jsonArray0[k] as! [String: AnyObject]
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key :"UAN_NO", value : jsonObject0["UAN_NO"] as! String)
            Custom_Variables_And_Method.PA_ID = Custom_Variables_And_Method.getIntValue(value: jsonObject0["PA_ID"] as! String)
            Custom_Variables_And_Method.PA_NAME = jsonObject0["PA_NAME"] as! String
            Custom_Variables_And_Method.HEAD_QTR = jsonObject0["HEAD_QTR"] as! String
            Custom_Variables_And_Method.DESIG = jsonObject0["DESIG"] as! String
            Custom_Variables_And_Method.pub_desig_id = jsonObject0["DESIG_ID"] as! String
            Custom_Variables_And_Method.COMPANY_NAME = jsonObject0["COMPANY_NAME"] as! String
            Custom_Variables_And_Method.WEB_URL = jsonObject0["WEB_URL"] as! String

            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key :"FM_PA_ID", value : jsonObject0["PA_ID"] as! String)

            cbohelp.insertUserDetails(paid: String(Custom_Variables_And_Method.PA_ID)  , paname: Custom_Variables_And_Method.PA_NAME, hqtr: Custom_Variables_And_Method.HEAD_QTR, desid: Custom_Variables_And_Method.DESIG, pubdesid: Custom_Variables_And_Method.pub_desig_id, compname: Custom_Variables_And_Method.COMPANY_NAME, weburl: Custom_Variables_And_Method.WEB_URL)

        }

        let jsonArray1 = dataFromAPI["Tables1"]!
        for k in 0 ..< jsonArray1.count {
            let jsonObject1 = jsonArray1[k] as! [String: AnyObject]
            
            Custom_Variables_And_Method.location_required = jsonObject1["LOCATION_REQUIRED"] as! String
            Custom_Variables_And_Method.VISUAL_REQUIRED = jsonObject1["show_visual_aid"] as! String
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self, key: "VisualAid_YN", value: jsonObject1["show_visual_aid"] as! String)
            cbohelp.insertUserDetail22(loc: Custom_Variables_And_Method.location_required, visual: Custom_Variables_And_Method.VISUAL_REQUIRED)

        }

        //for getDCRID

//        let table9 = dataFromAPI["Tables9"]![0]
        
        let jsonArray9 = dataFromAPI["Tables9"]!
        for k in 0 ..< jsonArray9.count {
            let jsonObject9 = jsonArray9[k] as! [String: AnyObject]
        
//        JSONArray jsonArray10 = new JSONArray(table9);
//        for (int k = 0; k < jsonArray10.length(); k++) {
//        JSONObject obj = jsonArray10.getJSONObject(k);


        Custom_Variables_And_Method.DCR_ID = jsonObject9["DCR_ID"] as! String
        Custom_Variables_And_Method.pub_area = jsonObject9["AREA"] as! String
        Custom_Variables_And_Method.WORKING_TYPE = "Working";
        cbohelp.insertDcrDetails(dcrid: Custom_Variables_And_Method.DCR_ID, pubarea: Custom_Variables_And_Method.pub_area);
        cbohelp.putDcrId(dcrid:  Custom_Variables_And_Method.DCR_ID)
          
        }


//        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self , key :"work_type_Selected",value : "w")

        //progress1.dismiss();
        //Start of call to service



        var params = [String:String]()
        params["sCompanyFolder"]  = company_code
        params["iPaId"] = "\(Custom_Variables_And_Method.PA_ID)"

        let tables = [-1]
       //   progress1.setMessage("Downloading Miscellaneous data.." + "\n" + "please wait");
        // avoid deadlocks by not using .main queue here
        progressHUD.dismiss()
        progressHUD.show(text: "Please Wait...\nDownloading Miscellaneous Data ")
        

        self.objApi.customMethodForAllServices(params: params, methodName: "GetItemListForLocal", tables: tables, response_code: MESSAGE_INTERNET_UTILITES, vc : self)


        //End of call to service


        }
    
    
    }
    
    private func parser_utilites( dataFromAPI :[ String :NSArray]) {
    if (!dataFromAPI.isEmpty) {
        
        do{
       
            //table 0-11 for getitemlistforlocal
            //table 12-13 for fmgcddl_2
            
            
            //getItemforLocal
            
            
            
            let jsonArray11 =   dataFromAPI["Tables0"]!
            let jsonArray12 =   dataFromAPI["Tables1"]!
            let jsonArray13 =   dataFromAPI["Tables2"]!
            let jsonArray14 =   dataFromAPI["Tables3"]!
            let jsonArray15 =   dataFromAPI["Tables4"]!
            let jsonArray16 =   dataFromAPI["Tables5"]!
            let jsonArray17 =   dataFromAPI["Tables6"]!
            let jsonArray18 =   dataFromAPI["Tables7"]!
            let jsonArray19 =   dataFromAPI["Tables8"]!
            let jsonArray20 =   dataFromAPI["Tables9"]!
            let jsonArray22 =   dataFromAPI["Tables11"]!

            for i in 0 ..< jsonArray11.count{
                let jasonObj1 = jsonArray11[i] as! [String : AnyObject]
                cbohelp.insertProducts(id: jasonObj1["ITEM_ID"] as! String, name: jasonObj1["ITEM_NAME"] as! String, stk_rate: (jasonObj1["STK_RATE"]) as! String , gift: jasonObj1["GIFT_TYPE"] as! String, SHOW_ON_TOP: jasonObj1["SHOW_ON_TOP"] as! String, SHOW_YN: jasonObj1["SHOW_YN"] as! String, SPL_ID: Int (jasonObj1["SPL_ID"] as! String)!, GENERIC_NAME: jasonObj1["GENERIC_NAME"] as! String, BRAND_ID: jasonObj1["BRAND_ID"] as! String, BRAND_NAME: jasonObj1["BRAND_NAME"] as! String)
            }
        
            /*for (int b = 0; b<jsonArray2.length();b++){
             JSONObject jasonObj2 = jsonArray2.getJSONObject(b);
             val=cbohelper.insertDoctorData(jasonObj2.getString("DR_ID"), jasonObj2.getString("ITEM_ID"),jasonObj2.getString("item_name"));
             Log.e("%%%%%%%%%%%%%%%", "doctor insert");

             }*/
        
            for i in 0 ..< jsonArray14.count {

                let jsonObject3 = jsonArray14[i] as! [String : AnyObject]
                cbohelp.insert_phallmst(allmst_id: jsonObject3["ID"] as! String, table_name: jsonObject3["TABLE_NAME"] as! String, field_name: jsonObject3["FIELD_NAME"] as! String, remark: jsonObject3["REMARK"] as! String)
            }

            for i in 0 ..< jsonArray15.count {

            let jsonObject4 = jsonArray15[i] as! [String : AnyObject]
                
                cbohelp.insert_phparty(pa_id: jsonObject4["PA_ID"] as! String, pa_name: jsonObject4["PA_NAME"] as! String , desig_id: jsonObject4["DESIG_ID"] as! String, category: jsonObject4["CATEGORY"] as! String, hqid: jsonObject4["HQ_ID"] as! String, PA_LAT_LONG: jsonObject4["PA_LAT_LONG"] as! String, PA_LAT_LONG2: jsonObject4["PA_LAT_LONG2"] as! String , PA_LAT_LONG3: jsonObject4["PA_LAT_LONG3"] as! String, SHOWYN: jsonObject4["SHOWYN"] as! String)
            }
            
        
            for i in 0 ..< jsonArray16.count{
                let jsonObject5 = jsonArray16[i] as! [String : AnyObject]
                cbohelp.insert_phrelation(pa_id: jsonObject5["PA_ID"] as! String, under_id: jsonObject5["UNDER_ID"] as! String, rank: jsonObject5["RANK"] as! String)
            }

    
            for i in 0 ..< jsonArray17.count{
                let jsonObject6 = jsonArray17[i] as! [String : AnyObject]
                cbohelp.insert_phitempl(item_id: jsonObject6["ITEM_ID"] as! String , dr_spl_id: jsonObject6["DR_SPL_ID"] as! String , srno: jsonObject6["SRNO"] as! String)
            }
            
            

            for i in 0 ..< jsonArray18.count{
                let jsonObject7 = jsonArray18[i] as! [String : AnyObject]
                cbohelp.insert_FtpData(ip: jsonObject7["WEB_IP"] as! String, user: jsonObject7["WEB_USER"] as! String, pass: jsonObject7["WEB_PWD"] as! String, port:     jsonObject7["WEB_PORT"] as! String, path: jsonObject7["WEB_ROOT_PATH"] as! String,ip_download: jsonObject7["WEB_IP_DOWNLOAD"] as! String,user_download: jsonObject7["WEB_USER_DOWNLOAD"] as! String,pass_download: jsonObject7["WEB_PWD_DOWNLOAD"] as! String,port_download: jsonObject7["WEB_PORT_DOWNLOAD"] as! String)
            }
            
        
    
//        for i in 0 ..< jsonArray20.count{
//            let jsonObject9 = jsonArray20[i] as! [String : AnyObject]
//            //let count = jsonObject9["NO_DR"] as! Int
//          //  let chem_count = jsonObject9["NO_CHEM"] as! Int
//    }

            let jsonObjectLoginUrl = jsonArray22[0] as! [String : AnyObject]
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "Login_Url", value: jsonObjectLoginUrl["LOGIN_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key :"DR_ADDNEW_URL", value :jsonObjectLoginUrl["DR_ADDNEW_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "CHEM_ADDNEW_URL",value : jsonObjectLoginUrl["CHEM_ADDNEW_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "DRSALE_ADDNEW_URL",value : jsonObjectLoginUrl["DRSALE_ADDNEW_URL"] as! String)
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "TP_ADDNEW_URL",value : jsonObjectLoginUrl["TP_ADDNEW_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "CHALLAN_ACK_URL",value : jsonObjectLoginUrl["CHALLAN_ACK_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "SECONDARY_SALE_URL",value : jsonObjectLoginUrl["SECONDARY_SALE_URL"] as! String)
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key  :"TP_APPROVE_URL", value : jsonObjectLoginUrl["TP_APPROVE_URL"] as! String)

                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key :"PERSONAL_INFORMATION_URL", value : jsonObjectLoginUrl["PERSONAL_INFORMATION_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self ,key : "CHANGE_PASSWORD_URL", value : jsonObjectLoginUrl["CHANGE_PASSWORD_URL"] as! String )
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "CIRCULAR_URL", value:  jsonObjectLoginUrl["CIRCULAR_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "DECLARATION_OF_SAVING_URL",value:  jsonObjectLoginUrl["DECLARATION_OF_SAVING_URL"] as! String)
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key:  "SALARY_SLIP_URL", value:  jsonObjectLoginUrl["SALARY_SLIP_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self,key:  "FORM16_URL", value:  jsonObjectLoginUrl["FORM16_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key:  "ROUTE_MASTER_URL", value:  jsonObjectLoginUrl["ROUTE_MASTER_URL"] as! String)
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key:  "HOLIDAY_URL", value:  jsonObjectLoginUrl["HOLIDAY_URL"] as! String)


        // fmcgddl_2
       
        let jsonArray23 = dataFromAPI["Tables12"]!
            
        let jsonArray24 = dataFromAPI["Tables13"]!
            
            for  i in  0  ..< jsonArray23.count {
                
                let c = jsonArray23[i] as! [String : AnyObject]
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key : "fmcg_value", value: try c.getString(key: "FMCG"))
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key:  "root_needed", value:  try c.getString(key: "ROUTE"))
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key : "gps_needed", value:  try c.getString(key: "GPRSYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key :"version", value:  try c.getString(key: "VER"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self  ,key : "doryn", value : try c.getString(key: "DORYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key : "dosyn", value:  try c.getString(key: "DOSYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key:  "internet",value:  try c.getString(key: "INTERNET_RQD"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "live_km",value:  try c.getString(key: "LIVE_KM"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self , key :"leave_yn", value:  try c.getString(key: "LEAVEYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "WEBSERVICE_URL",value:  try c.getString(key: "WEBSERVICE_URL"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "WEBSERVICE_URL_ALTERNATE",value:  try c.getString(key: "WEBSERVICE_URL_ALTERNATE") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FLASHYN",value: try  c.getString(key: "FLASHYN"))
                //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,"FLASHYN", c.getString("FLASHYN"as! String )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_REMARK_NA",value:  try c.getString(key: "DCR_REMARK_NA"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_DR_REMARKYN", value:  try c.getString(key: "DCR_DR_REMARKYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ROUTEDIVERTYN", value:  try c.getString(key: "ROUTEDIVERTYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_ADDAREANA", value: try c.getString(key: "DCR_ADDAREANA"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAIDPDFYN", value: try c.getString(key: "VISUALAIDPDFYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_POB_MANDATORY", value: try c.getString(key: "SAMPLE_POB_MANDATORY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "REMARK_WW_MANDATORY", value: try c.getString(key: "REMARK_WW_MANDATORY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_POB_INPUT_MANDATORY", value : try c.getString(key: "SAMPLE_POB_INPUT_MANDATORY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "MISSED_CALL_OPTION", value : try c.getString(key: "MISSED_CALL_OPTION"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "APPRAISALMANDATORY", value : try c.getString(key: "APPRAISALMANDATORY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "USER_NAME", value : try c.getString(key: "USER_NAME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "PASSWORD", value : try c.getString(key: "PASSWORD"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_DRSELITEMYN",value : try c.getString(key: "VISUALAID_DRSELITEMYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DOB_REMINDER_HOUR", value : try c.getString(key: "DOB_REMINDER_HOUR"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SYNCDRITEMYN", value : try c.getString(key: "SYNCDRITEMYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "GEO_FANCING_KM", value : try c.getString(key: "GEO_FANCING_KM") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FIRST_CALL_LOCK_TIME", value :  try c.getString(key: "FIRST_CALL_LOCK_TIME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "mark", value : try c.getString(key: "FLASH_MESSAGE"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NOC_HEAD", value : try c.getString(key: "NOC_HEAD"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "USER_PIC",value : try c.getString(key: "USER_PIC"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_LETREMARK_LENGTH", value : try c.getString(key: "DCR_LETREMARK_LENGTH"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLEMAXQTY", value : try c.getString(key: "SAMPLEMAXQTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "POBMAXQTY", value : try c.getString(key: "POBMAXQTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ASKUPDATEYN", value : try c.getString(key: "ASKUPDATEYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "MOBILEDATAYN", value : try c.getString(key: "MOBILEDATAYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CALLWAITINGTIME", value : try c.getString(key: "CALLWAITINGTIME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "COMPANY_PIC", value : try c.getString(key: "COMPANY_PIC"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RE_REG_KM", value : try c.getString(key: "RE_REG_KM"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ERROR_EMAIL", value : try c.getString(key: "ERROR_EMAIL"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DIVERT_REMARKYN", value : try c.getString(key: "DIVERT_REMARKYN"))
                
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NLC_PIC_YN", value : try c.getString(key: "NLC_PIC_YN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RX_MAX_QTY", value : try c.getString(key: "RX_MAX_QTY"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SHOW_ADD_REGYN", value : try c.getString(key: "SHOW_ADD_REGYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "EXP_ATCH_YN", value : try c.getString(key: "EXP_ATCH_YN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "FARMERADDFIELDYN", value : try c.getString(key: "FARMERADDFIELDYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "NO_DR_CALL_REQ", value : try c.getString(key: "NO_DR_CALL_REQ"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DR_RX_ENTRY_YN", value : try c.getString(key: "DR_RX_ENTRY_YN") )
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "RETAILERCHAINYN", value : try c.getString(key: "RETAILERCHAINYN"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_SUBMIT_TIME", value : try c.getString(key: "DCR_SUBMIT_TIME"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_SUBMIT_SPEACH", value : try c.getString(key: "DCR_SUBMIT_SPEACH"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "ALLOWED_APP", value : try c.getString(key: "ALLOWED_APP"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCRGIFT_QTY_VALIDATE", value : try c.getString(key: "DCRGIFT_QTY_VALIDATE"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "SAMPLE_BTN_CAPTION", value : try c.getString(key: "SAMPLE_BTN_CAPTION"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "GIFT_BTN_CAPTION", value : try c.getString(key: "GIFT_BTN_CAPTION"))
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DIVERTWWYN", value : try c.getString(key: "DIVERTWWYN"))
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
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "DCR_DR_REMARKYN", value: try c.getString(key: "DCR_DR_REMARKYN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "CHEMCALL_RCPABUTTONYN", value: try c.getString(key: "CHEMCALL_RCPABUTTONYN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "EXPTA_MGRMANUALYN", value: try c.getString(key: "EXPTA_MGRMANUALYN"));
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "MANUAL_TA",value: "0.0");
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_VERSION", value: try c.getString(key: "VISUALAID_VERSION"));
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_VERSION_DOWNLOAD", value: "");
                
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

            /*Custom_Variables_And_Method.ip = "0";
             Custom_Variables_And_Method.user = "0";
             Custom_Variables_And_Method.pwd = "0";
             Custom_Variables_And_Method.db = "0";

             cbohelp.insertLoginDetail(company_code, ols_ip, ols_db_name, ols_db_user, ols_db_password, version_new);*/

            cbohelp.insertdata(mycode: company_code, uname: mylog, pw: mypass, pin: pin )
            
            cbohelp.deleteVersion();
            cbohelp.insertVersionInLocal(ver : Custom_Variables_And_Method.VERSION);
                // MARK:- IMP
            // customMethod.notification_check();
            
            
        //    if (Custom_Variables_And_Method.pub_desig_id.equalsIgnoreCase("11")) {
        //    startActivity(new Intent(getApplicationContext(), PersonalInfo.class));
        //
        //    } else {
        //    startActivity(new Intent(getApplicationContext(), ViewPager_2016.class));
        //
        //    }
            
            self.performSegue(withIdentifier: "ViewController2", sender: nil)
            
            /*let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "VisualAidDownload") as! VisualAidDownload
            
            visualAidDownloadVC.VCIntent["title"] = "VisualAd Download"
            visualAidDownloadVC.VCIntent["direct_download"] = "yes"
            
            self.present(visualAidDownloadVC, animated: true, completion: nil)*/

        }catch{
            
            customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription)
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
            
            objBroadcastErrorMail.requestAuthorization()
            
            
        }
        
        progressHUD.dismiss()

    }
  
    }
}

    
//    private void parser_login(Bundle result) {
//    if (result!=null ) {
//
//    try {
//
//    // table 0-3 for login
//    // table 4-8 for future use
//    // table 9-10 for getDCRID
//
//
//    String table0 = result.getString("Tables0");
//    JSONArray jsonArray1 = new JSONArray(table0);
//    for (int i = 0; i < jsonArray1.length(); i++) {
//    JSONObject c = jsonArray1.getJSONObject(i);
//    if (c.getString("STATUS").equals("Y")) {
//    process_login_data(result);
//    }else if (c.getString("STATUS").equals("L")) {
//    startActivity(new Intent(getApplicationContext(), Load_New.class));
//    progress1.dismiss();
//    }else{
//    customVariablesAndMethod.getAlert(context,"Alert !!!",c.getString("STATUS"));
//    progress1.dismiss();
//    }
//    }
//
//
//
//    } catch (JSONException e) {
//    progress1.dismiss();
//    Log.d("MYAPP", "objects are: " + e.toString());
//    CboServices.getAlert(this,"Missing field error",getResources().getString(R.string.service_unavilable) +e.toString());
//    e.printStackTrace();
//    }
//
//    }
//    //Log.d("MYAPP", "objects are1: " + result);
//    //progress1.dismiss();
//    }
    
    

//}




//Extension
public extension UIImage {
    public func resize(height: CGFloat) -> UIImage? {
        let scale = height / self.size.height
        let width = self.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x:0, y:0, width:width, height:height))
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}
