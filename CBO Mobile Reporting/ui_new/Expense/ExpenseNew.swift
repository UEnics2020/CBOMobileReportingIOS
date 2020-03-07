//
//  ExpenseNew.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 25/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//


import UIKit
import SQLite
import DPDropDownMenu
import CoreLocation
class ExpenseNew: CustomUIViewController,IExpense, Expense_interface{
     
     var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
     var customVariablesAndMethod : Custom_Variables_And_Method!
     var context : CustomUIViewController!
     
     @IBOutlet weak var dis_edit: CustomDisableTextView!
     @IBOutlet weak var datype_edit: CustomDisableTextView!
     @IBOutlet weak var Area_DA_DP: DPDropDownMenu!
     
     @IBOutlet weak var Area_Distance_Dp: DPDropDownMenu!
     @IBOutlet weak var loc: CustomTextView!
     @IBOutlet weak var loc_layout: UIStackView!
     @IBOutlet weak var myTopView: TopViewOfApplication!
     
     @IBOutlet weak var taView: CBOOtherExpense!
     @IBOutlet weak var daView: CBOOtherExpense!
     @IBOutlet weak var otherView: CBOOtherExpense!
     
     
     @IBOutlet weak var submitBtn: CustomeUIButton!
     
     @IBOutlet weak var areaView: UIStackView!
     
     @IBOutlet weak var area_distance_view: UIStackView!
     
    
     @IBOutlet weak var routeStausTxt: UILabel!
     
     
     var ROUTE_CLASS = "",ACTUALDA_FAREYN = "",ACTUALFAREYN_MANDATORY  = ""
     var ACTUALFARE_MAXAMT : Double = 0
     
     var MESSAGE_INTERNET_ROOT=1,MESSAGE_INTERNET_SAVE_EXPENSE=2,
     MESSAGE_INTERNET_DCR_COMMITEXP=3,MESSAGE_INTERNET_DCR_DELETEEXP=4,GPS_TIMMER=7;
     

     var progressHUD : ProgressHUD!

     var exp_id = "",locExtra = "";
     
     var Back_allowed = "Y"
     
     var viewModel : vmExpense!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         
         context = self
        
         
         viewModel = vmExpense();
         viewModel.setForFinalSubmit(FinalSubmitYN: VCIntent["form_type"]!);
         viewModel.setView(context: context,view: self);
       
//         Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON)
//
//         let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
//
//         if (currentBestLocation != CLLocation()) {
//             locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
//         }
         
    
         
         
         setAddressToUI();
         
         if(Custom_Variables_And_Method.location_required == "Y") {
             loc_layout.isHidden = false
         } else {
             loc_layout.isHidden = true
         }
         
         
         if (VCIntent["form_type"] == "exp"){
             // submit expense only.....
             //final_submit_remark_layout.isHidden = true
             submitBtn.setText(text: "Submit Expense")
         } else {
             // in case of not working.....
             //final_submit_remark_layout.isHidden = false
             submitBtn.setText(text: "Final Submit")
         }
         
         
         if VCIntent["Back_allowed"]  != nil{
             Back_allowed = VCIntent["Back_allowed"]!
         }
         
         
         
             //areaView.isHidden = true
             
             //area_distance_view.isHidden = true
             
             

         submitBtn.addTarget(self, action: #selector(SubmitExp) , for: .touchUpInside)
     }
    
    func showProgess(msg : String) {
        if progressHUD != nil {
            progressHUD.dismiss()
        }else{
            progressHUD = ProgressHUD(vc : self)
        }
        progressHUD.show(text: msg)
    }
    
    func hideProgess(){
        if progressHUD != nil {
            progressHUD.dismiss()
        }
    }
    
    func getCompanyCode() -> String {
       return cbohelp.getCompanyCode()
    }
    
    func getDCRId() -> String {
       return Custom_Variables_And_Method.DCR_ID
    }
    
    func getUserId() -> String {
        return String(Custom_Variables_And_Method.PA_ID)
    }
    
