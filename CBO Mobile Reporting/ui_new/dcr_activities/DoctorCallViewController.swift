//
//  DoctorCallViewController.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 08/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import SQLite3
import SQLite
import CoreLocation
class DoctorCallViewController: CustomUIViewController , CustomTextViewWithButtonDelegate,CheckBoxWithLabelDelegate {
    func onClickListnter(sender: CustomTextViewWithButton) {
        switch (sender.getTag()) {
        case WORK_WITH_DILOG:
            onClickWorkWith()
        
        default:
            print("tag not assighned")
        }
    }
    
    func onCheckedChangeListner(sender: CheckBoxWithLabel, ischecked: Bool) {
        if (ischecked && plan_type == ("1")){
            call_type="1";
        }else if ( plan_type == ("1")){
            
            remark.setFocus(focus: false)
            call_type="0";
            
            dr_id = ""
            doc_name = ""
            Dr_Name.text = "--Select--"
            
            work_with_name = ""
            work_with_id = ""
            
            work_with.setText(text: work_with_name)
            
            
            
            RemoveAllviewsinProduct(myStackView: doctorReport)
            doctorReport.isHidden = true
            
            lblSelect_Remark.text = "--Select Remark--"
            remark.setText(text: "");
            remark.isHidden = true
            
        }else{
            call_type="2";
        }
        
        setSubmitBtnTxt()
    }
    
    @IBOutlet weak var summaryViewHeight: NSLayoutConstraint!
    
    var buttonWith : NSLayoutConstraint!
 
    var latLong = "Not Found";


    var summary_list = [[String : [String : [String]]]]()
    var doctor_list = [String : [String]]();
   // private static final String TAG = DrCall.class.getSimpleName();
    
    var presenter : ParantSummaryAdaptor!
    @IBOutlet weak var doctorSummaryTableView: UITableView!
    
    @IBOutlet weak var submitBtn: CustomeUIButton!
    
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var plannedButton: CustomHalfRoundButton!
    
    @IBOutlet weak var unplannedButton: CustomHalfRoundButton!
    @IBOutlet weak var slelectedTabBarButtom: UIView!
    
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    
    @IBOutlet weak var doctorCallView: CustomBoarder!
    
    @IBOutlet weak var doctorSummaryview: CustomBoarder!
    
    @IBOutlet weak var call_missed: CheckBoxWithLabel!
    var header = [String]()

    var customVariablesAndMethod : Custom_Variables_And_Method!
    var PA_ID : Int = 0
//    SpinAdapter adapter;
//    RelativeLayout locLayout;
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared

    var dr_name = ""
    var dr_name_reg = ""
    var dr_id = ""
    var dr_id_reg = ""
    var dr_id_index = ""
    var doc_name = ""
    var part1 = ""
    var part2 = ""
    var part3 = ""
    var workwith1 = ""
    var workwith2 = ""
    var workwith34 = ""
    var work_with_name = ""
    var work_with_id = ""
    var docList = [SpinnerModel]();
    var data1 = [String]().self
    var network_status = ""
    var textlength = 0;
    var drInTime = ""
    var myBatteryLevel = ""
    var updated = "0";
    var drKm = "0";
    var live_km = ""
    

    var plan_type = "1"
    var AREA = ""
    var call_type = "0";     //plan_type=1 for planed, 0 for unplaned
    //CheckBox call_missed;
    var currentBestLocation : CLLocation? = nil
    var locExtra = "";
    var remark_list = [String]()
    
    var ref_latLong = "";
    var call_latLong = ""
    
    var autoLoad = false;


   var showRegistrtion = 1;
    let CALL_DILOG = 5 ,REMARK_DILOG = 6,WORK_WITH_DILOG=7 , SUMMARY_DILOG = 8 ,
    REPORT_DIALOG = 9 , MESSAGE_INTERNET_SEND_FCM = 10,CALL_MISSED = 11,MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 12
    
    var MESSAGE_FROM_CHECK_VISUAL_AD=2
    var selected_dr_id = "-1"
    
