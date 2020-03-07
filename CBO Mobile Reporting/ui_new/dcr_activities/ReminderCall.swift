//
//  ReminderCall.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation
class ReminderCall: CustomUIViewController {

    
    var presenter : ParantSummaryAdaptor!
    @IBOutlet weak var reminderSummaryTableView: UITableView!
    
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var callButton: CustomHalfRoundButton!
    
    @IBOutlet weak var slelectedTabBarButtom: UIView!
    

    @IBOutlet weak var summaryStackView: UIStackView!
    
    @IBOutlet weak var reminderCallView: CustomBoarder!
    
    @IBOutlet weak var reminderSummaryview: CustomBoarder!
    
    
    var reminder_list = [String : [String]]()
    var  summary_list = [[String : [String : [String]]]]()
    
    
    
    
    
    @IBOutlet weak var loc: CustomDisableTextView!
    @IBOutlet weak var Dr_name: UILabel!
    @IBOutlet weak var Dr_btn: UIButton!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var pressedAddDoctor: CustomeUIButton!
    @IBOutlet weak var remark: CustomTextView!
     @IBOutlet weak var loc_layout: UIStackView!
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var docList = [SpinnerModel]();
    
    
    var header = [String]()
     private var editingIndex = 0
    
    var PA_ID = 0;
    var dr_id="",doc_name="",dr_name_reg="",dr_id_reg = "",dr_id_index = "",dr_name = "";
    
    var showRegistrtion = 1;
    let CALL_DILOG = 5, SUMMARY_DILOG = 7,REPORT_DIALOG = 9,MESSAGE_INTERNET_SEND_FCM = 10,MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11
     var selected_dr_id = "-1"
    
    var context : CustomUIViewController!
    var  progressHUD : ProgressHUD!
   var multiCallService = Multi_Class_Service_call()
    
    var ref_latLong = "";
    var call_latLong = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reminderCallView.isHidden = false
        reminderSummaryview.isHidden = true
        
        
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        
        context = self
        progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        if ( VCIntent["title"] != nil){
            myTopView.setText(title: VCIntent["title"]!)
        }
        customVariablesAndMethod.betteryCalculator()
        
        remark.setHint(placeholder: "Enter Remark")
        