    func getReferencesById() {
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        
        taView.setExp_type(exp_type: eExpanse.TA)
        daView.setExp_type(exp_type: eExpanse.DA)
        
        taView.setListener(listener: self)
        daView.setListener(listener: self)
        otherView.setListener(listener: self)
    }
    
    func getActivityTitle() -> String{
//        if VCIntent["title"] != nil{
//           return VCIntent["title"]!
//        }
        if (viewModel.IsFormForFinalSubmit()){
           return "Final Submit";
        }
        
        return "Expense"
    }
    
    func setTitle(title: String) {
        myTopView.setText(title: title)
    }
    
    func IsRouteWise() -> Bool {
       return customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "root_needed", defaultValue: "N") == "Y"
    }
    
    func setRouteStatus(Status: String) {
        routeStausTxt.text = Status;
        routeStausTxt.isHidden = Status.isEmpty;
    }
    
    func setDA(DA: String) {
         print("delete")
    }
    
    func setManualDA(da: mDA) {
         print("delete")
    }
    
    func setManualTA(distance: mDistance) {
         print("delete")
    }
    
    func setDAType(type: String) {
         print("delete")
    }
    
    func setTADetail(detail: String) {
        taView.setOtherDetail(otherDetail: detail);
        taView.setDefaultAmount(defaultAmount: viewModel.getExpense().getTA_Amt());
    }
    
    func updateDAView() {
        print("delete")
    }
    
    func setDistance(Distance: String) {
        print("delete")
    }
    
    func enableDA(enable: Bool) {
         print("delete")
    }
    
    func ActualDAReqd(required: Bool) {
         print("delete")
    }
    
    func ManualDA_TypeReqd(required: Bool) {
        print("delete")
    }
    
    func ManualDAReqd(required: Bool) {
        daView.setAddBtnReqd(required: required);
    }
    
    func ManualTAReqd(required: Bool) {
        taView.setAddBtnReqd(required: required);
    }
    
    func ManualTAMandetory(required: Bool) {
        taView.setManualMandetory(manualMendetory: required);
    }
    
    func ManualStationReqd(required: Bool) {
         print("delete")
    }
    
    func ManualDistanceReqd(required: Bool) {
         print("delete")
    }
    
    func ActualFareReqd(required: Bool) {
        print("delete")
    }
    
    func OnOtherExpenseAdded(othExpense: mOthExpense) {
        viewModel.UpdateExpense(othExpense :othExpense)
    }
    
    func OnOtherExpenseUpdated(othExpenses: [mOthExpense]) {
        otherView.updateDataList(dataList: othExpenses)
    }
    
    func OnTAExpenseAdded(othExpense: mOthExpense) {
        viewModel.UpdateExpense(othExpense : othExpense)
    }
    
    func OnTAExpenseUpdated(othExpenses: [mOthExpense]) {
       taView.updateDataList(dataList: othExpenses)
    }
    
    func OnDAExpenseAdded(DAExpense: mOthExpense) {
        viewModel.UpdateExpense(othExpense : DAExpense)
    }
    
    func OnDAExpenseUpdated(DAExpenses: [mOthExpense]) {
        daView.updateDataList(dataList: DAExpenses)
    }
    
    func OnFinalRemarkReqd(required: Bool) {
         print("delete")
    }
    
    func OnExpenseCommit() {
         print("delete")
    }
    
    func OnExpenseCommited() {
        print("delete")
    }
    
    
    func AddExpenseClicked(expense_type: eExpanse) {
        OnAddExpense(expense: viewModel.getExpense(), othExpense: mOthExpense(),eExpense: expense_type);
        //Add_expense(who: "0", hed: "" , amount: "" , rem: "", path: "", hed_id: "")
    }

    func Edit_ExpenseClicked(othExpense: mOthExpense, expense_type: eExpanse) {
        OnAddExpense(expense: viewModel.getExpense(), othExpense: othExpense,eExpense: expense_type);
    }

    func delete_ExpenseClicked(othExpense: mOthExpense, expense_type: eExpanse) {
        getAlert(id: "\(othExpense.getId())", name: othExpense.getExpHead().getName(), title: "Delete")
    }
    

    
