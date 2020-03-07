//
//  StockistCall.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation
class StockistCall: CustomUIViewController,CheckBoxDelegate {
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! Int
    
        switch tag {
        case 0:
            let table="phdcrstk";
            if (cbohelp.getmenu_count(table: table)>0 && ischecked){
                //visited.setVisibility(View.GONE);
                customVariablesAndMethod.msgBox(vc: context,msg: "Stockist already in the call-List");
                sender.setChecked(checked: false);
            }else if (sender.isChecked()) {
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "STOCKIST_NOT_VISITED",value: "Y");
                // MyConnection.STOCKIST_NOT_VISITED = "Y";
                myTopView.CloseCurruntVC(vc: context)
            }
            break
        default:
            print ("no tag assigned")
        }
    }
    
    
    
    var presenter : ParantSummaryAdaptor!
    @IBOutlet weak var stockistSummaryTableView: UITableView!
    
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var callButton: CustomHalfRoundButton!
    
    @IBOutlet weak var slelectedTabBarButtom: UIView!
    
    @IBOutlet weak var summaryStackView: UIStackView!
    
    @IBOutlet weak var stockistCallView: CustomBoarder!
    
    @IBOutlet weak var stockistSummaryview: CustomBoarder!
    
      private var editingIndex = 0
     var header = [String]()

    @IBOutlet weak var loc: CustomDisableTextView!
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var Stk_name: UILabel!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var Stk_btn: UIButton!
    
    @IBOutlet weak var pob_layout: UIStackView!
    @IBOutlet weak var loc_layout: UIStackView!
    
    @IBOutlet weak var visited: CheckBox!
    @IBOutlet weak var visited1: UIStackView!
    @IBOutlet weak var remark: CustomTextView!
    @IBOutlet weak var pob_Amt: CustomDisableTextView!
    @IBOutlet weak var productBtn: CustomeUIButton!
    @IBOutlet weak var add_stk: CustomeUIButton!
    
    @IBOutlet weak var gift_btn: CustomeUIButton!
    
    @IBOutlet weak var summaryViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var giftStackView: UIStackView!
    
    var docList = [SpinnerModel]();
    var showRegistrtion = 1;
    let CALL_DILOG = 5,PRODUCT_DILOG = 6 , SUMMARY_DILOG = 8, GIFT_DILOG = 7 ,
    REPORT_DIALOG = 9, MESSAGE_INTERNET_SEND_FCM = 10,MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11
    
    var selected_dr_id = "-1"
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
   
    var summary_list = [[String : [String : [String]]]]()
    var stockist_list1 = [String : [String]]();
    
    var dcrid = 0;
    var result = 0.0;
    var sample = "0.0";
    var rate = "";
    var time = "";

    
    var sample_name_previous="",sample_pob_previous="",sample_sample_previous="";
    var gift_name_previous="",gift_qty_previous="";
    
    var gift_name="",gift_qty="";
    var name = "",resultList="";
    var chname = "", stk_id = "", stkst_name = "";
    var chm_ok = "", stk_ok = "", exp_ok = "";
    var name2 = "", name3 = "" , name4 = ""
    var stockist_list = [String : [String]]()
    var sample_name="",sample_pob="",sample_sample="";
    var dr_id_reg = "",dr_id_index = "",dr_name_reg="";
    var context : CustomUIViewController!
    var Hide_status=""
    var  progressHUD : ProgressHUD!
    var multiCallService = Multi_Class_Service_call()
    
    var ref_latLong = "";
    var call_latLong = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockistCallView.isHidden = false
        stockistSummaryview.isHidden = true
        
        
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        
        callButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        summaryButton.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
        
        
        context = self
        progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
        }
        pob_Amt.setText(text: "\(result)")
        Hide_status = "Y"
        pob_Amt.setHint(placeholder: "POB Amt.")
        remark.setHint(placeholder: "Enter Remark")
        
       let working_code = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code",defaultValue: "W")
        if ( working_code == "OSC"  || (working_code.contains("NR") && !working_code.contains("S"))) {
            visited1.isHidden = true
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "SAMPLE_POB_MANDATORY",defaultValue: "N") == "N") {
            pob_layout.isHidden = false
            Custom_Variables_And_Method.SAMPLE_POB_MANDATORY="N";
        } else {
            pob_layout.isHidden = true
            Custom_Variables_And_Method.SAMPLE_POB_MANDATORY="Y";
        }
        setAddressToUI();
        setAddressToUI();
        
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        }else{
             loc_layout.isHidden = true
        }
        
        visited.delegate = self
        visited.setTag(tag: 0)
        
        let ProductCaption = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "SAMPLE_BTN_CAPTION", defaultValue: "")
        if (!ProductCaption.isEmpty){
            productBtn.setText( text: ProductCaption)
        }
         productBtn.addTarget(self, action: #selector(OnProductLoad), for: .touchUpInside )
        
        let GiftCaption = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "GIFT_BTN_CAPTION", defaultValue: "")
        if (!GiftCaption.isEmpty){
            gift_btn.setText( text: GiftCaption)
        }
        gift_btn.addTarget(self, action: #selector(OnGiftLoad), for: .touchUpInside)
       
        
        Stk_btn.addTarget(self, action: #selector(OnClickStkLoad), for: .touchUpInside )
        
        add_stk.addTarget(self, action: #selector(OnClickStkSubmit), for: .touchUpInside )
        
       

        
        
        summaryBackButton.isHidden = true
//        if VCIntent["openSummary"] != nil{
//            if VCIntent["openSummary"] == "Y"{
//                pressedSummaryButton()
//                summaryBackButton.isHidden = false
//                summaryViewHeight.constant = 0
//                summaryStackView.isHidden = true
//                summaryBackButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside)
//                stockistSummaryview.layer.borderColor = UIColor.white.cgColor
//            }
//        }else{
            genrateSummary()
            presenter.delegate = self
//        }
    }
    
   
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    
    //MARK:- callButton
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedSummaryButton(){
        callButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        stockistCallView.isHidden  = true
        stockistSummaryview.isHidden = false
    }
    
    
    

    
    
    
    func genrateSummary(){
        var headers = [ String]()
        var isCollaps = [Bool]()
        stockist_list1 = cbohelp.getCallDetail(table: "phdcrstk",look_for_id: "",show_edit_delete: "1")
        do {
            summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_STK_CALL").getString(key: "D_STK_CALL") :    stockist_list1])
        }catch{
            print(error)
        }
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        myTopView.setText(title: headers[0])
        presenter = ParantSummaryAdaptor(tableView: stockistSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        
        stockistSummaryTableView.dataSource = presenter
        stockistSummaryTableView.delegate = presenter
    }
    
    
    
    
    @objc func pressedBack(){
        myTopView.CloseCurruntVC(vc: self)
    }
    
    @objc func OnClickStkSubmit(){
        // if (Custom_Variables_And_Method.GLOBAL_LATLON.equalsIgnoreCase("0.0,0.0")) {
        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        // }
        
        
        let getCurrentTime = customVariablesAndMethod.get_currentTimeStamp();
        let planTime = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DcrPlantimestamp",defaultValue: customVariablesAndMethod.get_currentTimeStamp());
        let t1 = Float(getCurrentTime);
        let t2 = Float(planTime);
        
        let t3 = t1! - t2!;
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "REMARK_WW_MANDATORY",defaultValue: "").contains("S") &&  remark.getText() == "") {
            customVariablesAndMethod.getAlert(vc: self, title: "Alert !!!", msg: "Please enter remark");
            
            
        }else if ((t3 >= 0) || (t3 >= -0.9)) {
            
            do {
                setAddressToUI();
                submitStockist();
            } catch{
                print(error)
            }
            
            
        } else {
            customVariablesAndMethod.getAlert(vc: self, title: "Alert", msg: "Your Plan Time can not be \n Higher Than Current time...");
        }
        
        //myTopView.CloseCurruntVC(vc: self)
    }
    
    @objc func OnClickStkLoad(){
        do{
            let statement = try cbohelp.getStockistListLocal();
            // chemist.add(new SpinnerModel("--Select--",""));
            let db = cbohelp
            docList.removeAll()
            while let c = statement.next() {
                docList.append(
                    
                    try SpinnerModel(name: c[db.getColumnIndex(statement: statement, Coloumn_Name: "pa_name")]! as! String,
                                     id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "pa_id")]!)",
                        last_visited: "",
                        DR_LAT_LONG: c[db.getColumnIndex(statement: statement, Coloumn_Name: "PA_LAT_LONG")]! as! String,
                        DR_LAT_LONG2: c[db.getColumnIndex(statement: statement, Coloumn_Name: "PA_LAT_LONG2")]! as! String,
                        DR_LAT_LONG3: c[db.getColumnIndex(statement: statement, Coloumn_Name: "PA_LAT_LONG3")]! as! String,
                        CALLYN: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "CALLYN")]!)"
                    )
                );
                
            }
            
            if(docList.count>0){
            
                Call_Dialog(vc: self, title: "Select Stokist...", dr_List: docList, callTyp: "S", responseCode: CALL_DILOG).show()
                //docList = new ArrayList<SpinnerModel>();
                //GPS_Timmer_Dialog(context,mHandler,"Scanning Doctors...",GPS_TIMMER).show();
            }else{
                customVariablesAndMethod.getAlert(vc: self, title: "No Stockist !!!", msg: "No Stockist in Planed DCR.....");
            }
        }catch {
            print(error)
        }
    }
    
    @objc func OnProductLoad(){
        let stkName = Stk_name.text
        if (stkName == "--Select--") {
            customVariablesAndMethod.getAlert(vc: self, title: "Select !!!", msg: "Please Select Stockist Name First..");
        } else {
            stk_sample_Dialog(vc: self, responseCode: PRODUCT_DILOG, sample_name: sample_name, sample_pob: sample_pob, sample_sample: sample_sample).setPrevious(sample_name_previous: sample_name_previous, sample_pob_previous: sample_pob_previous, sample_sample_previous: sample_sample_previous).show()
        }
  
    }
    
    
    @objc func OnGiftLoad(){
        let stkName = Stk_name.text
        if (stkName == "--Select--") {

            customVariablesAndMethod.msgBox(vc: context,msg: "Please Stockist  First..");
        } else {
            Gift_Dialog(vc: self, responseCode: GIFT_DILOG, gift_name: gift_name, gift_qty: gift_qty, gift_typ: "chem", gift_name_previous: gift_name_previous, gift_qty_previous: gift_qty_previous).show()
        }
    }
   
    
    
    func submitStockist() {
    
        customVariablesAndMethod.getBatteryLevel()
        let currentBatteryLevel = Custom_Variables_And_Method.BATTERYLEVEL
         var locExtra = "";
        if (loc.text == "") {
            loc.text = "UnKnown Location"
        }
        let address = loc.text
        var AllGiftId = "";
        
        var AllGiftQty = "";
        
        var PobAtm = pob_Amt.getText()
        var PobAtm1 = PobAtm;
        var name1 = name;
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "SAMPLE_POB_INPUT_MANDATORY",defaultValue: "").contains("S") ) {
            PobAtm1="-";
            name1="-";
        }
    
        var AllItemId = "";
        var AllItemQty = "";
        
  
        let stkName = Stk_name.text!
       
        
        if (docList.isEmpty && stk_id == "") {
             customVariablesAndMethod.msgBox(vc: context,msg: "No Stockist in List....");
        } else if (stkName == "--Select--") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Stockist from List....");
            
        } else if (Custom_Variables_And_Method.getInstance().isCheckForProduct(s: "S", context: self)){
        
                    if (!(PobAtm1 == "" || PobAtm1 == "0") && (sample_name == "")) {
                        //if (sample_name.equals("")) {
                        customVariablesAndMethod.msgBox(vc: context, msg: "Please select Atleast 1 product first");
                       
                    } else {
                        //for (int i = 0; i < 1; i++) {
                        AllItemId = AllItemId + name;
                        AllItemQty = AllItemQty + name2;
                        
                        if (name3 == "") {
                            AllGiftId = AllGiftId + "0";
                            AllGiftQty = AllGiftQty + "0";
                        } else {
                            
                            for i in 0 ..< 1{
                                AllGiftId = AllGiftId + name3;
                                AllGiftQty = AllGiftQty + name4;
                            }
                        }
                        // }
                            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
                        let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
                        
                        
                        if (currentBestLocation != CLLocation()) {
                            locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
                        }
                    
                
                    if (cbohelp.searchStockist(skt_id: stk_id).contains(stk_id)) {
                        cbohelp.updateStockistInLocal(dcrid: dcrid, stkid: stk_id, pobamt: PobAtm, allitemid: AllItemId, allitemqty: AllItemQty, address: Custom_Variables_And_Method.GLOBAL_LATLON + "!^" + address, time: customVariablesAndMethod.currentTime(context: context),sample: sample,remark: remark.getText(),file: "", allgiftid: AllGiftId, allgiftqty: AllGiftQty, rate: rate);
                
                        print("stockist updated");
                        
                        //finish();
                       
                        customVariablesAndMethod.msgBox(vc: context,msg: "\(stkst_name) successfully updated", completion: {_ in
                            self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "S",Id: self.stk_id,latlong: "")})
                        
            //        Intent intent = new Intent(getApplicationContext(), LoginFake.class);
            //        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
            //        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
            //        intent.putExtra("EXIT", true);
            //        startActivity(intent);
            //        finish();
                        
                    } else {
                        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
                        
                        
                        cbohelp.submitStockitInLocal(dcrid: dcrid, stkid: stk_id, pobamt: PobAtm, allitemid: AllItemId, allitemqty: AllItemQty, address: Custom_Variables_And_Method.GLOBAL_LATLON + "!^" + address, time: customVariablesAndMethod.currentTime(context: context), battery_level: currentBatteryLevel,latLong: call_latLong,updated: "0",stk_km: "0",srno: customVariablesAndMethod.srno(context: context),sample: sample,remark: remark.getText(),file: "",LOC_EXTRA: locExtra , allgiftid: AllGiftId, allgiftqty: AllGiftQty,Ref_latlong: ref_latLong, rate: rate);
                
                        cbohelp.addStockistInLocal(stkid: stk_id, stkname: stkst_name);
                        
                        print("stockist ADDED");
                
                
                        chm_ok = getmydata()[0];
                        stk_ok = getmydata()[1];
                        exp_ok = getmydata()[2];
                        
                        
                        if (stk_ok == "") {
                            cbohelp.insertfinalTest(chemist: chm_ok, stockist: stk_id, exp: exp_ok);
                        } else {
                            cbohelp.updatefinalTest(chemist: chm_ok, stockist: stk_id, exp: exp_ok);
                        }
                        
                        pob_Amt.setText(text: "");
                        Custom_Variables_And_Method.STOCKIST_NOT_VISITED = "Y";
                        
                        //finish();
                        
                        customVariablesAndMethod.msgBox(vc: context,msg: "\(stkst_name) Added Successfully", completion: {_ in
                            self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "S",Id: self.stk_id,latlong: "")})

                        }
                    }
        
        } else {
            //for (int i = 0; i < 1; i++) {
            AllItemId = AllItemId + name;
            AllItemQty = AllItemQty + name2;
            
            if (name3 == "") {
                AllGiftId = AllGiftId + "0";
                AllGiftQty = AllGiftQty + "0";
            } else {
                
                for i in 0 ..< 1{
                    AllGiftId = AllGiftId + name3;
                    AllGiftQty = AllGiftQty + name4;
                }
            }
            // }
                Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
            let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
            
            
            if (currentBestLocation != CLLocation()) {
                locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
            }
        
    
        if (cbohelp.searchStockist(skt_id: stk_id).contains(stk_id)) {
            cbohelp.updateStockistInLocal(dcrid: dcrid, stkid: stk_id, pobamt: PobAtm, allitemid: AllItemId, allitemqty: AllItemQty, address: Custom_Variables_And_Method.GLOBAL_LATLON + "!^" + address, time: customVariablesAndMethod.currentTime(context: context),sample: sample,remark: remark.getText(),file: "", allgiftid: AllGiftId, allgiftqty: AllGiftQty, rate: rate);
    
            print("stockist updated");
            
            //finish();
           
            customVariablesAndMethod.msgBox(vc: context,msg: "\(stkst_name) successfully updated", completion: {_ in
                self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "S",Id: self.stk_id,latlong: "")})
            
//        Intent intent = new Intent(getApplicationContext(), LoginFake.class);
//        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
//        intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
//        intent.putExtra("EXIT", true);
//        startActivity(intent);
//        finish();
            
        } else {
            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
            
            
            cbohelp.submitStockitInLocal(dcrid: dcrid, stkid: stk_id, pobamt: PobAtm, allitemid: AllItemId, allitemqty: AllItemQty, address: Custom_Variables_And_Method.GLOBAL_LATLON + "!^" + address, time: customVariablesAndMethod.currentTime(context: context), battery_level: currentBatteryLevel,latLong: call_latLong,updated: "0",stk_km: "0",srno: customVariablesAndMethod.srno(context: context),sample: sample,remark: remark.getText(),file: "",LOC_EXTRA: locExtra , allgiftid: AllGiftId, allgiftqty: AllGiftQty,Ref_latlong: ref_latLong, rate: rate);
    
            cbohelp.addStockistInLocal(stkid: stk_id, stkname: stkst_name);
            
            print("stockist ADDED");
    
    
            chm_ok = getmydata()[0];
            stk_ok = getmydata()[1];
            exp_ok = getmydata()[2];
            
            
            if (stk_ok == "") {
                cbohelp.insertfinalTest(chemist: chm_ok, stockist: stk_id, exp: exp_ok);
            } else {
                cbohelp.updatefinalTest(chemist: chm_ok, stockist: stk_id, exp: exp_ok);
            }
            
            pob_Amt.setText(text: "");
            Custom_Variables_And_Method.STOCKIST_NOT_VISITED = "Y";
            
            //finish();
            
            customVariablesAndMethod.msgBox(vc: context,msg: "\(stkst_name) Added Successfully", completion: {_ in
                self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "S",Id: self.stk_id,latlong: "")})

            }
        }
    }

    func getmydata() -> [String] {
        var raw = [String]();
        var chm = ""
        var stk = ""
        var exp = ""
        do {
            var statement :Statement = try cbohelp.getFinalSubmit();
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

    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
            
     
        case CALL_DILOG:
          
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            
            stk_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            stkst_name = docList[Int(inderData["Selected_Index"]!)!].getName()
            Stk_name.text = stkst_name
            ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
            call_latLong = inderData["latLong"]!
            displayData()
            break
            
        case GIFT_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            name3  = inderData["val"]!   //id
            name4 = inderData["val2"]!   //qty pob
            resultList = inderData["resultList"]!

            gift_name=resultList;
            gift_qty=name4;
            
            let gift_name1 = resultList.components(separatedBy: ",");
            let gift_qty1 = gift_qty.components(separatedBy: ",");
            ShowDrSampleGift(gift_name: gift_name1, gift_qty: gift_qty1);
            
            break
            
        case PRODUCT_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            name = inderData["val"]!   //id
            name2 = inderData["val2"]!   //qty pob
            result = Double(inderData["resultpob"]!)! //pob value
            sample = inderData["sampleQty"]!
            resultList = inderData["resultList"]!

            rate = inderData["resultRate"]!
            
            pob_Amt.setText(text: inderData["resultpob"]!)
            sample_name=resultList;
            sample_sample=sample;
            sample_pob=name2;
            
            let sample_name1 = resultList.components(separatedBy: ",");
            let sample_qty1 = sample.components(separatedBy: ",");
            let sample_pob1 = name2.components(separatedBy: ",");
            ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
            break
        
        //MARK:- add report dialog
        case REPORT_DIALOG :
//            parse_Doctor(dataFromAPI: dataFromAPI)
            break
        case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
            progressHUD.dismiss()
            self.cbohelp.delete_Stokist_from_local_all(dr_id: self.selected_dr_id)
            self.pressedBack()
            
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
    

    func parse_Doctor( dataFromAPI : [String : NSArray] ){
        
        var  nameList,timeList,sample_name,sample_qty,sample_pob,sample_noc,remark,gift_name,gift_qty : [String]!
        var headers = [String]()
        var isCollaps = [Bool]()
        var  visible_status = [String]()
        
        var area_Array = [String]()
        var class_Arrya = [String]()
        var potential_Array = [String]()
        var workwith_array = [String]()
        nameList = [String]()
        timeList = [String]()
        sample_name = [String]()
        sample_qty = [String]()
        sample_pob = [String]();
        sample_noc = [String]();
        remark = [String]()
        var show_edit_delete = [String]()
        gift_name = [String]()
        gift_qty = [String]()
        
        
        let dr_gift_name = "";
        let dr_gift_qty = "";
        let area = ""
        let class1 = ""
        let potential = ""
        if(!dataFromAPI.isEmpty){
            let jsonArray =   dataFromAPI["Tables0"]!
            
            for i in 0 ..< jsonArray.count{
                let innerJson = jsonArray[i] as! [String : AnyObject]
                
            
                nameList.append(innerJson["PA_NAME"] as! String)
                timeList.append(innerJson["IN_TIME"] as! String)
                sample_name.append(innerJson["PRODUCT"] as! String)
                sample_qty.append(innerJson["QTY"] as! String)
                sample_pob.append(innerJson["POB_QTY"] as! String);
                sample_noc.append("0");
                remark.append(innerJson["REMARK"] as! String);
                
                visible_status.append("1");
                
                gift_name.append(dr_gift_name);
                gift_qty.append(dr_gift_qty);
                
                show_edit_delete.append("0")
                workwith_array.append("")
                area_Array.append(area)
                class_Arrya.append(class1)
                potential_Array.append(potential)

            }
        }
        
 
        stockist_list.removeAll()
        
        stockist_list["name"] = nameList
        stockist_list["time"] = timeList
        stockist_list["sample_name"] = sample_name
        stockist_list["sample_qty"] = sample_qty
        stockist_list["sample_pob"] = sample_pob
        stockist_list["sample_noc"] = sample_noc
        stockist_list["visible_status"] = visible_status
        stockist_list["remark"] = remark
        
        stockist_list["gift_name"] = gift_name
        stockist_list["gift_qty"] = gift_qty
        
        stockist_list["area"] = area_Array
        stockist_list["class"] = class_Arrya
        stockist_list["potential"] = potential_Array
        stockist_list["workwith"] = workwith_array
        stockist_list["show_edit_delete"] = show_edit_delete
        
        do {
            summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_STK_CALL").getString(key: "D_STK_CALL") :    stockist_list])
        }catch{
            print(error)
        }
        print(stockist_list)
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        
        myTopView.setText(title: headers[0])
        
        presenter = ParantSummaryAdaptor(tableView: stockistSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        
        stockistSummaryTableView.reloadData()
        stockistSummaryTableView.dataSource = presenter
        stockistSummaryTableView.delegate = presenter
    
    }
    
    
    func ShowDrSampleGift( gift_name : [String],  gift_qty : [String]){
        let myStackView = giftStackView
        RemoveAllviewsinGift()
        
        var heightConstraint : NSLayoutConstraint!
        // var stackViewHeightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!
        
        var previousStackView : UIStackView!
        
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myStackView?.addSubview(myLabel)
        myLabel.text =  "Gift"
        myLabel.numberOfLines = 0
        myLabel.font = myLabel.font.withSize(13)
        myLabel.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel.textColor = .white
        
        
        let myLabel2 = UILabel()
        myStackView?.addSubview(myLabel2)
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        myLabel2.numberOfLines = 0
        myLabel2.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel2.font = myLabel2.font.withSize(13)
        myLabel2.textAlignment = .center
        myLabel2.textColor = .white
        myLabel2.text =  "Qty."
        
        
        
        let myinnerStackView = UIStackView()
        myinnerStackView.axis =  .horizontal
        myStackView?.addSubview(myinnerStackView)
        myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
        
        
        myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel2.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor ).isActive =  true
        myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
        
        myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
        myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
        myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true

        
        //if i == 0{
        
        myinnerStackView.topAnchor.constraint(equalTo: (myStackView?.topAnchor)!).isActive = true
        myinnerStackView.leftAnchor.constraint(equalTo: (myStackView?.leftAnchor)!).isActive = true
        myinnerStackView .rightAnchor.constraint(equalTo: (myStackView?.rightAnchor)!).isActive =  true
        
        //        }else{
        //
        //            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
        //            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
        //            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
        //
        //        }
        
        
        heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true
        
        
        widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
        widthConstraint.isActive =  true
        
        previousStackView = myinnerStackView
        
        for i in 0 ..< gift_name.count{
            
            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myStackView?.addSubview(myLabel)
            myLabel.text =  gift_name[i]
            myLabel.numberOfLines = 0
            myLabel.textColor = AppColorClass.colorPrimaryDark
            //myLabel.backgroundColor = .gray
            
            
            let myLabel2 = UILabel()
            myStackView?.addSubview(myLabel2)
            myLabel2.translatesAutoresizingMaskIntoConstraints = false
            myLabel2.numberOfLines = 0
            //myLabel2.backgroundColor = .lightGray
            myLabel2.textAlignment = .center
            myLabel2.textColor = AppColorClass.colorPrimaryDark
            myLabel2.text =  gift_qty[i]
            
            
            
            let myinnerStackView = UIStackView()
            myinnerStackView.axis =  .horizontal
            myStackView?.addSubview(myinnerStackView)
            myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
            
            
            myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel2.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor ).isActive =  true
            myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
            
            myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
            myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
            myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
            
            
            
            //            if i == 0{
            //
            //                myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
            //                myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            //                myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
            //
            //            }else{
            
            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
            myinnerStackView.leftAnchor.constraint(equalTo: (myStackView?.leftAnchor)!).isActive = true
            myinnerStackView .rightAnchor.constraint(equalTo: (myStackView?.rightAnchor)!).isActive =  true

            heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true

            widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true

            previousStackView = myinnerStackView

        }

        previousStackView.bottomAnchor.constraint(equalTo: (myStackView?.bottomAnchor)!).isActive =  true

    }
    
    func displayData(){
        stockist_list=cbohelp.getCallDetail(table: "phdcrstk",look_for_id: stk_id,show_edit_delete: "0");
        if (stockist_list["sample_name"]![0] != "") {
            
            sample_name = stockist_list["sample_name"]![0]
            sample_sample = stockist_list["sample_qty"]![0]
            sample_pob = stockist_list["sample_pob"]![0]
            
            let sample_name1 = sample_name.components(separatedBy: ",");
            let sample_qty1 = sample_sample.components(separatedBy: ",");
            let sample_pob1 = sample_pob.components(separatedBy: ",");
            
            ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
            add_stk.setText(text: "Update Stockist");
        }else{
            
            sample_name="";
            sample_pob="";
            sample_sample="";
            
            RemoveAllviewsinProduct()
            
            add_stk.setText(text: "Add Stockist");
        }
        
        if (stockist_list["gift_name"]![0] != "") {

            gift_name = stockist_list["gift_name"]![0]
            gift_qty = stockist_list["gift_qty"]![0]

            name4 = gift_qty
            name3 = stockist_list["gift_id"]![0]

            let gift_name1 = gift_name.components(separatedBy: ",");
            let gift_qty1 = gift_qty.components(separatedBy: ",");
           ShowDrSampleGift(gift_name: gift_name1, gift_qty: gift_qty1);
        }else{
            gift_name = ""
            gift_qty = ""
            RemoveAllviewsinGift()
        }
        
        sample_name_previous=sample_name;
        sample_pob_previous=sample_pob;
        sample_sample_previous=sample_sample;
        
        gift_name_previous = gift_name;
        gift_qty_previous = gift_qty;
    }

    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }

    func RemoveAllviewsinProduct(){
        while( myStackView.subviews.count > 0 ) {
            myStackView.subviews[0].removeFromSuperview()
        }
    }
    
    func RemoveAllviewsinGift(){
        while( giftStackView.subviews.count > 0 ) {
            giftStackView.subviews[0].removeFromSuperview()
        }
    }
    
    func ShowDrSampleProduct( sample_name : [String],  sample_qty : [String], sample_pob : [String]){
        
        RemoveAllviewsinProduct()

        var heightConstraint : NSLayoutConstraint!
        // var stackViewHeightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!
        
        var previousStackView : UIStackView!

        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myStackView.addSubview(myLabel)
        myLabel.text =  "Product"
        myLabel.numberOfLines = 0
        myLabel.font = myLabel.font.withSize(13)
        myLabel.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel.textColor = .white
        
        
        let myLabel2 = UILabel()
        myStackView.addSubview(myLabel2)
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        myLabel2.numberOfLines = 0
        myLabel2.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel2.font = myLabel2.font.withSize(13)
        myLabel2.textAlignment = .center
        myLabel2.textColor = .white
        myLabel2.text =  "Sample"
        
        let myLabel3 = UILabel()
        myStackView.addSubview(myLabel3)
        myLabel3.translatesAutoresizingMaskIntoConstraints = false
        myLabel3.numberOfLines = 0
        myLabel3.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel3.font = myLabel3.font.withSize(13)

        myLabel3.textAlignment = .center
        myLabel3.textColor = .white
        myLabel3.text =  "POB"
        
        let myinnerStackView = UIStackView()
        myinnerStackView.axis =  .horizontal
        myStackView.addSubview(myinnerStackView)
        myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
        

        myLabel3.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel3.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor).isActive =  true
        myLabel3.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
        
        myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel2.rightAnchor.constraint(equalTo: myLabel3.leftAnchor ).isActive =  true
        myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
        
        myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
        myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
        myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
        
        
        
        //if i == 0{
            
            myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
            