        setAddressToUI();
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        }else{
            loc_layout.isHidden = true
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DR_REMARKYN",defaultValue: "") == "Y") {
            remark.isHidden = false
        }else{
            remark.isHidden = false
        }
        
        Dr_btn.addTarget(self, action: #selector(OnClickDrLoad), for: .touchUpInside )
        pressedAddDoctor.addTarget(self, action: #selector(OnSubmitDr), for: .touchUpInside )
   
        callButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        summaryButton.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
        
        
        
        summaryBackButton.isHidden = true
        genrateSummary()
        presenter.delegate = self


    }
    @IBOutlet weak var summaryViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    

    //MARK:- callButton
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedSummaryButton(){
        callButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        reminderSummaryview.isHidden = false
        reminderCallView.isHidden = true

    }
    func genrateSummary(){
        var headers = [String]()
        var isCollaps = [Bool]()
        reminder_list = cbohelp.getCallDetail(table: "phdcrdr_rc",look_for_id:  "",show_edit_delete: "1")
        do {
            summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_RCCALL").getString(key: "D_RCCALL") :    reminder_list])
        }catch{
            print(error)
        }
        
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
       
        presenter = ParantSummaryAdaptor(tableView:reminderSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        
        reminderSummaryTableView.dataSource = presenter
        reminderSummaryTableView.delegate = presenter
    }

    
    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }
    
    
    @objc func OnSubmitDr(){
        if (Custom_Variables_And_Method.GLOBAL_LATLON == "0.0,0.0") {
            
            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        }
        
        var docrc = [String]();
        if(loc.getText() == "")
        {
            loc.setText(text: "UnKnown Location");
        }
        
        
        //let address=loc.getText()
        
        
        if (doc_name == ""){
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Doctor First...");
            
            
        }else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "REMARK_WW_MANDATORY", defaultValue: "").contains("R") &&  remark.getText() == "") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please enter remark");
        }else{
            
            docrc = cbohelp.getDrRc();
            if(docrc.contains(dr_id)) {
                customVariablesAndMethod.msgBox(vc: context,msg: doc_name + " allready added ");
            } else {
                
                setAddressToUI();
                submitDoctorRcInLocal();
                customVariablesAndMethod.msgBox(vc: context,msg: doc_name + "Added Successfully", completion: {_ in
                    self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "D",Id: self.dr_id,latlong: "")})
                
            }
            
            
        }
    }
    
    
    func submitDoctorRcInLocal(){
        var locExtra = ""
        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
        
        if (currentBestLocation != CLLocation()) {
            locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
        }
    
        if(dr_id == ""){
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Doctor from List");
        }else{
        
        let dcrid = Custom_Variables_And_Method.DCR_ID;
    
    
            customVariablesAndMethod.getBatteryLevel()
            
            cbohelp.insertDrRem(dcrid: dcrid, drid: dr_id, address: call_latLong+"!^"+loc.getText(), time: customVariablesAndMethod.currentTime(context: context),latLong: call_latLong,updated: "0",rc_km: "0",srno: customVariablesAndMethod.srno(context: context),batteryLevel: Custom_Variables_And_Method.BATTERYLEVEL,remark: remark.getText(),file: "",LOC_EXTRA: locExtra,Ref_latlong: ref_latLong);
    print("dr reminder added");
    
   
    }
    }

    
    
    // on call
    
    @objc func OnClickDrLoad(){
        do{
            let statement = try cbohelp.getRcDoctorListLocal();
            // chemist.add(new SpinnerModel("--Select--",""));
            let db = cbohelp
            docList.removeAll()
            while let c = statement.next() {
               
                docList.append(
                    try SpinnerModel(name: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_name")]!)-\(String(describing: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_AREA")]!))",
                        id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_id")]!)",
                        last_visited:  c[db.getColumnIndex(statement: statement, Coloumn_Name: "LAST_VISIT_DATE")]! as! String,
                        CLASS:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"CLASS")]! as! String,
                        POTENCY_AMT: c[db.getColumnIndex(statement: statement, Coloumn_Name:"POTENCY_AMT")]! as! String,
                        ITEM_NAME:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"ITEM_NAME")]! as! String,
                        ITEM_POB:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"ITEM_POB")]! as! String,
                        ITEM_SALE:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"ITEM_SALE")]! as! String,
                        AREA:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"DR_AREA")]! as! String,
                        PANE_TYPE:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"PANE_TYPE")]! as! String,
                        DR_LAT_LONG:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"DR_LAT_LONG")]! as! String,
                        FREQ:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"FREQ")]! as! String,
                        NO_VISITED:  c[db.getColumnIndex(statement: statement, Coloumn_Name: "NO_VISITED")]! as! String,
                        DR_LAT_LONG2:  c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG2")]! as! String,
                        DR_LAT_LONG3:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"DR_LAT_LONG3")]! as! String,
                        COLORYN:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"COLORYN")]! as! String,
                        CALLYN:  "\(c[db.getColumnIndex(statement: statement, Coloumn_Name:"CALLYN")]!)",
                        CRM_COUNT:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"CRM_COUNT")]! as! String,
                        DRCAPM_GROUP:  c[db.getColumnIndex(statement: statement, Coloumn_Name:"DRCAPM_GROUP")]! as! String,APP_PENDING_YN :  c[db.getColumnIndex(statement: statement, Coloumn_Name:"APP_PENDING_YN")]! as! String
                    )
                );
            }
            
            Call_Dialog(vc: self, title: "Select Doctor...", dr_List: docList, callTyp: "D", responseCode: CALL_DILOG).show()
            //docList = new ArrayList<SpinnerModel>();
            //GPS_Timmer_Dialog(context,mHandler,"Scanning Doctors...",GPS_TIMMER).show();
        }catch {
            print(error)
        }
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
            
        case SUMMARY_DILOG :
            
            