    var progressHUD : ProgressHUD!
    var multiCallService = Multi_Class_Service_call()
    
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var selectRemark_Layout: CustomBoarder!
    @IBOutlet weak var remark: CustomTextView!
    @IBOutlet weak var myTopview: TopViewOfApplication!
    @IBOutlet weak var otherRemarkTextView: UITextView!
    @IBOutlet weak var Dr_Name: UILabel!
    @IBOutlet weak var loc_layout: UIStackView!
    
  
    @IBOutlet weak var doctorReport: UIView!
    @IBOutlet weak var loc: CustomDisableTextView!
    
    @IBAction func selectDr_Dropdown(_ sender: UIButton) {
            OnClickDrLoad()
    }
    
    @IBOutlet weak var lblSelect_Remark: UILabel!
    @IBAction func selectRemark(_ sender: UITapGestureRecognizer) {
        print("pressed selectede")
        
        OnClickRemarkLoad()
    }
    
    @IBOutlet weak var work_with: CustomTextViewWithButton!
  
  
    
    @IBAction func pressedAddDoctor(_ sender: CustomeUIButton) {
        
        customVariablesAndMethod.getBatteryLevel()
        myBatteryLevel = Custom_Variables_And_Method.BATTERYLEVEL;
        setAddressToUI();
        if (loc.getText() == "" ) {
            loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON);
        }
        if (work_with_id != "") {
            var parts = work_with_id.components(separatedBy: ",")
            if (parts.count == 1) {
                part1 = parts[0];
            }
            if (parts.count == 2) {
                part1 = parts[0];
                part2 = parts[1];
            }
            if (parts.count > 2) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
            }
            workwith1 = part1;
            workwith2 = part2;
            workwith34 = part3;
        }
        
        
        
        
        
        if ( latLong == "0.0,0.0" || latLong == "") {
            latLong = Custom_Variables_And_Method.GLOBAL_LATLON;
        }
        
        if (doc_name == "") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Doctor ...");
        } else if (docList.count == 0) {
            customVariablesAndMethod.msgBox(vc: context,msg: "No Doctor in List");
            
        } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "REMARK_WW_MANDATORY",defaultValue: "").contains("D") &&  work_with_id == "") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please select work-with");
            
            
        } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "REMARK_WW_MANDATORY",defaultValue: "").contains("D") &&  remark.getText() == "") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please enter remark");
            
        }
        else if (call_missed.isChecked()) {
            AppAlert.getInstance()
                .setNagativeTxt(nagativeTxt: "No")
                .setPositiveTxt(positiveTxt: "Yes")
                .DecisionAlert(vc: self,
                               title: "Call Missed !!!",
                               massege: "You really missed the call to \n"+doc_name+" ?",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : DoctorCallViewController!
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        parent.submitDoctor(IsMissedCall: true);
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : DoctorCallViewController) {
                                        self.parent = parent
                                    }
                                }
                                return anonymous(parent: self)
                    })

        }
        else {
        
            let getCurrentTime = customVariablesAndMethod.get_currentTimeStamp();
            let planTime = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DcrPlantimestamp",defaultValue: customVariablesAndMethod.get_currentTimeStamp());
            let t1 = Float(getCurrentTime)!;
            let t2 = Float(planTime)!;
            
            let t3 = t1 - t2;
            if ((t3 >= 0) || (t3 >= -0.9)) {
                submitDoctor(IsMissedCall: false);
            } else {
                customVariablesAndMethod.msgBox(vc: context,msg: "Your Plan Time can not be \n Higher Than Current time...");
            }
        }
    }
    
    
    var context : CustomUIViewController!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        unplannedButton.setButtonColor(color: AppColorClass.tab_unsellected!)
       
        
        context = self
        progressHUD = ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        myTopview.backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside )
        if VCIntent["title"] != nil{
            myTopview.setText(title: VCIntent["title"]!)
            
        }
        
        
        doctorCallView.isHidden = false
        doctorSummaryview.isHidden = true
       
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "SAMPLE_POB_INPUT_MANDATORY",defaultValue: "").contains("U")) {
            unplannedButton.isHidden = false
        }else{
            unplannedButton.isHidden = true
            plannedButton.setText(text: "Call")
            stackViewWidth.constant = plannedButton.frame.size.width + 5
        }
        
        
        
        customVariablesAndMethod.betteryCalculator()

        work_with.delegate = self
        work_with.setTag(tag: WORK_WITH_DILOG)
        work_with.setHint(placeholder: "Press + Sign for Work-With")
        
        setAddressToUI();
      
        remark.setHint(placeholder: "Enter Remark")
        
        remark_list = cbohelp.get_Doctor_Call_Remark();
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        }else{
            loc_layout.isHidden = true
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DR_REMARKYN",defaultValue: "") == "Y") {
            selectRemark_Layout.isHidden = false
        }else{
            selectRemark_Layout.isHidden = true
        }
        
        call_missed.delegate = self
        call_missed.setText(text: "Call Missed")
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "MISSED_CALL_OPTION",defaultValue: "").contains("D")) {
            call_missed.isHidden = false
        }else{
            call_missed.isHidden = true
        }
        
        plannedButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        
        unplannedButton.addTarget(self, action: #selector(pressedUnplanedCallButton), for: .touchUpInside)
        
        summaryButton.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
        
        setTabsUI()
        remark.isHidden = true
       
        summaryBackButton.isHidden = true
        
//        if VCIntent["openSummary"] != nil{
//            if VCIntent["openSummary"] == "Y"{
//                pressedSummaryButton()
//                summaryViewHeight.constant = 0
//                summaryBackButton.isHidden = false
//                summaryBackButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
//
//                 doctorSummaryview.layer.borderColor = UIColor.white.cgColor
//            }
//        }else{
            genrateSummary()
            
             presenter.delegate = self
//        }
        
        setSubmitBtnTxt()
        
        if VCIntent["id"] != nil{
            autoLoad = true
        }
       
    }

    override func viewDidAppear(_ animated: Bool) {
        if autoLoad {
            autoLoad = false;
            OnClickDrLoad();
        }
    }
    
 
    func setSubmitBtnTxt(){
        if (!call_missed.isChecked() && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "DCRSAMPLE_AFTERVISUALAIDYN", defaultValue: "N") == "Y") {
            submitBtn.setText(text: "Visual Ads")
            
        }else{
             submitBtn.setText(text: "Add Doctor")
        }
    }
    
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedUnplanedCallButton(){
        remark.setFocus(focus: false)
        plan_type="0";
        call_type="2";
        plannedButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        unplannedButton.setButtonColor(color: AppColorClass.tab_sellected!)
        doctorCallView.isHidden  = false
        doctorSummaryview.isHidden = true
        call_missed.isHidden = true
        call_missed.setcheched(checked: false)
        
        dr_id = ""
        doc_name = ""
        Dr_Name.text = "--Select--"
        
        work_with_name = ""
        work_with_id = ""
        
        work_with.setText(text: work_with_name)
        
        lblSelect_Remark.text = "--Select Remark--"
        remark.setText(text: "");
        remark.isHidden = true
        
        
        RemoveAllviewsinProduct(myStackView: doctorReport)
        doctorReport.isHidden = true
    }
    
    @objc func pressedSummaryButton(){
        plannedButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        doctorCallView.isHidden  = true
        doctorSummaryview.isHidden = false
    }
    
    
    func genrateSummary(){
        var headers = [ String]()
        var isCollaps = [Bool]()
        doctor_list = cbohelp.getCallDetail(table: "tempdr",look_for_id: "",show_edit_delete: "1")
        
        do {
            summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_DRCALL").getString(key: "D_DRCALL") :    doctor_list])
        }catch{
            print(error)
        }
        
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        
        //myTopview.setText(title: headers[0])
        
        presenter = ParantSummaryAdaptor(tableView: doctorSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps )
        
        doctorSummaryTableView.dataSource = presenter
        doctorSummaryTableView.delegate = presenter
    }
    
    
    
    func onClickWorkWith() {
        if( doc_name == ""){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Doctor....")
        }else{
            var msg = [String : String]()
            msg["header"] = "Select Work-With..."
            msg["sDCR_DATE"] = "1"
            Work_With_Dialog(vc: self, msg: msg, responseCode: WORK_WITH_DILOG).show()
        }
    }
    
    
    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }
    
    
    @IBAction func pressedBottomBackButton(_ sender: CustomeUIButton) {
        Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    
    @objc func pressedBackButton(_ sender: UIButton) {
        Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    // on Remark
    
    func OnClickRemarkLoad(){
        if( doc_name == ""){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Doctor....")
        }else{
            Remark_Dialog(vc: self, title: "Select Remark....", List: remark_list, responseCode: REMARK_DILOG).show()
        }
    }
    
    // submitDoctor
    
    func remAdded() -> [String]{
        var drlist = [String]();
        do{
            let statement = try cbohelp.getDoctorListLocal(plan_type: plan_type,caltype: "1"); //getDoctorName1();
            while let c = statement.next(){
                try drlist.append("\(c[cbohelp.getColumnIndex(statement: statement, Coloumn_Name: "dr_id")]!)");
            }
        } catch{
            print(error)
        }
        return drlist;
    }

    func pressedVisualAd(){
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           
           let vc = storyboard.instantiateViewController(withIdentifier: "CheckboxShowVisualAd") as! CheckboxShowVisualAd
           //let vc = storyboard.instantiateViewController(withIdentifier: "ShowVisualAd") as! ShowVisualAd
           
           if (docList.isEmpty) {
               customVariablesAndMethod.getAlert(vc: self, title: "", msg: "No Doctor in List...")
           }else if (dr_id == "0") {
               customVariablesAndMethod.getAlert(vc: self, title: "", msg: "Select Doctor from List...");
           } else {
            
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_SAVE_SHOW", value: "Y");
            
               Custom_Variables_And_Method.DR_ID = dr_id
               vc.VCIntent["title"] = "Visual Ads"
               vc.VCIntent["who"] = ""
               //vc.VCIntent["sample_name"] = sample_name
               //vc.VCIntent["sample_pob"] = sample_pob
               //vc.VCIntent["sample_sample"] = sample_sample
           
            
                vc.responseCode = MESSAGE_FROM_CHECK_VISUAL_AD
                vc.vc =  self
               self.present(vc, animated: true, completion: nil)
               // startActivity(i);
               //startActivityForResult(i, 0);
           }

       }
    
    func submitDoctor(IsMissedCall : Bool){
        if (remAdded().contains(dr_id)) {
            customVariablesAndMethod.msgBox(vc: context,msg: dr_name + " Allready Added...");
            
        } else if (!IsMissedCall && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "DCRSAMPLE_AFTERVISUALAIDYN", defaultValue: "N") == "Y") {
           pressedVisualAd()
            
        } else {
            
            Custom_Variables_And_Method.DOCTOR_CHECK = "doctor Successfuly check";
            
            var locExtra = ""
            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
            
            let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
            
            if (currentBestLocation != CLLocation()) {
                locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
            }
            
            cbohelp.AddedDoctorMore(drid: dr_id, drname: doc_name, time: customVariablesAndMethod.currentTime(context: context), ww1: workwith1, ww2: workwith2, ww3: workwith34, loc: call_latLong + "!^" + Custom_Variables_And_Method.global_address);
            
            print("doctor inserted more");
            
            /*
             String shareLat = mycon.getDataFrom_FMCG_PREFRENCE("shareLat");
             String shareLon = mycon.getDataFrom_FMCG_PREFRENCE("shareLon");
             String DayPlanLatLong = mycon.getDataFrom_FMCG_PREFRENCE("DayPlanLatLong");*/
            
            cbohelp.addTempDrInLocal(drid: dr_id, drname: doc_name, visit_time: "" + customVariablesAndMethod.currentTime(context: context), batteryLevel: myBatteryLevel, dr_latLong: call_latLong, dr_address: Custom_Variables_And_Method.global_address, dr_remark: remark.getText(), updated: updated, dr_Km: drKm,srno: customVariablesAndMethod.srno(context: context),work_with_name: work_with_name,DR_AREA: AREA,file: "",call_type: call_type, LOC_EXTRA: locExtra,Ref_latlong: ref_latLong);
            
            submitDoctorInLocal();

        }
    }
    
    
    func submitDoctorInLocal() {
    
        cbohelp.insertDoctorInLocal(dr_id: dr_id, dr_name: doc_name, ww1: workwith1, ww2: workwith2, ww3: workwith34, loc: call_latLong + "!^" + loc.getText(), time: customVariablesAndMethod.currentTime(context: context),LOC_EXTRA: locExtra);
    
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "DCRSAMPLE_AFTERVISUALAIDYN", defaultValue: "N") != "Y"){
            customVariablesAndMethod.msgBox(vc: context,msg: doc_name + "Added Successfully", completion:{_ in
                 self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "D",Id: self.dr_id,latlong: "")})
        }else{
            multiCallService.SendFCMOnCall(vc: self, response_code: MESSAGE_INTERNET_SEND_FCM, progressHUD: progressHUD, DocType: "D",Id: dr_id,latlong: "")
        }

    
    
    }

    func RemoveAllviewsinProduct(myStackView : UIView){
        while( myStackView.subviews.count > 0 ) {
            myStackView.subviews[0].removeFromSuperview()
        }
    }
    
    
 
    func ShowDrSampleGift( titleName : [String],  itemName : [String]  , myStackView : UIView){
        myStackView.backgroundColor = UIColor.white
        
        RemoveAllviewsinProduct(myStackView: myStackView)
        
        var heightConstraint : NSLayoutConstraint!

        var previousStackView : UIStackView!
        
        
//        let myLabel = UILabel()
//        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myStackView.addSubview(myLabel)
//        myLabel.text =  "Gift"
//        myLabel.numberOfLines = 0
//        myLabel.font = myLabel.font.withSize(13)
//        myLabel.backgroundColor = UIColor.white
//        myLabel.textColor = .white
//        myLabel.isHidden = true
//
//        let myLabel2 = UILabel()
//        myStackView.addSubview(myLabel2)
//        myLabel2.translatesAutoresizingMaskIntoConstraints = false
//        myLabel2.numberOfLines = 0
//        myLabel2.backgroundColor =  UIColor.white
//        myLabel2.font = myLabel2.font.withSize(13)
//        myLabel2.textAlignment = .center
//        myLabel2.textColor = .white
//        myLabel2.text =  "Qty."
//        myLabel2.isHidden = true
        
        
        let myinnerStackView = UIStackView()
        myinnerStackView.axis =  .horizontal
        myStackView.addSubview(myinnerStackView)
        myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
        
        
//        myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
//        myLabel2.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor ).isActive =  true
//        myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
//
//        myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
//        myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
//        myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
//        myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
        
        
        
        myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor , constant : 5).isActive = true
        myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
        myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor ).isActive =  true
        
        
        