//        }else{
//
//            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
//            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
//            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
//
//        }
        
        
        heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true
        
        
        widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
        widthConstraint.isActive =  true
        
        heightConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true
        
        
        widthConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
        widthConstraint.isActive =  true
        
        previousStackView = myinnerStackView
      
        for i in 0 ..< sample_name.count{
            
            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myStackView.addSubview(myLabel)
            myLabel.text =  sample_name[i]
            myLabel.numberOfLines = 0
            myLabel.textColor = AppColorClass.colorPrimaryDark
            //myLabel.backgroundColor = .gray
            
            
            let myLabel2 = UILabel()
            myStackView.addSubview(myLabel2)
            myLabel2.translatesAutoresizingMaskIntoConstraints = false
            myLabel2.numberOfLines = 0
            //myLabel2.backgroundColor = .lightGray
            myLabel2.textAlignment = .center
            myLabel2.textColor = AppColorClass.colorPrimaryDark
            myLabel2.text =  sample_qty[i]
            
            let myLabel3 = UILabel()
            myStackView.addSubview(myLabel3)
            myLabel3.translatesAutoresizingMaskIntoConstraints = false
            myLabel3.numberOfLines = 0
            //myLabel3.backgroundColor = .red
            myLabel3.textAlignment = .center
            myLabel3.textColor = AppColorClass.colorPrimaryDark
            myLabel3.text =  sample_pob[i]
            
            let myinnerStackView = UIStackView()
            myinnerStackView.axis =  .horizontal
            myStackView.addSubview(myinnerStackView)
            myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
            
            
            
            
            myLabel3.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel3.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor).isActive =  true
            myLabel3.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
            
            myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel2.rightAnchor.constraint(equalTo: myLabel3.leftAnchor ).isActive =  true
            myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
            
            myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
            myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
            myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true
            
            
            
