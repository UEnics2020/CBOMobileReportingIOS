//
//  DCR_Route_new.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 26/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import DPDropDownMenu
import CoreLocation
class DCR_Route_new: CustomUIViewController , CustomPanelDelegate{
    func onDivertChangeListner(sender: CustomPanel, ischecked: Bool) {
       
        switch (sender.getTag()) {
        case WORK_WITH_DILOG:
             setUITitles();
            if (!ischecked){
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key :"work_with_name",value : TP_work_with_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key :"work_with_id",value :TP_work_with_id);
                
                
                cbohelp.deleteDRWorkWith();
                var TP_work_with_name_list  = TP_work_with_name.split(separator: ",")
                var TP_work_with_id_list = TP_work_with_name.split(separator: ",")
                for i in 0 ..< TP_work_with_id_list.count {
               
                    cbohelp.insertDrWorkWith(wwname: String(TP_work_with_name_list[i]), wwid: String(TP_work_with_id_list[i]));
                }
                cbohelp.insertDrWorkWith(wwname: "Independent", wwid: "\(PA_ID)");
                
                work_with_name = TP_work_with_name;
                work_with_id = TP_work_with_id;
                
                setWorkwith(work_with_name: work_with_name);
            }else{
                onClickListner(sender: sender)
            }
        case ROUTE_DILOG:
            
            
            if(ischecked && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc :context,key : "DIVERT_REMARKYN",defaultValue : "N").uppercased() == ("Y")){
                rootLayout.setDivertRemark(remark: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : context,key : "sDivert_Remark",defaultValue : ""));
            }
            
             setUITitles();
            
            if (!ischecked){
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key :"route_Route_Name",value :TP_root_name);
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key :"route_Route_ID",value:TP_root_id);
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key :"area_name",value:TP_area_name);
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "area_id",value:TP_area_id);
                
                area_name=TP_area_name;
                area_id=TP_area_id;
                root_name=TP_root_name;
                root_id=TP_root_id;
                
                setRoute(root_name: root_name);
                setArea(area_name: area_name);
                
            }else{
                onClickListner(sender: sender)
            }
        default:
            print("tag not assighned")
        }
    }
    
    
    func onClickListner(sender: CustomPanel) {
        switch (sender.getTag()) {
        case WORK_WITH_DILOG:
            onClickWorkWith()
        case AREA_DILOG:
            onClickAreaLayout()
        case ROUTE_DILOG:
            onClickRouteLayout()
        default:
            print("tag not assighned")
        }
    }
    
    
    @IBOutlet weak var myContentView: UIView!
    //var VCIntent = [String:String]()
    
    var progressHUD : ProgressHUD!
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    @IBOutlet weak var workinkWithDropDown :  DPDropDownMenu!
    @IBOutlet weak var lblRoute: UILabel!
    @IBOutlet weak var workwithlayout: CustomPanel!
    @IBOutlet weak var stackLocationStackView: UIStackView!
    @IBOutlet weak var lblDcrPendingDate: MarqueeLabel!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    
    
    @IBOutlet weak var late_remark: CustomTextView!
    
    //    @IBOutlet weak var workWithLayout: UIView!
    @IBOutlet weak var rootLayout: CustomPanel!
    @IBOutlet weak var areaLayout: CustomPanel!
    @IBOutlet weak var loc: UnderlineTextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var back: CustomeUIButton!
    
    @IBOutlet weak var save: CustomeUIButton!
    
    
    var list = [DPItem]()
    
    var PA_ID : Int = 0
    var paid1 = "";
    var root_id = "";
    var root_name = "", myArea : String = ""
    var Root_Needed : String = ""
    var currentBestLocation = CLLocation()
    var mLatLong : String = ""
    var mAddress = "" , LocExtra = ""
    var fmcg_Live_Km = "";
    
    var workwith1 = "", workwith2 = "", workwith34 = "", workWith4 = "", workWith5 = "", workWith6 = "", workWith7 = "", workWith8 = "", address = "", work_withme = "", work_name = "";
    
    var real_date = "";
    var work_val = "",work_type_code = "";
    var work_with_name = "", work_with_id = "", area_name = "", area_id = "";
    var TP_work_with_name = "", TP_work_with_id = "", TP_area_name = "", TP_area_id = "",TP_root_id = "",TP_root_name = "";
    
    var work_type_Selected = ""
    let  MESSAGE_INTERNET_WORKTYPE=1,MESSAGE_INTERNET_SUBMIT_WORKING=2,MESSAGE_INTERNET_DCRCOMMIT_DOWNLOADALL=3,GPS_TIMMER=4;
    let  WORK_WITH_DILOG=5,ROUTE_DILOG=6,AREA_DILOG=7,MESSAGE_INTERNET_TP = 8;
   
    var context : CustomUIViewController!
    //MARK: - Open Wrok with
   func onClickWorkWith() {
    if (getDelegate().getDCR().getShowWorkWithAsPerTP().uppercased() != ("Y")
        ||  workwithlayout.IsDiverted() || TP_work_with_name.trimmingCharacters(in: .whitespaces).isEmpty) {
            var msg = [String : String]()
            msg["header"] = "Work With"
            msg["sDCR_DATE"] = real_date
            msg["PlanType"] = VCIntent["plan_type"]
            msg["DIVERTWWYN"] = workwithlayout.IsDiverted() ? "1":"0"
            msg["sWorking_Type"] = work_val
            Work_With_Dialog(vc: self, msg: msg, responseCode: WORK_WITH_DILOG).show()
        }else{
        AppAlert.getInstance().getAlert(vc: context,title: "Alert!!!",massege: "DCR is configured as per TP. To divert please select \"Divert WorkWith\"...");
        }
    }
    
    