//        heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 0)
//        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
//        heightConstraint.isActive =  true
//
//
//        widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
//        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
//        widthConstraint.isActive =  true
        
        previousStackView = myinnerStackView
        
        for i in 0 ..< titleName.count{
            
            if itemName[i] != ""{
                
           
            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myStackView.addSubview(myLabel)
            myLabel.text =  titleName[i]
            myLabel.numberOfLines = 0
            myLabel.textColor = UIColor.black
            myLabel.font =  UIFont.boldSystemFont(ofSize: 14.0)
            //myLabel.backgroundColor = .gray
            
            
            let myLabel2 = UILabel()
            myStackView.addSubview(myLabel2)
            myLabel2.translatesAutoresizingMaskIntoConstraints = false
            myLabel2.numberOfLines = 0
            //myLabel2.backgroundColor = .lightGray
            myLabel2.textAlignment = .right
            myLabel2.textColor = UIColor.black
            myLabel2.font = UIFont(name:"HelveticaNeue", size: 14.0)
            myLabel2.text =  itemName[i]
            
          
            
            let myinnerStackView = UIStackView()
            myinnerStackView.axis =  .horizontal
            myStackView.addSubview(myinnerStackView)
            myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
            
            
            myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor ).isActive =  true
            myLabel2.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor , constant : -5).isActive =  true
            myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor ).isActive = true
            
            myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
            myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor , constant : 5).isActive =  true
            myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor ).isActive = true
            
            
            
            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
            
            
            
            heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true
            
            
            previousStackView = myinnerStackView
            }
        }
        previousStackView.bottomAnchor.constraint(equalTo: myStackView.bottomAnchor , constant : -5).isActive =  true
    }
    
    
    // on call
    
    func OnClickDrLoad(){
        do{
            
            var caltype : String? = nil;
            if VCIntent["id"] != nil{
                caltype = "0";
            }
            
            let statement = try cbohelp.getDoctorListLocal(plan_type: plan_type,caltype: caltype);
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
                
            
            
            Call_Dialog(vc: self, title: "Select Doctor....", dr_List: docList, callTyp: call_type == "1" ? "M": "D", responseCode: CALL_DILOG).show()
        //docList = new ArrayList<SpinnerModel>();
        //GPS_Timmer_Dialog(context,mHandler,"Scanning Doctors...",GPS_TIMMER).show();
        }catch {
            print(error)
        }
    }
   
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
        case CALL_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //Dr_Name.text = docList[Int(inderData["Selected_Index"]!)!].getName()
            dr_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            doc_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
            Dr_Name.text = doc_name
            ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
            call_latLong = inderData["latLong"]!
            // showing details
            
            let titleNAme = ["Area","Class","Potential","Last Visited","Dr CRM","Campaign Group"]
            AREA = docList[Int(inderData["Selected_Index"]!)!].getAREA()
            let itemName = [AREA, docList[Int(inderData["Selected_Index"]!)!].getCLASS() , docList[Int(inderData["Selected_Index"]!)!].getPOTENCY_AMT(), docList[Int(inderData["Selected_Index"]!)!].getLastVisited(), docList[Int(inderData["Selected_Index"]!)!].getCRM_COUNT(), docList[Int(inderData["Selected_Index"]!)!].getDRCAPM_GROUP()]
            
            

            ShowDrSampleGift(titleName: titleNAme, itemName: itemName, myStackView: doctorReport)
            doctorReport.isHidden = false
            break
        case REMARK_DILOG:
            
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            lblSelect_Remark.text = remark_list[Int(inderData["Selected_Index"]!)!]
            
            if (lblSelect_Remark.text?.lowercased() == "other"){
                remark.setText(text: "");
                remark.isHidden = false
            }else{
                remark.setText(text: lblSelect_Remark.text!);
                remark.isHidden = true
            }
            break
            
            
        case WORK_WITH_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
    
            work_with_name = inderData["workwith_name"]!
            work_with_id = inderData["workwith_id"]!
            
            work_with.setText(text: work_with_name)
            break
        case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
            progressHUD.dismiss()
            cbohelp.delete_tenivia_traker( DR_ID :selected_dr_id);
            cbohelp.delete_Doctor_from_local_all(dr_id: selected_dr_id)
            myTopview.CloseCurruntVC(vc: self)
            
            break
        case MESSAGE_INTERNET_SEND_FCM + 100 :
            self.multiCallService.parser_FCM(dataFromAPI: dataFromAPI)
            break
        case MESSAGE_INTERNET_SEND_FCM :
            progressHUD.dismiss()
            if (!call_missed.isChecked()  && customVariablesAndMethod.IsProductEntryReq(context : self) ){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Doctor_Sample") as!
                Doctor_Sample
                vc.VCIntent["title"] = "Dr. Sample...."
                vc.VCIntent["Back_allowed"] = "N"
                vc.VCIntent["dr_id"] = self.dr_id
                vc.VCIntent["dr_name"] = self.doc_name
                self.present(vc, animated: true, completion: nil)
            }else{
                  Custom_Variables_And_Method.closeCurrentPage(vc: self)
            }
            break
        case MESSAGE_FROM_CHECK_VISUAL_AD:

            let data = dataFromAPI["data"]!
            let inderData = data[0] as! [String: [String]]
            
            let selected_group_item_ids : [String] = inderData["ITEM_ID"]!
            let selected_group_item_names : [String] = inderData["ITEM_NAME"]!
            
            cbohelp.deletedata(drid: dr_id, Rate: "");
            
            for i in 0..<selected_group_item_ids.count{
                cbohelp.insertdata(drid: dr_id, item: selected_group_item_ids[i], item_name: selected_group_item_names[i], qty: "0", pob: "0", stk_rate: "0", visual: "1",noc: "0");
            }
           
           
            submitDoctor(IsMissedCall: true)
            break;
        case 99:
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            print("Error")
            
        }
    }
    
}