//            doc_name = "\(dataFromAPI["name"]![editingIndex])"
//            Dr_name.text = doc_name
//            remark.setText(text: dataFromAPI["remark"]![editingIndex] as! String)
            break
        case CALL_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //Dr_name.text = docList[Int(inderData["Selected_Index"]!)!].getName()
            dr_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            doc_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
             Dr_name.text = doc_name
            
            ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
            call_latLong = inderData["latLong"]!
            
            pressedAddDoctor.setText(text: "Update Doctor")
            break
        case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
            progressHUD.dismiss()
            self.cbohelp.delete_DoctorRemainder_from_local_all(dr_id: self.selected_dr_id)
            self.myTopView.CloseCurruntVC(vc: self)
            break
            
        case MESSAGE_INTERNET_SEND_FCM + 100 :
            self.multiCallService.parser_FCM(dataFromAPI: dataFromAPI)
            break
        case MESSAGE_INTERNET_SEND_FCM :
            progressHUD.dismiss()
            self.myTopView.CloseAllVC(vc: self.context)
            break
        case 99:
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            print("Error")
            
        }
    }
    

    
    @objc func pressedBack(){
        myTopView.CloseCurruntVC(vc: self)
    }
   
}




extension ReminderCall : ParantSummaryAdaptorDalegate{
    
    
    func onEdit(id: String , name : String) {
    
        getAlert(id:id, name : name ,  title: "Edit")
    }
    
    func onDelete(id: String , name: String) {
        selected_dr_id = id //@rinku
        //getAlert(id : id ,name : name , title: "Delete")
        AppAlert.getInstance()
            .setPositiveTxt(positiveTxt: "Delete")
            .DecisionAlert(vc: self,
                           title: "Delete!!!",
                           massege: "Do you Really want to delete " + name + " ?",
                           listener: { () -> OnClickListener in
                            class anonymous  : OnClickListener {
                                var parent : ReminderCall!
                                var id: String!
                                var Dr_name: String!
                                
                                func onPositiveClicked(item: UIView?, result: String) {
                                    
                                    //Start of call to service
                                    
                                    var params = [String : String]()
                                    params["sCompanyFolder"] = parent.cbohelp.getCompanyCode()
                                    params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
                                    params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
                                    params["iDR_ID"] = id
                                    params["sTableName"] =  "DOCTOR"
                                    
                                    
                                    var tables = [Int]()
                                    tables.append(0)
                                    
                                    parent.progressHUD.show(text: "Please Wait..." +
                                        "\nDeleting " + Dr_name + " from DCR..." )
                                    //        self.view.addSubview(progressHUD)
                                    
                                    CboServices().customMethodForAllServices(params: params, methodName: "DRCHEMDELETE_MOBILE", tables: tables, response_code: parent.MESSAGE_INTERNET_DRCHEMDELETE_MOBILE, vc : parent)
                                    
                                    
                                    //End of call to service
                                }
                                
                                func onNegativeClicked(item: UIView?, result: String) {
                                    
                                }
                                init(parent : ReminderCall,id: String,Dr_name : String) {
                                    self.parent = parent
                                    self.id = id
                                    self.Dr_name = Dr_name
                                }
                            }
                            return anonymous(parent: self,id: id,Dr_name : name)
            })
    }
    
    func getChild(groupPosition : Int , childname : String) -> [String : [String]]{
        return summary_list[groupPosition][childname]!
    }
    
    
    
    // alert msg
    
    func getAlert(id  : String  , name : String , title : String){
        var msg = ""
        
        
        var alertViewController : UIAlertController!
        let edit = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.setTabsUI()
            self.doc_name = name
            self.dr_id = id
            self.Dr_name.text = self.doc_name
         
        }
        
        let delete = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.setTabsUI()
            self.doc_name = name
            self.dr_id = id
            self.Dr_name.text = self.doc_name
            self.cbohelp.delete_DoctorRemainder_from_local_all(dr_id: self.dr_id)
            self.myTopView.CloseCurruntVC(vc: self)
        }
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        
        if title.lowercased() == "delete"{
            msg = "Do you Really want to\(title.lowercased()) \(name) ?"
            
            alertViewController = UIAlertController(title: "\(title)!!!", message: msg, preferredStyle: .alert)
            
            alertViewController.addAction(cancel)
            alertViewController.addAction(delete)
            
        }else {
            msg = "Do you want to\(title.lowercased()) \(name) ?"
            alertViewController = UIAlertController(title: "\(title)!!!", message: msg, preferredStyle: .alert)
            alertViewController.addAction(cancel)
            alertViewController.addAction(edit)
        }
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func setTabsUI(){
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        reminderCallView.isHidden  = false
        reminderSummaryview.isHidden = true
    }
}