func onClickAreaLayout(){
        
        work_name = workwithlayout.getText()
        root_name = rootLayout.getText()
        if (work_name == "" &&  !work_type_code.contains("_W")
              && getDelegate().getUser().getDesginationID() != ("1")) {
            customVariablesAndMethod.getAlert(vc: context,title: "Work with !!!",msg: "Please Select Work with First...");
        } else if (root_name == "") {
            customVariablesAndMethod.getAlert(vc: context,title: "Route  !!!",msg: "Please Select Route First .....");
        } else if (checkforCalls()) {
            AppAlert.getInstance()
                .DecisionAlert(vc: context, title: "Call Found!!!",
                               massege: "Some Calls found in your Day Summary.\nYou can only add Additional Areas \n" +
                    "Else Reset your Day Plan from Utility",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : DCR_Route_new!
                                    
                                    func onPositiveClicked(item: UIView?, result: String) {
                                       parent.openArea(freeze: true);
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : DCR_Route_new) {
                                        self.parent = parent
                                    }
                                }
                                return anonymous(parent: self)
                });
        }  else {
            openArea(freeze: false);
        }
    }
    
    private func openArea( freeze : Bool){
        if (getDelegate().getDCR().getAdditionalAreaApprovalReqd().uppercased() == ("Y")) {
            
            AppAlert.getInstance()
                .DecisionAlert(vc: self,
                               title: "Alert!!!",
                               massege: "Approval will be required for Doctor/Chemist",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : DCR_Route_new!
                                    var freeze : Bool
                                    
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        var msg = [String : Any]()
                                        msg["header"] = parent.areaLayout.getTitle()
                                        msg["sAllYn"] = "0"
                                        msg["max"] =  parent.getDelegate().getDCR().getNoOfAddAreaAlowed()
                                        msg["freeze"] = freeze;
                                        Area_Dialog(vc: parent, msg: msg, responseCode: parent.AREA_DILOG).show()
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : DCR_Route_new,freeze : Bool) {
                                        self.parent = parent
                                        self.freeze = freeze
                                    }
                                }
                                return anonymous(parent: self, freeze: freeze)
                })
            
            
        
        }else {
            var msg = [String : Any]()
            msg["header"] = areaLayout.getTitle()
            msg["sAllYn"] = "0"
            msg["max"] =  getDelegate().getDCR().getNoOfAddAreaAlowed()
            msg["freeze"] = freeze;
            Area_Dialog(vc: self, msg: msg, responseCode: AREA_DILOG).show()
            
       
        }
    }

 func onClickRouteLayout () {
        work_name = getWorkwith()
    let allowMultipleRoute = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:  context,key:  "DCR_MULTIPLE_ROUTEYN",defaultValue : "N").uppercased() == ("Y")
        if (Custom_Variables_And_Method.pub_desig_id == "1" && checkforCalls() && !allowMultipleRoute) {
            customVariablesAndMethod.getAlert(vc: context,title: "Call Found",msg: "Can not change Root !!! \nSome Calls found in your Day Summary.\nElse Reset your Day Plan from Utilies");
        }else if (work_name == "" &&  !work_type_code.contains("_W")
               && getDelegate().getUser().getDesginationID() != ("1")) {
            customVariablesAndMethod.getAlert(vc: context,title: "Work with !!!",msg: "Please Select Work with First...");
        } else  if (getDelegate().getDCR().getShowRouteAsPerTP().uppercased() == ("Y")
            &&  !rootLayout.IsDiverted() && !TP_root_name.trimmingCharacters(in: .whitespaces).isEmpty) {
            AppAlert.getInstance().getAlert(vc: context,title: "Alert!!!",massege: "DCR is configured as per TP. To divert please select \"Divert Route\"...");
            
        }else {
    
            //Intent i = new Intent(context, DcrRoot.class);
            
            var sAllYn = "N", dcr_root_divert = "0";
            if(rootLayout.IsDiverted() ){
                sAllYn="Y";
                dcr_root_divert="1";
            }
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "dcr_root_divert",value: dcr_root_divert);
    

            var msg = [String : Any]()
            msg["header"] = "Route List"
            msg["sAllYn"] = sAllYn
            msg["allowMultipleRoute"] = allowMultipleRoute
            
            Route_Dialog(vc: self, msg: msg, responseCode: ROUTE_DILOG).show()
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = ProgressHUD(vc : self)
        workwithlayout.setTag(tag: WORK_WITH_DILOG)
        rootLayout.setTag(tag: ROUTE_DILOG)
        areaLayout.setTag(tag: AREA_DILOG)
        
        
        workwithlayout.setHint(placeholder: "Press the + sign for Work-With")
        //workwithlayout.setDivertRemarkReqd(required: false)
        rootLayout.setHint(placeholder: "Press the + sign for Route")
        rootLayout.setDivertRemarkReqd(required: true)
        areaLayout.setHint(placeholder: "Press the + sign for Additional Area")
        areaLayout.setdivertReqd(required: false)
        
        //divert_remark.setHint(placeholder: "Enter Divert Remark")
        late_remark.setHint(placeholder: "Enter Late Remark")
        //ROUTEDIVERTYN.setText(text: "Divert Route")
        //DIVERTWWYN.setText(text: "Divert WorkWith")
        
        workwithlayout.delegate = self
        rootLayout.delegate = self
        areaLayout.delegate = self
        
        context = self
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        
        myTopView.backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        
        myTopView.title.text = "Dcr Day Open"
        
        back.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)
        
        
        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        
        PA_ID = Custom_Variables_And_Method.PA_ID;
        paid1 = "\(PA_ID)"
        
        currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation")
        
        mLatLong = Custom_Variables_And_Method.GLOBAL_LATLON;
        mAddress = Custom_Variables_And_Method.global_address;
        
        if (currentBestLocation != CLLocation()) {
            LocExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
        }
        
        Custom_Variables_And_Method.ROOT_NEEDED = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "root_needed",defaultValue: "Y");
        Root_Needed = Custom_Variables_And_Method.ROOT_NEEDED;
        fmcg_Live_Km = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "live_km",defaultValue: "");
        
        Custom_Variables_And_Method.DCR_DATE = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DATE_NAME",defaultValue: "");
        date.text = Custom_Variables_And_Method.DCR_DATE
        Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DATE",defaultValue: "");
        real_date = Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT;

        
        //scrollview.isScrollEnabled = true
        //scrollview.contentSize = CGSize(width: scrollview.frame.width, height: 1000)
        

        if ((Custom_Variables_And_Method.DcrPending_datesList.count == 1) || (Custom_Variables_And_Method.DcrPending_datesList.count == 0)) {
            lblDcrPendingDate.isHidden = true
        } else {

            lblDcrPendingDate.text = Custom_Variables_And_Method.DcrPending_datesList.joined(separator: ",")
            marqueeRun(myMarqueeLabel : lblDcrPendingDate)

        }

        setAddressToUI();
        if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_ADDAREANA",defaultValue: "") == "Y"){
            areaLayout.isHidden = true
            
        }
        rootLayout.setdivertReqd(required: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "ROUTEDIVERTYN",defaultValue: "").uppercased() == "Y")
    
        rootLayout.setDivertRemark(remark: "")

        if (Custom_Variables_And_Method.location_required != "Y") {
            stackLocationStackView.isHidden = true
        }


        workinkWithDropDown.layer.borderWidth = CGFloat(1.0)
        workinkWithDropDown.layer.cornerRadius = 8
        workinkWithDropDown.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        workinkWithDropDown.headerTextColor = AppColorClass.colorPrimaryDark!
        workinkWithDropDown.menuTextColor = AppColorClass.colorPrimaryDark!
        workinkWithDropDown.selectedMenuTextColor = AppColorClass.colorPrimaryDark!



        if(VCIntent["plan_type"] == "p") {

            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "area_name",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "work_with_name",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "work_with_individual_name",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "route_name",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "sDivert_Remark",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc:context,key : "ROUTEDIVERTYN_Checked",value: "N");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "DIVERTWWYN_Checked",value: "0");
            if (!customVariablesAndMethod.IsBackDate(context: context) ) {
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "IsBackDate",value: "1"); //not back date entry
            }else{
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "IsBackDate",value: "0");
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "BackDateReason",value: "");
            }

            //Start of call to service


            var params = [String:String]()
            params["sCompanyFolder"]  = cbohelp.getCompanyCode()
            params["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
            params["sDCR_DATE"] = Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT
            let tables = [0]

            // avoid deadlocks by not using .main queue here
            progressHUD.show(text: "Please Wait.. \n Fetching your worktype" )
    
      CboServices().customMethodForAllServices(params: params, methodName: "DCRWORKINGTYPE_MOBILE_2", tables: tables, response_code: MESSAGE_INTERNET_WORKTYPE, vc : self )
            

            //End of call to service
        }else {
            myTopView.title.text = "Dcr Day Replan"
            work_val=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_head",defaultValue: "Working" );
            work_type_code=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code", defaultValue: "W");

            list.removeAll()
            list.append( DPItem(title : work_val,code : work_type_code) )
            workinkWithDropDown.items.append(list[0])

            workWithPopulate()


            work_with_name =  customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_with_name",defaultValue: "");
            work_with_id = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_with_id",defaultValue: "");
            root_name = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "route_Route_Name",defaultValue: "");
            root_id = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "route_Route_ID",defaultValue: "");
            area_name = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "area_name",defaultValue: "");
            area_id = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "area_name",defaultValue: "");
            
            
            
            TP_work_with_name = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "TP_work_with_name",defaultValue:work_with_name);
            TP_work_with_id=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key:"TP_work_with_id",defaultValue:work_with_id);
            TP_area_name=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key:"TP_area_name",defaultValue:area_name);
            TP_area_id=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key:"TP_area_id",defaultValue:area_id);
            TP_root_name=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key:"TP_root_name",defaultValue:root_name);
            TP_root_id=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key:"TP_root_id",defaultValue:root_id);
            
                setWorkwith(work_with_name: work_with_name)
                setRoute(root_name: root_name)
                setArea(area_name: area_name)
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "IsBackDate",defaultValue: "0") == ("1") ) {
            late_remark.setText(text: "");
            late_remark.isHidden = true
        }else{
            late_remark.isHidden = false
            late_remark.setText(text: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "BackDateReason",defaultValue: ""));
        }
        
        
        // onclick Savelistener
        
        save.addTarget(self, action: #selector(onclickSavelistener), for: .touchUpInside)
        
        // set ui
        setUITitles();
        
    }
    
    func setAddressToUI() {
    
        if (Custom_Variables_And_Method.global_address != "") {
            loc.text = Custom_Variables_And_Method.global_address
        } else
            if (loc.text == "") {
            loc.text = Custom_Variables_And_Method.GLOBAL_LATLON
        } else {
            loc.text = Custom_Variables_And_Method.GLOBAL_LATLON
        }
    }
    
  

    
     func workWithPopulate() {

        workinkWithDropDown.didSelectedItemIndex = { index in
            self.workinkWithDropDown.headerTitle = (self.list[index].title)
            self.work_val = (self.list[index].title)
            self.work_type_code = (self.list[index].code)!
            
            Custom_Variables_And_Method.work_val = self.work_val;
           
            var code = self.work_type_code;
            if (self.work_type_code.contains("NR")){
                code = "W";
            }
            
            switch (code){
            case "OCC","OSC","CSC","W" :
                self.workwithlayout.isHidden = false
                self.rootLayout.isHidden = false
                self.areaLayout.isHidden = false
                
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "ROUTEDIVERTYN", defaultValue: "").uppercased() == "Y"){
                    //self.ROUTEDIVERTYN.isHidden = false
                    self.rootLayout.setdivertReqd(required: true)
                }
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "DIVERTWWYN", defaultValue: "").uppercased() == "Y"){
                    //self.DIVERTWWYN.isHidden = false
                    self.workwithlayout.setdivertReqd(required: true)
                }
                break;
        
            case "HM" :
                self.workwithlayout.isHidden = true
                self.rootLayout.isHidden = true
                self.areaLayout.isHidden = true
                //self.ROUTEDIVERTYN.isHidden = true
                //self.DIVERTWWYN.isHidden = true
                break ;
            case "LR" :
                var url = self.cbohelp.getMenuUrl(menu: "TRANSACTION", menu_code: "T_LR1");
                var url1 = self.cbohelp.getMenuUrl(menu: "PERSONAL_INFO", menu_code: "LEAVE");
                if (url != "") {
                    if ( url.contains("?")) {
                        url = url +  "&DATE=" + Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT ;
                    }else{
                        url = url + "?DATE=" + Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT;
                    }
                    self.customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: "Leave Request", url: url,CloseParent: true)
                    
                } else if (url1 != "") {
                    if ( url1.contains("?")) {
                        url1 = url1 +  "&DATE=" + Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT ;
                    }else{
                        url1 = url1 + "?DATE=" + Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT;
                    }
                    self.customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: "Leave Request", url: url1,CloseParent: true)
                }else {
                    self.customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(self.work_val) is presently under Development...")
                }
                
                break;
            case "M" :
                self.workwithlayout.isHidden = false
                self.rootLayout.isHidden = false
                self.areaLayout.isHidden = false
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "ROUTEDIVERTYN", defaultValue: "").uppercased() == "Y"){
                    //self.ROUTEDIVERTYN.isHidden = false
                    self.rootLayout.setdivertReqd(required: true)
                }
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "DIVERTWWYN", defaultValue: "").uppercased() == "Y"){
                    //self.DIVERTWWYN.isHidden = false
                    self.workwithlayout.setdivertReqd(required: true)
                }
                break ;
            default:
                
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "ROUTEDIVERTYN", defaultValue: "").uppercased() == "Y"){
                   // self.ROUTEDIVERTYN.isHidden = false
                    self.rootLayout.setdivertReqd(required: true)
                }
                if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "DIVERTWWYN", defaultValue: "").uppercased() == "Y"){
                    //self.DIVERTWWYN.isHidden = false
                    self.workwithlayout.setdivertReqd(required: true)
                }
                
            
                
                if (self.work_type_code.contains("_")){
                    if (self.work_type_code.contains("_W")) {
                        self.workwithlayout.isHidden = true
                    }else{
                        self.workwithlayout.isHidden = false
                    }
                    
                    if (self.work_type_code.contains("_R")) {
                        self.rootLayout.isHidden = true
                    }else{
                        self.rootLayout.isHidden = false
                    }
                    
                    if (self.work_type_code.contains("_A")) {
                        self.areaLayout.isHidden = true
                    }else{
                        self.areaLayout.isHidden = false
                    }
                }else{
                    self.workwithlayout.isHidden = false
                    self.rootLayout.isHidden = false
                    self.areaLayout.isHidden = false
                }
            }
            
            self.rootLayout.setDiverted(divert: self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "ROUTEDIVERTYN_Checked", defaultValue: "N") == "Y")
             self.workwithlayout.setDiverted(divert: self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "DIVERTWWYN_Checked", defaultValue: "0") == "1")
            
            if( self.rootLayout.IsDiverted() ){
                self.rootLayout.setDivertRemark(remark: self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self,key : "sDivert_Remark",defaultValue : ""));
            }
            
            if(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DCR_ADDAREANA",defaultValue: "") == "Y"){
                self.areaLayout.isHidden = true
            }
        }
        workinkWithDropDown.selectedIndex = 0
    
        
}
    
    
    private func setUITitles(){
    
        if (getDelegate().getDCR().getShowWorkWithAsPerTP() == ("Y")
            && !workwithlayout.IsDiverted()){
            //get_workwith.setEnabled(false);
             workwithlayout.setTitle(text: getDelegate().getDCR().getWorkWithTitle() + " (As per TP)");
        }else{
             workwithlayout.setTitle(text: getDelegate().getDCR().getWorkWithTitle());
        }

        if (getDelegate().getDCR().getShowRouteAsPerTP() == ("Y")
            && !rootLayout.IsDiverted()){
            //get_area.setEnabled(false);
            rootLayout.setTitle(text: getDelegate().getDCR().getRouteTitle() + " (As per TP)");
        }else{
            rootLayout.setTitle(text: getDelegate().getDCR().getRouteTitle() );
        }

        if (getDelegate().getDCR().getAdditionalAreaApprovalReqd() == ("Y")){
            //get_area.setEnabled(false);
            areaLayout.setTitle(text: getDelegate().getDCR().getAreaTitle() + " (Approval Required)");
        }else{
            areaLayout.setTitle(text: getDelegate().getDCR().getAreaTitle() );
        }
    }
    
    
    private func setArea( area_name : String){
    
        areaLayout.setText(text: "\u{2022} "+area_name.replacingOccurrences(of:"+",with:"\n\u{2022} "));
    }
    
    private func setWorkwith( work_with_name : String){
        workwithlayout.setText(text:"\u{2022} "+work_with_name.replacingOccurrences(of:",",with:"\n\u{2022} "));
    }
    
    private func setRoute( root_name : String){
        rootLayout.setText(text: "\u{2022} "+root_name);
    }
    
    private func getArea() -> String{
        return areaLayout.getText().replacingOccurrences(of: "\u{2022} ", with: "").replacingOccurrences(of: "\n", with: "+");
    }
    
    private func getWorkwith() -> String{
        return   workwithlayout.getText().replacingOccurrences(of: "\u{2022} ", with: "").replacingOccurrences(of: "\n", with: ",");
    }
    
    private func getRoute() -> String{
        return  rootLayout.getText().replacingOccurrences(of: "\u{2022} ", with: "");
    }

    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        progressHUD.dismiss()
        switch response_code {
        case WORK_WITH_DILOG:
         
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //lblWorkWith.text = String(inderData["workwith_name"]!.dropLast())
            
            
            work_with_name = inderData["workwith_name"]!
            work_with_id = inderData["workwith_id"]!
            
            //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_Ww_Name", value: work_with_name);
            //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_Ww_ID", value: work_with_id);
            setWorkwith(work_with_name: work_with_name)
           
            //customVariablesAndMethod.getAlert(vc: context, title: "Error", msg: work_with_name)
            break
        case ROUTE_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            
            root_name = inderData["route_name"]!
            root_id = inderData["route_id"]!
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_Route_Name", value: root_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_Route_ID", value: root_id);
            setRoute(root_name: root_name)
            break
        case AREA_DILOG:
            
            
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //lblAdditionalArea.text = String(inderData["workwith_name"]!.dropLast())
            
            area_name = inderData["area_name"]!
            area_id = inderData["area_id"]!
          
          //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_area_Name", value: area_name);
          //customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "route_area_ID", value: area_id)
            
            setArea(area_name: area_name)
            
            break
        case MESSAGE_INTERNET_WORKTYPE:
            parser_workType(dataFromAPI : dataFromAPI)
        case MESSAGE_INTERNET_TP:
            parser_DCRAsPerTP(dataFromAPI : dataFromAPI)
        case MESSAGE_INTERNET_SUBMIT_WORKING:
            parser_submit_for_working(dataFromAPI : dataFromAPI);
            break;
        case MESSAGE_INTERNET_DCRCOMMIT_DOWNLOADALL:
            parser_DCRCOMMIT_DOWNLOADALL(dataFromAPI : dataFromAPI);
            break;
        case GPS_TIMMER:
            //submitDCR();
            break;
        case 99:
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            print("Error")
        }
    }
  
    
    private func parser_workType(dataFromAPI : [String : NSArray])
    {
        progressHUD.dismiss()
        if(!dataFromAPI.isEmpty){
            let jsonArray =   dataFromAPI["Tables0"]!
            list.removeAll()
            for i in 0 ..< jsonArray.count{
                let innerJson = jsonArray[i] as! [String : AnyObject]
                list.append( DPItem(title : innerJson["FIELD_NAME"] as! String,code : innerJson["WORKING_TYPE"] as! String) )
                workinkWithDropDown.items.append(list[i])
            }
            workWithPopulate()
            getDCRAsPerTP()
        }
    }

    
    
    func checkforCalls() -> Bool {
        var result = 0;
        result += cbohelp.getmenu_count(table: "phdcrdr_rc");
        result += cbohelp.getmenu_count(table: "tempdr");
        result += cbohelp.getmenu_count(table: "chemisttemp");
        //result += cbo_helper.getmenu_count("phdcrstk");
        if (result==0){
            return false;
        }else {
            return true;
        }
    }
    
 
    
    // MARK:- pressedBackButton
    fileprivate func marqueeRun( myMarqueeLabel : MarqueeLabel  )   {
        myMarqueeLabel.tag = 301
        myMarqueeLabel.type = .continuous
        myMarqueeLabel.speed = .rate(70.0)
        myMarqueeLabel.fadeLength = 10.0
        myMarqueeLabel.leadingBuffer = 30.0
        myMarqueeLabel.trailingBuffer = 20.0
        myMarqueeLabel.textAlignment = .center
      //  myMarqueeLabel.textColor = UIColor.white
//        let myMarqueeMsg = " hello CBO's users  this is end of the year 2017 ... we are wishing you happy new year"
//        myMarqueeLabel.text =  myMarqueeMsg
    }
    
   
 
    // MARK:- pressedBackButton
    @objc func pressedBackButton(_ sender: UIButton) {
        Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    

    @objc func onclickSavelistener(_ sender: UIButton) {
        // TODO Auto-generated method stub
        setAddressToUI();
        if (loc.text == "") {
            loc.text = "UnKnown Location"
        }
        myArea = getArea()
        if (myArea == "") {
            myArea = getRoute()
        }
        
//            cbohelp.deletedcrFromSqlite();
//            cbohelp.deleteUtils();
//            cbohelp.deleteDCRDetails();

            if(VCIntent["plan_type"] == "p") {
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "srno", value: "0");
            }
            let FIRST_CALL_LOCK_TIME = Float(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "FIRST_CALL_LOCK_TIME",defaultValue: "0"));
            if (FIRST_CALL_LOCK_TIME==0) {
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "CALL_UNLOCK_STATUS",value: "[CALL_UNLOCK]");
                       customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "CALL_UNLOCK_STATUS",value: "");
            }

        