//    func onEdit(id: String, name: String) {
//
//        let indexId = Int(id)
//
//        Add_expense(who: "1", hed: data[indexId!]["exp_head"]! , amount: data[indexId!]["amount"]! , rem: data[indexId!]["remark"]!, path: data[indexId!]["FILE_NAME"]!, hed_id: data[indexId!]["exp_head_id"]!)
//    }
//
//    func onDelete(id: String, name: String) {
//        getAlert(id: id, name: name, title: "Delete")
//    }
    
    
    
    
    
    
    
    

    
    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }
    
   

    
    func populateOtherExpenses(){
        
        
//        taView.updateDataList(dataList: expense.getTA_Expenses())
//        daView.updateDataList(dataList: expense.getDA_Expenses())
//        otherView.updateDataList(dataList: expense.getOthExpenses())
    }
    
    @objc func pressedBack(){
        
        if (Back_allowed == ("Y")){
            myTopView.CloseCurruntVC(vc: self)
        } else {
            customVariablesAndMethod.getAlert(vc: context,title: "Please Submit",msg: "Please complete your Final Submit");
        }
    }
    
    

    func OnAddExpense(expense: mExpense, othExpense: mOthExpense, eExpense: eExpanse ) {

        let objAddAnotherExpenses = self.storyboard?.instantiateViewController(withIdentifier: "AddAnotherExpensesNew") as! AddAnotherExpensesNew
        objAddAnotherExpenses.VCIntentArray["expense"] = expense
        objAddAnotherExpenses.VCIntentArray["othExpense"] = othExpense
        objAddAnotherExpenses.VCIntentArray["eExpense"] = eExpense
        objAddAnotherExpenses.vc =  self
        objAddAnotherExpenses.responseCode = MESSAGE_INTERNET_SAVE_EXPENSE
        self.present(objAddAnotherExpenses, animated: true, completion: nil)

    }
    
    
    
    func AreaDa_DP_Populate() {
        
//        Area_DA_DP.layer.borderWidth = CGFloat(2.0)
//        Area_DA_DP.layer.cornerRadius = 8
//        Area_DA_DP.headerBackgroundColor = UIColor.clear
//        Area_DA_DP.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
//        Area_DA_DP.headerTextColor = AppColorClass.colorPrimaryDark!
//        Area_DA_DP.menuTextColor = AppColorClass.colorPrimaryDark!
//        Area_DA_DP.selectedMenuTextColor = AppColorClass.colorPrimaryDark!
//
//
//        Area_DA_DP.didSelectedItemIndex = { index in
//            self.Area_DA_DP.headerTitle = (self.Area_da_list[index].title)
//
//            self.datype_val = self.Area_DA_DP.headerTitle
//
//            if (self.datype_val == "Local" || self.datype_val == "--Select--" || self.datype_val == "DA Not Applicable") {
//                self.area_distance_view.isHidden = true
//
//            } else {
//                self.area_distance_view.isHidden = false
//            }
//
//            if (self.datype_val == "--Select--") {
//                self.datype_edit.setText(text: "");
//            } else if (self.datype_val == "DA Not Applicable") {
//                self.datype_edit.setText(text: "0");
//                self.dis_edit.setText(text: "0");
//            } else if (self.datype_val == "Local") {
//
//                self.datype_edit.setText(text: self.datype_local);
//                self.dis_edit.setText(text: "0");
//
//            } else if (self.datype_val == "Ex-Station Double Side" || self.datype_val == "Ex-Station Single Side") {
//
//                self.datype_edit.setText(text: self.datype_ex);
//
//
//            } else {
//
//                self.datype_edit.setText(text: self.datype_ns);
//
//            }
//            self.Area_Distance_Dp.selectedIndex = 0
//      }
//        Area_DA_DP.selectedIndex = 0
    }
    
    func AreaDisDP_Populate() {
        
//        Area_Distance_Dp.layer.borderWidth = CGFloat(2.0)
//        Area_Distance_Dp.layer.cornerRadius = 8
//        Area_Distance_Dp.headerBackgroundColor = UIColor.clear
//        Area_Distance_Dp.layer.borderColor =  AppColorClass.colorPrimaryDark?.cgColor
//        Area_Distance_Dp.headerTextColor = AppColorClass.colorPrimaryDark!
//        Area_Distance_Dp.menuTextColor = AppColorClass.colorPrimaryDark!
//        Area_Distance_Dp.selectedMenuTextColor = AppColorClass.colorPrimaryDark!
//
//
//        Area_Distance_Dp.didSelectedItemIndex = { index in
//            self.Area_Distance_Dp.headerTitle = (self.Area_dis_list[index].title)
//            self.dist_id3 = self.Area_dis_list[index].code!
//            if (self.Area_DA_DP.headerTitle == "Ex-Station Double Side" || self.Area_DA_DP.headerTitle == "Out-Station Double Side") {
//
//
//                self.ttl_distance = self.Area_Distance_Dp.headerTitle
//                if (!self.ttl_distance.contains("----->")) {
//                    self.dis_edit.setText(text: "");
//                } else {
//                    let Distance1 = self.ttl_distance.components(separatedBy: "----->");
//
//                    let ActDistance = Distance1[2];
//                    let Act_dist1 = ActDistance.components(separatedBy: "K");
//                    let MyDistance = Act_dist1[0].trimmingCharacters(in: .whitespaces)
//                    let fare_rate = Float(self.DistRate)!;
//                    let a = Float(MyDistance)!;
//                    let res = a * 2 * fare_rate;
//                    let MyData = "\(res)";
//
//                    self.dis_edit.setText(text: MyData);
//                }
//            } else if (self.Area_DA_DP.headerTitle == "Ex-Station Single Side" || self.Area_DA_DP.headerTitle == "Out-Station Single Side") {
//
//                self.ttl_distance = self.Area_Distance_Dp.headerTitle
//                if (!self.ttl_distance.contains("----->")) {
//                    self.dis_edit.setText(text: "");
//                } else {
//                    let Distance1 = self.ttl_distance.components(separatedBy: "----->");
//
//                    let ActDistance = Distance1[2];
//                    let Act_dist1 = ActDistance.components(separatedBy: "K");
//                    let MyDistance = Act_dist1[0].trimmingCharacters(in: .whitespaces)
//                    let fare_rate = Float(self.DistRate)!;
//                    let a = Float(MyDistance)!;
//                    let res = a * 1 * fare_rate;
//                    let MyData = "\(res)";
//
//                    self.dis_edit.setText(text: MyData);
//                }
//            }
            
//        }
//        Area_Distance_Dp.selectedIndex = 0
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
        
        case MESSAGE_INTERNET_SAVE_EXPENSE:
//            if(exp_id == "-1"){
//                let jsonArray1 =   dataFromAPI["Tables0"]!
//                let object = jsonArray1[0] as! [String : AnyObject]
//                do{
//                    let id = try object.getString(key: "ID");
//                    cbohelp.insert_Expense(exp_head_id: exp_id,exp_head: "",amount : my_Amt,remark:  my_rem,FILE_NAME: filename,ID: id ,time: customVariablesAndMethod1.currentTime(context: self));
//                }catch{
//                    print("Error")
//                }
//                progressHUD.dismiss();
//                SubmitExpToServer()
//            }else{
                populateOtherExpenses();
                
                //init_DA_type();
//            }
            
            break;
        case MESSAGE_INTERNET_DCR_COMMITEXP:
            parserExpSubmit(dataFromAPI : dataFromAPI);
            break;
        case MESSAGE_INTERNET_DCR_DELETEEXP:
            parserDelete(dataFromAPI : dataFromAPI);
            break;
        case MESSAGE_INTERNET_ROOT:
            viewModel.parserExpDDl(context : context,dataFromAPI : dataFromAPI);
            hideProgess();
            break;
        case GPS_TIMMER:
            //FinalSubmit();
            break;
        case 99:
            hideProgess();
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            hideProgess();
            print("Error")
        }
    }
    
    
    private func parserDelete(dataFromAPI : [String : NSArray]) {
        if(!dataFromAPI.isEmpty){
            do {
                
                let jsonArray1 =   dataFromAPI["Tables0"]!
                let object = jsonArray1[0] as! [String : AnyObject]
                let value2 = try object.getString(key: "DCR_ID");
                
                
                //cbohelp.delete_Expense_withID(exp_ID: exp_id)
                populateOtherExpenses()
                
                
                customVariablesAndMethod.msgBox(vc: self, msg: " Exp. Deleted Sucessfully")
                
            }catch{
                customVariablesAndMethod.getAlert(vc: context, title: "Missing field error", msg: error.localizedDescription);
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                
                objBroadcastErrorMail.requestAuthorization()
            }
        }
    }
    

    

    
    
    
    
   
    
    func parserExpSubmit(dataFromAPI : [String : NSArray]) {
        if(!dataFromAPI.isEmpty){
            do {
                
                let jsonArray1 =   dataFromAPI["Tables0"]!
                
                
                let object = jsonArray1[0] as! [String : AnyObject]
                let value2 = try object.getString(key: "DCR_ID");
                
                let chm_ok = getmydata()[0];
                let stk_ok = getmydata()[1];
                let exp_ok = getmydata()[2]
                
                
                if (exp_ok == "") {
                    cbohelp.insertfinalTest(chemist: chm_ok, stockist: stk_ok, exp: "2");
                } else {
                    cbohelp.updatefinalTest(chemist: chm_ok, stockist: stk_ok, exp: "2");
                }
                
                //                new GPS_Timmer_Dialog(context,mHandler,"Final Submit in Process...",GPS_TIMMER).show();
                
                if (VCIntent["form_type"] == "exp"){
                    progressHUD.dismiss();
                    // submit expense only.....
                    customVariablesAndMethod.msgBox(vc: context,msg: "Expense Successfully Submited...", completion: {_ in self.myTopView.CloseCurruntVC(vc: self.context)})
                }else{
                    // in case of not working.....
                    FinalSubmit()
                }
            } catch{
                progressHUD.dismiss();
                customVariablesAndMethod.getAlert(vc: context,title: "Missing field error", msg: error.localizedDescription)
                
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                
                objBroadcastErrorMail.requestAuthorization()
            }
            
        }
    }
    
    
    func FinalSubmit(){
        //Start of call to service
        
//        var ACTUALFARE = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "ACTUALFARE",defaultValue: "");
//        if (ACTUALFARE == ("")){
//            ACTUALFARE = "0";
//        }
//
//        var params = [String:String]()
//        params["sCompanyFolder"] = cbohelp.getCompanyCode()
//        params["iDCRID"] =  dcr_id
//        params["iNOCHEMIST"] =  "1"
//        params["sNOSTOCKIST"] =  "1"
//        params["sCHEMISTREMARK"] =  ""
//        params["sSTOCKISTREMARK"] =  ""
//        params["iPOB"] =  "0.0"
//        params["iPOBQTY"] =  "0"
//        params["iACTUALFAREAMT"] =  ACTUALFARE
//        params["sDATYPE"] =  "NA"
//        params["iDISTANCE_ID"] =  "99999"
//        params["sREMARK"] =  final_remark.getText()
//        params["sLOC2"] =  "\(Custom_Variables_And_Method.GLOBAL_LATLON )@\(locExtra)!^\(loc.getText())"
//        params["iOUTTIME"] =  "99"
//
//        var tables = [Int]();
//        tables.append(0);
//
//        progressHUD.text =  "Please Wait...\nFinal Submit in Progess..."
//        //self.view.addSubview(progressHUD)
//
//
//        CboServices().customMethodForAllServices(params: params, methodName: "DCR_COMMITFINAL_1", tables: tables, response_code: MESSAGE_INTERNET_DCR_COMMITDCR, vc : self )
//
//
        //End of call to service
        
    }
    
   
    
    
    
    func getmydata() -> [String] {
        
        var raw = [String]();
        var chm = ""
        var stk = ""
        var exp = ""
        do {
            let statement :Statement = try cbohelp.getFinalSubmit();
            while let c = statement.next(){
                try chm = "\(chm)\(c[cbohelp.getColumnIndex(statement: statement , Coloumn_Name: "chemist")]! as! String)"
                try stk = "\(stk)\(c[cbohelp.getColumnIndex(statement: statement , Coloumn_Name: "stockist")]! as! String)"
                try exp = "\(exp)\(c[cbohelp.getColumnIndex(statement: statement , Coloumn_Name: "exp")]! as! String)";
            }
        }catch{
            print(error)
        }
        raw.append(chm);
        raw.append(stk);
        raw.append(exp);
        return raw;
    }
    
    /// submit exp -----------------
    @objc func SubmitExp(){
//        let mandatory_pending_exp_head = cbohelp.get_mandatory_pending_exp_head();
//        if (loc.getText() == "") {
//            loc.text = "Unknown Location"
//        }
//         if (mandatory_pending_exp_head.count != 0) {
//
//            var pending_list="";
//            for i in  0 ..< mandatory_pending_exp_head.count {
//                pending_list += mandatory_pending_exp_head[i]["PA_NAME"]!+"\n";
//            }
//            customVariablesAndMethod.getAlert(vc: context,title: "Expenses Pending",msg: pending_list);
//
//        }
////         else if(cbohelp.get_DA_ACTION_exp_head().count > 0  && actual_DA_layout.isHidden == false
////            && !da_root.getText().isEmpty && da_root.getText() != ("0")){
////            customVariablesAndMethod1.getAlert(vc: self,title: "Already Applied for DA...",
////                                               msg: "Please make DA amount Rs 0.") {_ in
////            };
////        }
//         else if (routeNeeded == "Y") {
//
//            if (route_distance_view.isHidden == false && distAmt.getText() == "" && ACTUALFAREYN_MANDATORY.uppercased() != ("N")) {
//                customVariablesAndMethod.msgBox(vc: context,msg: "Please Enter the Actual Fare....");
//            }else {
//                SubmitExpToServer()
//
//
//                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "ACTUALFARE",value: distAmt.getText());
//                distAmt.setText(text: "");
//
//                if (distAmt.isHidden == true){
//                    customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "ACTUALFARE",value: "0");
//                }
//
//            }
//        } else {
//            if (datype_val == "") {
//                customVariablesAndMethod.msgBox(vc: context,msg: "Select Your DA Type");
//            } else {
//
//                SubmitExpToServer()
//
//            }
//        }
    }
    
    func SubmitExpToServer(){
        
//        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "da_val",value: da_root.getText().trimmingCharacters(in: .whitespaces).isEmpty ? "0" : da_root.getText());
        
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"] = getCompanyCode()
        params["iDcrId"] = getDCRId()
//        params["sDaType"] = datype_val
//        params["iDistanceId"] = dist_id3
        params["iDA_VALUE"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "da_val",defaultValue: "0")
        
        var tables = [Int]();
        tables.append(0);
        
        
        progressHUD.show(text: "Please Wait..." )
        
        //self.view.addSubview(progressHUD)
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCR_COMMITEXP_2", tables: tables, response_code: MESSAGE_INTERNET_DCR_COMMITEXP, vc : self )
        
        
        //End of call to service
    }
    
    
    
    
    func getAlert(id  : String  , name : String , title : String){
        var msg = ""
        
        
        var alertViewController : UIAlertController!
        
        print(name)
        let delete = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            
            self.exp_id = name;
            var params = [String : String]();
            params["sCompanyFolder"] = self.cbohelp.getCompanyCode()
            params["iPA_ID"] =  "\(Custom_Variables_And_Method.PA_ID)"
            params["iDCR_ID"] = self.getDCRId()
            params["iID"] = name
            
            let tables = [0]
            //
            //            progress1.setMessage("Please Wait..");
            //            progress1.setCancelable(false);
            //            progress1.show();
            CboServices().customMethodForAllServices(params: params, methodName: "DCREXPDELETEMOBILE_1", tables: tables, response_code: self.MESSAGE_INTERNET_DCR_DELETEEXP, vc: self, multiTableResponse: true)
            
        }
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        msg = "Are you sure, you want to delete?"
        
        alertViewController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        
        alertViewController.addAction(cancel)
        alertViewController.addAction(delete)
        
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    
   
}