//            if i == 0{
//
//                myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
//                myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
//                myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
//
//            }else{
            
                myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
                myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
                myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
             
            //}
            
            
            heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true
            
            
            widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true
            
            heightConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true
            
            
            widthConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true
         
            previousStackView = myinnerStackView
            
        }
        
        
        previousStackView.bottomAnchor.constraint(equalTo: myStackView.bottomAnchor).isActive =  true
    
    }

}



extension StockistCall : ParantSummaryAdaptorDalegate{
    
    
    func onEdit(id: String , name : String) {
        print(id , name)
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
                                var parent : StockistCall!
                                var id: String!
                                var Dr_name: String!
                                func onPositiveClicked(item: UIView?, result: String) {
                                    
                                    //Start of call to service
                                    
                                    var params = [String : String]()
                                    params["sCompanyFolder"] = parent.cbohelp.getCompanyCode()
                                    params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
                                    params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
                                    params["iDR_ID"] = id
                                    params["sTableName"] =  "STOCKIST"
                                    
                                    
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
                                init(parent : StockistCall,id: String,Dr_name : String) {
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
            self.stkst_name = name
            self.stk_id = id
            self.Stk_name.text = self.stkst_name
            self.displayData()
        }
        
        let delete = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.setTabsUI()
            self.stkst_name = name
            self.stk_id = id
            self.Stk_name.text = self.stkst_name
            self.cbohelp.delete_Stokist_from_local_all(dr_id: self.stk_id)
            self.pressedBack()
        }
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel, handler: nil)
        
        
        if title.lowercased() == "delete"{
            msg = "Do you Really want to \(title.lowercased()) \(name) ?"
            
            alertViewController = UIAlertController(title: "\(title)!!!", message: msg, preferredStyle: .alert)
            alertViewController.addAction(cancel)
            alertViewController.addAction(delete)
            
        }else {
            msg = "Do you want to \(title.lowercased()) \(name) ?"
            
            alertViewController = UIAlertController(title: "\(title)!!!", message: msg, preferredStyle: .alert)
            alertViewController.addAction(cancel)
            alertViewController.addAction(edit)
            
        }
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    func setTabsUI(){
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        stockistCallView.isHidden  = false
        stockistSummaryview.isHidden = true
    }
}