//            cbohelp.insertUtils(area: Custom_Variables_And_Method.pub_area);
//
//            cbohelp.insertDcrDetails(dcrid: Custom_Variables_And_Method.DCR_ID, pubarea: Custom_Variables_And_Method.pub_area);
        

        let routeCheck = root_id;
        let remarkLenght = Int(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_LETREMARK_LENGTH",defaultValue: "0"));
        if (work_type_code.isEmpty) {
            customVariablesAndMethod.getAlert(vc: context,title: "WorkType !!",msg: "Please Select worktype.....");
        }else if (rootLayout.IsDiverted() && rootLayout.getDivertRemark().isEmpty) {
            customVariablesAndMethod.getAlert(vc: context,title: "Divert Remark !!!",msg: "Please enter Divert Remark");
        }else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "IsBackDate",defaultValue: "1") == "0" && late_remark.getText().count < remarkLenght! ) {
            customVariablesAndMethod.getAlert(vc: context,title: "Back-Date entry !!!",msg: "Please enter Late Remark for Back-Date entry in not less then \(remarkLenght!) letters" ,completion :{ _ in
                self.late_remark.myCustomeTextVIew.becomeFirstResponder()})
        }else if (routeCheck.contains("^")) {

           
            var splitData = customVariablesAndMethod.splitRouteData(route: routeCheck);
            root_id = splitData[0]
            let freq = splitData[1]
            let visited = splitData[2];
            let f = Int(freq);
            let vis = Int(visited);
            if (f! > 0) {
                if (vis! >= f!) {
                    root_id = routeCheck;
                    customVariablesAndMethod.getAlert(vc: context, title: "Limit reached", msg: "Route Visit Frequency is :-\(f!) \n You already Visited :- \(vis!)");
                } else {
                    //new GPS_Timmer_Dialog(context,mHandler,"Day Plan in Process...",GPS_TIMMER).show();
                    submitDCR();
                }
            }
        } else {
            //new GPS_Timmer_Dialog(context,mHandler,"Day Plan in Process...",GPS_TIMMER).show();
          submitDCR();
        }
    }
    
    
    func forWorking(){
        if (getWorkwith() == "" &&  !work_type_code.contains("_W")
            && getDelegate().getUser().getDesginationID() != ("1")) {
            customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Work With Fisrt .....");
        } else if (getRoute() == "") {
            customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Route First .....");
        } else {
            submitWorking();
        }
    }
    
    func submitDCR() {
        work_name = getWorkwith()
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "ROUTEDIVERTYN_Checked",value: rootLayout.IsDiverted() ? "Y":"N") ;
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "DIVERTWWYN_Checked",value: workwithlayout.IsDiverted() ? "1":"0") ;

        mLatLong = customVariablesAndMethod.get_best_latlong(context: context);
        var code = work_type_code;
        if (work_type_code.contains("NR")){
            code = "W";
        }
        switch (code){
            case "OCC" , "OSC", "CSC" , "W":
                forWorking()
            break
            case "HM" :
                submitLeave();
            break ;
            case "M" :
                if (rootLayout.getText() == "") {
                    customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Route First .....");
                } else {
                    getWorkWithIDs();
                    submitforMeeting();
                }
            break ;
            /*case "WBZ" :
             getWorkWith();
             Custom_Variables_And_Method.SELECTED_AREA = area.getText().toString();
             submitNonWorking();
             break ;*/
            default:
                if (work_type_code.contains("_")){
                    if (work_name == "" &&  !work_type_code.contains("_W")
                        && getDelegate().getUser().getDesginationID() == ("1")) {
                    customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Work With Fisrt .....");
                    } else if (root_name == "" && !work_type_code.contains("_R")) {
                    customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Route First .....");
                    } else {
                    getWorkWithIDs();
                    submitforMeeting();
                    }
                }else{
                    if (rootLayout.getText() == "") {
                    customVariablesAndMethod.getAlert(vc: context,title: "Alert !!!",msg: "Please Select Route First .....");
                    } else {
                        getWorkWithIDs();
                         submitforMeeting();
                }
            }
        }
    }
    
    
    func getWorkWithIDs() {
        var part1 = "", part2 = "", part3 = "", part4 = "", part5 = "", part6 = "", part7 = "", part8 = "";
        var parts = work_with_id.components(separatedBy: ",");
        
        if (getWorkwith() == ("") &&
            getDelegate().getUser().getDesginationID() == ("1")) {
            part1 = getDelegate().getUser().getID();
            
            cbohelp.deleteDRWorkWith();
            cbohelp.insertDrWorkWith(wwname: "Independent", wwid: part1);
            
        }else {
            if (parts.count == 1) {
                part1 = parts[0];
            }
            if (parts.count == 2) {
                part1 = parts[0];
                part2 = parts[1];
            }
            if (parts.count == 3) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
            }
            if (parts.count == 4) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
                part4 = parts[3];
            }
            if (parts.count == 5) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
                part4 = parts[3];
                part5 = parts[4];
            }
            if (parts.count == 6) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
                part4 = parts[3];
                part5 = parts[4];
                part6 = parts[5];
            }
            if (parts.count == 7) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
                part4 = parts[3];
                part5 = parts[4];
                part6 = parts[5];
                part7 = parts[6];
            }
            if (parts.count == 8) {
                part1 = parts[0];
                part2 = parts[1];
                part3 = parts[2];
                part4 = parts[3];
                part5 = parts[4];
                part6 = parts[5];
                part7 = parts[6];
                part8 = parts[7];
            }
        }
        workwith1 = part1;
        
        workwith2 = part2;
        
        workwith34 = part3;
        workWith4 = part4;
        workWith5 = part5;
        workWith6 = part6;
        workWith7 = part7;
        workWith8 = part8;
    }

    
    
    func submitWorking() {
    
    getWorkWithIDs();
    /*cbo_helper.delete_phdoctor();
     cbo_helper.deleteChemist();*/
    
        let dcr_root_divert = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "dcr_root_divert",defaultValue: "0");
    
        //Start of call to service
    
        var params = [String:String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPA_ID"] = String( Custom_Variables_And_Method.PA_ID);
        params["sDCR_DATE"] = String( real_date);
        params["sSTATION"] = String( myArea);
        params["iTOTAL_DR"] = "1"
        params["iIN_TIME"] = "99"
        params["iOUT_TIME"] = "0.0"
        params["sM_E1"] = ""
        params["sM_E2"] = ""
        params["sM_E3"] = ""
        params["iIN_TIME1"] = "0.0"
        params["iIN_TIME2"] = "0.0"
        params["iIN_TIME3"] = "0.0"
        params["iOUT_TIME1"] = "0.0"
        params["iOUT_TIME2"] = "0.0"
        params["iOUT_TIME3"] = "0.0"
        params["iWORK_WITH1"] = workwith1
        params["iWORK_WITH2"] = workwith2
        params["iWORK_WITH3"] = workwith34
        params["sDA_TYPE"] = work_val
        params["iDISTANCE_ID"] = String(root_id)
        params["sREMARK"] = ""
        params["sLOC1"] =   "\(mLatLong )@\(LocExtra)!^\(mAddress)"
        params["iRETID"] =  "0"
        params["sWorkingType"] =  work_val
        params["iWORK_WITH4"] =  workWith4
        params["iWORK_WITH5"] =  workWith5
        params["iWORK_WITH6"] =  workWith6
        params["iWORK_WITH7"] =  workWith7
        params["iWORK_WITH8"] =  workWith8
        params["iDivertYn"] =  dcr_root_divert
        params["sLATE_REMARK"] =  late_remark.getText()
        params["sMOBILE_TIME"] = customVariablesAndMethod.currentTime(context: context,addServerTimeDifference: false)
        params["sINDP_WW"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_with_individual_id",defaultValue: "")
        params["sDivert_Remark"] = rootLayout.getDivertRemark() //divert_remark.getText()
        params["iDIVERTWWYN"] =  customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DIVERTWWYN_Checked",defaultValue: "0")
        params["sSTAION_ADDAREA"] =   getArea() 
        let tables = [0]
        
        progressHUD.show(text: "Please Wait.. \nYour Day is being Planed" )
     
        
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCR_COMMIT_ROUTE_10", tables: tables, response_code: MESSAGE_INTERNET_SUBMIT_WORKING, vc : self )
        
        
    
    //End of call to service
    work_type_Selected="w";
    
    }
    
    func submitLeave() {
    
        /* cbo_helper.delete_phdoctor();
         cbo_helper.deleteChemist();*/
        let dcr_root_divert=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "dcr_root_divert",defaultValue: "0");
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPA_ID"] = String(Custom_Variables_And_Method.PA_ID);
        params["sDCR_DATE"] = String(real_date);
        params["sSTATION"] = String(work_val);
        params["iTOTAL_DR"] = "1"
        params["iIN_TIME"] = "99"
        params["iOUT_TIME"] = "0.0"
        params["sM_E1"] = ""
        params["sM_E2"] =  ""
        params["sM_E3"] =  ""
        params["iIN_TIME1"] =  "0.0"
        params["iIN_TIME2"] = "0.0"
        params["iIN_TIME3"] = "0.0"
        params["iOUT_TIME1"] = "0.0"
        params["iOUT_TIME2"] =  "0.0"
        params["iOUT_TIME3"] = "0.0"
        params["iWORK_WITH1"] = ""
        params["iWORK_WITH2"] =  ""
        params["iWORK_WITH3"] =  ""
        params["sDA_TYPE"] = String(work_val)
        params["iDISTANCE_ID"] =  "0"
        params["sREMARK"] =  "0"
        params["sLOC1"] =   "\(mLatLong )@\(LocExtra)!^\(mAddress)"
        params["iRETID"] =  "0"
        params["iWORK_WITH4"] =  "0"
        params["iWORK_WITH5"] =  "0"
        params["iWORK_WITH6"] = "0"
        params["iWORK_WITH7"] =  "0"
        params["iWORK_WITH8"] =  "0"
        params["sWorkingType"] =  work_val
        params["iDivertYn"] = dcr_root_divert
        params["sLATE_REMARK"] =  late_remark.getText()
        params["sMOBILE_TIME"] =  customVariablesAndMethod.currentTime(context: context,addServerTimeDifference: false)
        params["sINDP_WW"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_with_individual_id",defaultValue: "")
        params["sDivert_Remark"] =  rootLayout.getDivertRemark() //divert_remark.getText()
        params["iDIVERTWWYN"] =  customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DIVERTWWYN_Checked",defaultValue: "0")
        params["sSTAION_ADDAREA"] =   getArea()
        
        
        let tables = [0]
        
        progressHUD.show(text: "Please Wait.. \nYour Day is being Planed" )

        
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCR_COMMIT_ROUTE_10", tables: tables, response_code: MESSAGE_INTERNET_SUBMIT_WORKING, vc : self )

    
        //End of call to service
        work_type_Selected="l";
    }
    
    func submitforMeeting(){
        
        getWorkWithIDs();
        
        let dcr_root_divert=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "dcr_root_divert",defaultValue: "0");
        
        //Start of call to service
    
        var params = [String:String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPA_ID"] = String(Custom_Variables_And_Method.PA_ID);
        params["sDCR_DATE"] = real_date
        params["sSTATION"] = work_val
        params["iTOTAL_DR"] = "1"
        params["iIN_TIME"] = "99"
        params["iOUT_TIME"] = "0.0"
        params["sM_E1"] = ""
        params["sM_E2"] = ""
        params["sM_E3"] = ""
        params["iIN_TIME1"] =  "0.0"
        params["iIN_TIME2"] = "0.0"
        params["iIN_TIME3"] = "0.0"
        params["iOUT_TIME1"] = "0.0"
        params["iOUT_TIME2"] = "0.0"
        params["iOUT_TIME3"] = "0.0"
        params["iWORK_WITH1"] = workwith1
        params["iWORK_WITH2"] = workwith2
        params["iWORK_WITH3"] = workwith34
        params["sDA_TYPE"] = work_val
        params["iDISTANCE_ID"] = String(root_id);
        params["sREMARK"] = ""
        params["sLOC1"] = "\(mLatLong )@\(LocExtra)!^\(mAddress)"
        params["iRETID"] = "0"
        params["sWorkingType"] = work_val
        params["iWORK_WITH4"] = workWith4
        params["iWORK_WITH5"] = workWith5
        params["iWORK_WITH6"] = workWith6
        params["iWORK_WITH7"] = workWith7
        params["iWORK_WITH8"] = workWith8
        
        params["iDivertYn"] = dcr_root_divert
        params["sLATE_REMARK"] = late_remark.getText()
        params["sMOBILE_TIME"] = customVariablesAndMethod.currentTime(context: context,addServerTimeDifference: false)
        params["sINDP_WW"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_with_individual_id",defaultValue: "")
        params["sDivert_Remark"] =  rootLayout.getDivertRemark() //divert_remark.getText()
         params["iDIVERTWWYN"] =  customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DIVERTWWYN_Checked",defaultValue: "0")
         params["sSTAION_ADDAREA"] =   getArea()
       
    
        let tables = [0]
        
        progressHUD.show(text: "Please Wait.. \nYour Day is being Planed" )

        CboServices().customMethodForAllServices(params: params, methodName: "DCR_COMMIT_ROUTE_10", tables: tables, response_code: MESSAGE_INTERNET_SUBMIT_WORKING, vc : self )
        
        //End of call to service
        work_type_Selected="n";
    }
    
    
    func setReultForNonWork() {
        if ((Custom_Variables_And_Method.DCR_ID != "0")) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Expenses_NotWorkingVC") as!
            Expenses_NotWorkingVC
            vc.VCIntent["title"] = "Final Submit"
            vc.VCIntent["form_type"] = "final"
            vc.VCIntent["Back_allowed"] = "N"
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func getDCRAsPerTP(){
    
        if (getDelegate().getDCR().getShowRouteAsPerTP().uppercased() == ("Y") ||
        getDelegate().getDCR().getShowWorkWithAsPerTP().uppercased() == ("Y") ) {
        //Start of call to service
        
            var params = [String:String]()
            params["sCompanyFolder"] = getDelegate().getUser().getCompanyCode()
            params["iPaId"] = getDelegate().getUser().getID()
            params["sDCR_DATE"] = "" + real_date
            params["sRouteYN"] = getDelegate().getDCR().getShowRouteAsPerTP()
            params["sWWYN"] = getDelegate().getDCR().getShowWorkWithAsPerTP()
        
            
            var tables =  [Int]()
            tables.append(0) //route
            tables.append(1) //workwith
       
            progressHUD.show(text: "Please Wait.. \n Fetching your TP for the day")
            
            CboServices().customMethodForAllServices(params: params, methodName: "GET_DCR_ROUTEWW_TP", tables: tables, response_code: MESSAGE_INTERNET_TP, vc : self )
        
        }
//        else {
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_work_with_name",value : TP_work_with_name);
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_work_with_id",value :TP_work_with_id);
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_area_name",value : TP_area_name);
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_area_id",value : TP_area_id);
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_root_name",value : TP_root_name);
//            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_root_id",value : TP_root_id);
//
//
//        }
    }
    
    
    
    
    public func parser_DCRAsPerTP(dataFromAPI : [String : NSArray]) {
        do {
        
            //            try {
            
            work_with_name="";
            work_with_id="";
            root_name="";
            root_id="";
            area_name="";
            area_id="";
            
            
            let table0 = dataFromAPI["Tables0"]!;
            for i in 0 ..< table0.count{
                let c = table0[i] as! [String : AnyObject]
                root_id = try c.getString(key: "DISTANCE_ID");
                root_name = try c.getString(key: "ROUTE_NAME");
            }
            
            cbohelp.deleteDRWorkWith();
            let table1 = dataFromAPI["Tables1"]!;
            for i in 0 ..< table1.count{
                let c = table1[i] as! [String : AnyObject]
                work_with_id =  try c.getString(key: "PA_ID") + "," + work_with_id ;
                work_with_name = try c.getString(key: "PA_NAME")  + "," + work_with_name;
                cbohelp.insertDrWorkWith(wwname: try c.getString(key: "PA_NAME"), wwid: try c.getString(key: "PA_ID"));
            }
            cbohelp.insertDrWorkWith(wwname: "Independent", wwid: "\(PA_ID)");
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : context,key : "work_with_name", value : work_with_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "work_with_id",value : work_with_id);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "route_Route_Name",value : root_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "route_Route_ID",value : root_id);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "area_name",value : area_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "area_id",value : area_id);
            
            
            TP_work_with_name = work_with_name;
            TP_work_with_id = work_with_id;
            TP_area_name = area_name;
            TP_area_id = area_id;
            TP_root_name = root_name;
            TP_root_id = root_id;
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_work_with_name",value : TP_work_with_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_work_with_id",value :TP_work_with_id);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_area_name",value : TP_area_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_area_id",value : TP_area_id);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_root_name",value : TP_root_name);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc :context,key : "TP_root_id",value : TP_root_id);
            
            setWorkwith(work_with_name: work_with_name);
            setRoute(root_name: root_name);
            setArea(area_name: area_name);
            
            setUITitles();
        
        
        }catch {
            print("MYAPP", "objects are: \(error)")
            customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
            
            objBroadcastErrorMail.requestAuthorization()
        }
        progressHUD.dismiss()
    
    }
    
    func parser_submit_for_working(dataFromAPI : [String : NSArray]) {
        
        do {
            if(!dataFromAPI.isEmpty){
                let jsonArray =   dataFromAPI["Tables0"]!
                for i in 0 ..< jsonArray.count{
                    let c = jsonArray[i] as! [String : AnyObject]
                      Custom_Variables_And_Method.DCR_ID = try c.getString(key: "DCRID") as! String;
                    try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DIVERTLOCKYN", value: c.getString(key: "DIVERTLOCKYN") as! String );
                    
                    try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "FCMHITCALLYN", value: c.getString(key: "FCMHITCALLYN") as! String );
                    if c["FCMHITCALLYN"] as! String  != "" && c["FCMHITCALLYN"] as! String != "N" {
                         customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "MOBILEDATAYN", value: "Y");
                       
                    }
                    
                    if (Custom_Variables_And_Method.DCR_ID == "0" ){
                        
                         progressHUD.dismiss()
                        
                        Custom_Variables_And_Method.DCR_ID = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCR_ID", defaultValue: "0")
                        try Alert(title: "Alert !!!",msg: c.getString(key: "MSG") as! String);
                    }else if try ( c.getString(key: "DIVERTLOCKYN") as! String == "Y"){
                        
                         progressHUD.dismiss()
                         try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "DCR_ID", value: c.getString(key: "DCRID") as! String);
                         try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DcrPlanTime_server", value: c.getString(key: "IN_TIME") as! String );
                        try Alert(title: "Alert !!!",msg: c.getString(key: "MSG") as! String);
                       
                    }else{
                        
                        try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "DCR_ID", value: c.getString(key: "DCRID") as! String);
                        try customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DcrPlanTime_server", value: c.getString(key: "IN_TIME") as! String );
                        DownloadAll();
                    }
                }
            }
        } catch {
            print("MYAPP", "objects are: \(error)")
            customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
            
            objBroadcastErrorMail.requestAuthorization()
        }
        //progressHUD.dismiss()
    }
    //Log.d("MYAPP", "objects are1: " + result);
    
    
    
    
    func Alert(title : String , msg : String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel , handler:  { (alert: UIAlertAction!) in
            self.DownloadAll();
        })
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