extension DoctorCallViewController : ParantSummaryAdaptorDalegate {
    
    func onEdit(id: String , name : String) {
        if (name.contains("(M)")){
            Custom_Variables_And_Method.getInstance().getAlert(vc: self,title: "Alert!!!",msg: "You can't edit for missed doctor ");
        }else{
            AppAlert.getInstance()
                .setNagativeTxt(nagativeTxt: "No")
                .setPositiveTxt(positiveTxt: "Yes")
                .DecisionAlert(vc: self,
                               title: "Edit!!!",
                               massege: "Do you want to Edit \(name) ?",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : DoctorCallViewController!
                                    var id: String!
                                    var name: String!
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        parent.setTabsUI()
                                        parent.openDoctorSample(id : id , name: name)
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : DoctorCallViewController,id: String , name : String) {
                                        self.parent = parent
                                        self.id = id
                                        self.name = name
                                    }
                                }
                                return anonymous(parent: self,id: id,name: name)
                })
        }
        
        
    }
    
    func onDelete(id: String , name: String) {
        selected_dr_id = id
        let tenivia_traker = cbohelp.getCallDetail(table: "tenivia_traker",look_for_id: id,show_edit_delete: "1");
        if (tenivia_traker.count > 0 && tenivia_traker["id"]!.contains ("-99") ) {
            
            
            AppAlert.getInstance()
                .setPositiveTxt(positiveTxt: "Delete")
                .DecisionAlert(vc: self,
                               title: "Delete!!!",
                               massege: "Do you Really want to delete " + name + " ?",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : DoctorCallViewController!
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
                                    
                                    init(parent : DoctorCallViewController,id: String,Dr_name : String) {
                                        self.parent = parent
                                        self.id = id
                                        self.Dr_name = Dr_name
                                    }
                                    
                                }
                                return anonymous(parent: self,id: id,Dr_name : name)
                })
        }else{
            let menu_name = customVariablesAndMethod.getTaniviaTrakerMenuName(context: self)
            var msg = "You can't delete from here.\n Because you have \(menu_name).\nIf you want to delete then first delete from \(menu_name)."
    
            
            Custom_Variables_And_Method.getInstance().getAlert(vc: self,title: "\(menu_name)!!!",msg: msg);
        }
        
        
        
        
    }
    
    func getChild(groupPosition : Int , childname : String) -> [String : [String]]{
        return summary_list[groupPosition][childname]!
    }
    
    

    
    
    
    
    
    private func openDoctorSample(id : String , name : String){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Doctor_Sample") as! Doctor_Sample
        
        vc.VCIntent["title"] = "Dr. Sample"
        vc.VCIntent["Back_allowed"] = "Y"
        vc.VCIntent["dr_id"] = id
        vc.VCIntent["dr_name"] = name
       
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func setTabsUI(){
        remark.setFocus(focus: false)
        plan_type="1";
        call_type="0";
        if (call_missed.isChecked()){ // if call is to be missed
            call_type="1";
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "MISSED_CALL_OPTION",defaultValue: "").contains("D")) {
            call_missed.isHidden = false
        }else{
            call_missed.isHidden = true
        }
        
        call_missed.setcheched(checked: false)
        
        dr_id = ""
        doc_name = ""
        Dr_Name.text = "--Select--"
        
        work_with_name = ""
        work_with_id = ""
        
        work_with.setText(text: work_with_name)
        
        
        
        RemoveAllviewsinProduct(myStackView: doctorReport)
        doctorReport.isHidden = true
        
        lblSelect_Remark.text = "--Select Remark--"
        remark.setText(text: "");
        remark.isHidden = true
    
        
        plannedButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        unplannedButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        doctorCallView.isHidden  = false
        doctorSummaryview.isHidden = true
    }
}


