func DownloadAll(){
   if (Custom_Variables_And_Method.DCR_ID != "0") {

    
    
        cbohelp.deletedcrFromSqlite();
        cbohelp.deleteUtils();
        cbohelp.deleteDCRDetails();
    
        cbohelp.insertUtils(area: Custom_Variables_And_Method.pub_area);
    
        cbohelp.insertDcrDetails(dcrid: Custom_Variables_And_Method.DCR_ID, pubarea: Custom_Variables_And_Method.pub_area);
    
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "dcr_date_real", defaultValue: "") == ""){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "OveAllKm", value: "0.0");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DayPlanLatLong", value: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "shareLatLong", defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON));
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DcrPlantimestamp", value: customVariablesAndMethod.get_currentTimeStamp());
        }

        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "working_head", value: work_val);
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "working_code", value: work_type_code);

        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "BackDateReason", value: late_remark.getText())
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "sDivert_Remark", value: rootLayout.getDivertRemark())


        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "dcr_date_real", value: real_date);
        cbohelp.putDcrId(dcrid: Custom_Variables_And_Method.DCR_ID);
        Custom_Variables_And_Method.GCMToken = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "GCMToken", defaultValue: "");

        //Start of call to service

        var params = [String:String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPA_ID"] = String(Custom_Variables_And_Method.PA_ID)
        params["sDcrId"] = Custom_Variables_And_Method.DCR_ID
        params["sRouteYn"] = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "root_needed",defaultValue: "Y")
        params["sGCM_TOKEN"] = Custom_Variables_And_Method.GCMToken
    
        params["sMobileId"] = customVariablesAndMethod.getDeviceInfo()
        params["sVersion"] = Custom_Variables_And_Method.VERSION

        var tables =  [Int]()
        tables.append(0)
        tables.append(1);
        tables.append(2);
        tables.append(3);
        tables.append(4);
        tables.append(5);
        tables.append(6);
        tables.append(7);
        tables.append(8);
        tables.append(9);
        tables.append(10);
        tables.append(11);
        tables.append(12);
    
        progressHUD.dismiss()
        progressHUD.show(text: "Please Wait..\nFetching your Utilitis for the day")
    
    
        CboServices().customMethodForAllServices(params: params, methodName: "DCRCOMMIT_DOWNLOADALL", tables: tables, response_code: MESSAGE_INTERNET_DCRCOMMIT_DOWNLOADALL, vc : self )

        //End of call to service


        if (fmcg_Live_Km == "5" || fmcg_Live_Km == "Y5") {
            var lat = "" , lon = "" , time = "", km = "0.0";
            customVariablesAndMethod.deleteFmcg_ByKey(vc: context,key: "myKm1");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "Tracking", value: "Y");
            lat = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLat",defaultValue: "0.0");
            lon = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLon",defaultValue: "0.0");
            time = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareMyTime", defaultValue: customVariablesAndMethod.currentTime(context: self));
            km = "0.0";
            //customMethod.insertDataInOnces_Minute(lat, lon, km, time);

            //new Thread(r1).start();
            //new Thread(r2).start();
        }

        if(VCIntent["plan_type"] == "p") {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "Final_submit",value: "N");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "ACTUALFAREYN",value: "");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "ACTUALFARE",value: "");
            cbohelp.deleteAllRecord10();
            cbohelp.delete_DCR_Item(ID: nil,item_id: nil,ItemType: nil,Category: nil);
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "Dcr_Planed_Date", value: customVariablesAndMethod.currentDate());
        }
    //Custom_Variables_And_Method.closeCurrentPage(vc: self)
   }
}
    
    
    
    func parser_DCRCOMMIT_DOWNLOADALL(dataFromAPI : [String : NSArray]) {
    
    do {
    if(!dataFromAPI.isEmpty){
        let jsonArray =   dataFromAPI["Tables0"]!
        let one = jsonArray[0] as! [String : AnyObject]
        let MyDaType = try one.getString(key: "DA_TYPE") ;
        var da_val = "0";
        let rate = try Float(one.getString(key: "FARE_RATE") );
        let kms = try Float(one.getString(key: "KM") );
    
        if (MyDaType == "L") {
            da_val = try one.getString(key: "DA_L_RATE") ;
        } else if (MyDaType == "EX" || MyDaType == "EXS") {
            da_val = try one.getString(key: "DA_EX_RATE") ;
        } else if (MyDaType == "NSD" || MyDaType == "NS") {
            da_val = try one.getString(key: "DA_NS_RATE") ;
        }
        
        var  distance_val = "0";
        if (MyDaType == "EX" || MyDaType == "NSD") {
            distance_val = String(kms! * rate! * 2)
        
        } else {
            distance_val = String(kms! * rate!);
        }
    
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "DA_TYPE",value: MyDaType);
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "da_val",value: da_val);
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "distance_val",value: distance_val);
    
        let table1 = try dataFromAPI.getValue(key: "Tables1");
           cbohelp.delete_phdoctor(DoNotDeleteCalledDrs: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_MULTIPLE_ROUTEYN", defaultValue: "N").uppercased() == ("Y"));
          for i in 0 ..< table1.count{
            let c = table1[i] as! [String : AnyObject]
                
            try cbohelp.insert_phdoctor(dr_id: Int(c.getString(key: "DR_ID") )!, dr_name: c.getString(key: "DR_NAME") , dr_code: "", area: "",spl_id: Int(c.getString(key: "SPL_ID") )!,LAST_VISIT_DATE: c.getString(key: "LASTCALL") ,
                                        CLASS: c.getString(key: "CLASS") , PANE_TYPE: c.getString(key: "PANE_TYPE") ,POTENCY_AMT: c.getString(key: "POTENCY_AMT") ,
                                        ITEM_NAME: c.getString(key: "ITEM_NAME") , ITEM_POB: c.getString(key: "ITEM_POB") , ITEM_SALE: c.getString(key: "ITEM_SALE") ,DR_AREA: c.getString(key: "AREA") ,DR_LAT_LONG: c.getString(key: "DR_LAT_LONG")
                , FREQ: c.getString(key: "FREQ") ,NO_VISITED: c.getString(key: "NO_VISITED") , DR_LAT_LONG2: c.getString(key: "DR_LAT_LONG2") ,DR_LAT_LONG3: c.getString(key: "DR_LAT_LONG3") ,COLORYN: c.getString(key: "COLORYN") , CRM_COUNT: c.getString(key: "CRM_COUNT") , DRCAPM_GROUP: c.getString(key: "DRCAPM_GROUP") , SHOWYN: c.getString(key: "SHOWYN"),MAX_REG: Int(c.getString(key:"MAX_REG"))!,RXGENYN: c.getString(key: "RXGENYN"), APP_PENDING_YN: c.getString(key: "APP_PENDING_YN"));
            
        }
        
        let Tables2 = try dataFromAPI.getValue(key: "Tables2");
        cbohelp.deleteChemist();
        for i in 0 ..< Tables2.count{
            let c = Tables2[i] as! [String : AnyObject]
            try cbohelp.insert_Chemist(chid: Int(c.getString(key: "CHEM_ID") )!, chname: c.getString(key: "CHEM_NAME") , area: "", chem_code: "",LAST_VISIT_DATE: c.getString(key: "LAST_VISIT_DATE") ,DR_LAT_LONG: c.getString(key: "DR_LAT_LONG") , DR_LAT_LONG2: c.getString(key: "DR_LAT_LONG2") ,DR_LAT_LONG3: c.getString(key: "DR_LAT_LONG3") , SHOWYN: c.getString(key: "SHOWYN") );
            
        }
    

//
        let Tables3 = try dataFromAPI.getValue(key: "Tables3");
        cbohelp.deleteDcrAppraisal();
        for i in 0 ..< Tables3.count{
        let c = Tables3[i] as! [String : AnyObject]
            try cbohelp.setDcrAppraisal(PA_ID: c.getString(key: "PA_ID") , PA_NAME: c.getString(key: "PA_NAME") ,DR_CALL: c.getString(key: "DR_CALL") , DR_AVG: c.getString(key: "DR_AVG") ,CHEM_CALL: c.getString(key: "CHEM_CALL") , CHEM_AVG: c.getString(key: "CHEM_AVG") , FLAG: "0", sAPPRAISAL_ID_STR: "", sAPPRAISAL_NAME_STR: "", sGRADE_STR: "", sGRADE_NAME_STR: "", sOBSERVATION: "",sACTION_TAKEN: "");
        }
//
        let Tables4 = try dataFromAPI.getValue(key: "Tables4");
        cbohelp.delete_phdoctoritem();
        for i in 0 ..< Tables4.count{
            let c = Tables4[i] as! [String : AnyObject]
            try cbohelp.insertDoctorData(dr_id: Int(c.getString(key: "DR_ID") )!, item_id: Int(c.getString(key: "ITEM_ID") )!,item_name: c.getString(key: "ITEM_NAME") )
            
            
        }
       
//
       let Tables5 = try dataFromAPI.getValue(key: "Tables5");
        cbohelp.delete_Doctor_Call_Remark();
        for i in 0 ..< Tables5.count{
            let c = Tables5[i] as! [String : AnyObject]
            try cbohelp.insertDoctorCallRemark( item_id: c.getString(key: "PA_ID") ,item_name: c.getString(key: "PA_NAME") ,type: "R");
        }
//
//
        let Tables6 = try dataFromAPI.getValue(key: "Tables6");
        cbohelp.delete_phparty();
        for i in 0 ..< Tables6.count{
            let c = Tables6[i] as! [String : AnyObject]
           
            try cbohelp.insert_phparty(pa_id: c.getString(key: "PA_ID") , pa_name: c.getString(key: "PA_NAME") , desig_id: c.getString(key: "DESIG_ID") , category: c.getString(key: "CATEGORY") , hqid: c.getString(key: "HQ_ID") , PA_LAT_LONG: c.getString(key: "PA_LAT_LONG") , PA_LAT_LONG2: c.getString(key: "PA_LAT_LONG2") , PA_LAT_LONG3: c.getString(key: "PA_LAT_LONG3") , SHOWYN: c.getString(key: "SHOWYN") );
        }
        
        
        let Tables7 = try dataFromAPI.getValue(key: "Tables7");
        cbohelp.delete_phdairy();
        for i in 0 ..< Tables7.count{
            let c = Tables7[i] as! [String : AnyObject]
            
            try cbohelp.insert_phdairy(DAIRY_ID: Int(c.getString(key: "ID") )!, DAIRY_NAME: c.getString(key: "DAIRY_NAME")  , DOC_TYPE: c.getString(key: "DOC_TYPE") , LAST_VISIT_DATE: "", DR_LAT_LONG: c.getString(key: "DAIRY_LAT_LONG") , DR_LAT_LONG2: c.getString(key: "DAIRY_LAT_LONG2") , DR_LAT_LONG3: c.getString(key: "DAIRY_LAT_LONG3") )
        }
        
        
        let Tables8 = try dataFromAPI.getValue(key: "Tables8");
        cbohelp.delete_phdairy_person();
        for i in 0 ..< Tables8.count{
            let c = Tables8[i] as! [String : AnyObject]
            
            try cbohelp.insert_phdairy_person(DAIRY_ID:Int(c.getString(key: "DAIRY_ID") )! , PERSON_ID: Int(c.getString(key: "PERSON_ID") )!, PERSON_NAME: c.getString(key: "PERSON_NAME") )
        }
        
        
        let Tables9 = try dataFromAPI.getValue(key: "Tables9");
        cbohelp.delete_phdairy_reason();
        for i in 0 ..< Tables9.count{
            let c = Tables9[i] as! [String : AnyObject]
            
            try cbohelp.insert_phdairy_reason(PA_ID: Int(c.getString(key: "PA_ID") )! , PA_NAME: c.getString(key: "PA_NAME") )
        }
        
        let table10 =  try dataFromAPI.getValue(key : "Tables10");
        
        cbohelp.delete_Item_Stock();
        for i in 0 ..< table10.count{
            let c = table10[i] as! [String : AnyObject]
            try cbohelp.insert_Item_Stock( ITEM_ID: c.getString(key: "ITEM_ID") , STOCK_QTY: Int(c.getString(key: "STOCK_QTY"))!);
        }
        
        let Tables11 = try dataFromAPI.getValue(key: "Tables11");
        cbohelp.delete_STk_Item();
        for i in 0 ..< Tables11.count{
            let c = Tables11[i] as! [String : AnyObject]
            try cbohelp.insert_STk_Item( STK_ID: c.getString(key: "STK_ID"),ITEM_ID: c.getString(key: "ITEM_ID"),RATE: c.getString(key: "RATE"));
        }
        
        let Tables12 = try dataFromAPI.getValue(key: "Tables12");
        for i in 0 ..< Tables12.count{
            let c = Tables12[i] as! [String : AnyObject]
            try cbohelp.insertDoctorCallRemark( item_id: c.getString(key: "PA_ID") ,item_name: c.getString(key: "PA_NAME"),type: "S" );
        }
    
        switch (work_type_Selected){
            
            case "w":
            
                    /*if (Custom_Variables_And_Method.getInstance().isVisualAddDownloadRequired(context: self)) {
                                                              
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "VisualAidDownload") as! VisualAidDownload
                                                                      
                        visualAidDownloadVC.VCIntent["title"] = "VisualAd Download"
                        visualAidDownloadVC.VCIntent["V_DOWNLOAD"] = "Y"
                                                                      
                        self.present(visualAidDownloadVC, animated: true, completion: nil)
                        
                    } else {*/
                        myTopView.CloseCurruntVC(vc: context)
                    //}
             
            break;
            
            case "l":
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "FinalSubmit") as!
                FinalSubmit
                vc.VCIntent["title"] = "Final Submit"
                vc.VCIntent["Back_allowed"] = "N"
                self.present(vc, animated: true, completion: nil)
            break;
            
            case "n":
                setReultForNonWork();
            break;
            
        default:
            print(work_type_Selected)
        }
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "work_type_Selected",value: work_type_Selected);
    
        //Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    }catch {
        print("MYAPP", "objects are: \(error)")
        customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
        
        
        
        let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
        
        let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
        
        objBroadcastErrorMail.requestAuthorization()
    }
    }
    //Log.d("MYAPP", "objects are1: " + result);
}

