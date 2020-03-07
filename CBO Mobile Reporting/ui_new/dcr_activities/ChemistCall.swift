//
//  ChemistCall.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 16/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation

class ChemistCall: CustomUIViewController,CheckBoxDelegate , ParantSummaryAdaptorDalegate {
  
    
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! Int
        
        switch tag {
        case 0:
            let table="chemisttemp";
            if (cbohelp.getmenu_count(table: table)>0 && ischecked){
                //visited.setVisibility(View.GONE);
                customVariablesAndMethod.msgBox(vc: context,msg: "Chemist already in the call-List");
                sender.setChecked(checked: false);
            }else if (sender.isChecked()) {
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "CHEMIST_NOT_VISITED",value: "Y");
                
                // MyConnection.STOCKIST_NOT_VISITED = "Y";
                myTopView.CloseCurruntVC(vc: context)
            }
          
            break
            
        default:
            print ("no tag assigned")
        }
    }
    private var editingIndex = 0
    var presenter : ParantSummaryAdaptor!
    @IBOutlet weak var chemistSummaryTableView: UITableView!
    var header = [String]()
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var callButton: CustomHalfRoundButton!
    @IBOutlet weak var rcpaButton: CustomeUIButton!
    
    @IBOutlet weak var slelectedTabBarButtom: UIView!
    
    @IBOutlet weak var giftBtn: CustomeUIButton!
    @IBOutlet weak var pob_Amt: CustomTextView!
    
    @IBOutlet weak var chemistCallView: CustomBoarder!
    
    @IBOutlet weak var chemistSummaryview: CustomBoarder!
    
    
    @IBOutlet weak var chem_name: UILabel!
    @IBOutlet weak var productBtn: CustomeUIButton!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var pressedAddChemist: CustomeUIButton!
    @IBOutlet weak var visited: CheckBox!
    
    @IBOutlet weak var visited1: UIStackView!
    @IBOutlet weak var remark: CustomTextView!
    @IBOutlet weak var chemistBtn: UIButton!
    @IBOutlet weak var myStackView: UIView!
    @IBOutlet weak var GiftView: UIView!
    
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    @IBOutlet weak var summaryViewHeight: NSLayoutConstraint!
    @IBOutlet weak var loc: CustomDisableTextView!
    @IBOutlet weak var loc_layout: UIStackView!
    
    @IBOutlet weak var summaryStackview: UIStackView!
    var progressHUD :  ProgressHUD!
    var multiCallService = Multi_Class_Service_call()
    
    
    var docList = [SpinnerModel]();
    let CALL_DILOG = 5,PRODUCT_DILOG = 6,GIFT_DILOG = 7 , SUMMARY_DILOG = 8 ,
    REPORT_DIALOG = 9,MESSAGE_INTERNET_SEND_FCM =  10,MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11
    
    var selected_dr_id = "-1"
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    var chemist_list = [String : [String]]()
    var summary_list = [[String : [String : [String]]]]()
    var dcrid = 0;
    var result = 0.0;
    var sample = "0.0";
    var rate = "";
    var time = "";
    
    var chname = "", stk_id = "", stkst_name = "";
    var chm_ok = "", stk_ok = "", exp_ok = "";
    
    var name = "", chm_id = "", chm_name = "",resultList="",dr_name_reg="",dr_id_reg = "",dr_id_index = "";
    var name2 = "", name3 = "", name4 = "";
    var sample_name="",sample_pob="",sample_sample="";
    var gift_name="",gift_qty="";
    
    var sample_name_previous="",sample_pob_previous="",sample_sample_previous="";
    var gift_name_previous="",gift_qty_previous="";
    
    var Hide_status=""
  
    
    var updated = "0";
    var chem_km = "0";
    
    var ref_latLong = "";
    var call_latLong = ""
    
    var context : CustomUIViewController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        chemistCallView.isHidden = false
        chemistSummaryview.isHidden = true
        
        
        
        
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        
        pob_Amt.myCustomeTextVIew.isUserInteractionEnabled = false 
        context = self
        progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        if VCIntent["title"] != nil{
               myTopView.setText(title: VCIntent["title"]!)
        }
     
        pob_Amt.setText(text: "\(result)")
        pob_Amt.setHint(placeholder: "POB Amt.")
        remark.setHint(placeholder: "Enter Remark")
        let working_code = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code",defaultValue: "W")
        
        if (working_code == ("OCC") || (working_code.contains("NR") && !working_code.contains("C"))) {
            visited1.isHidden = true
        }
        
        visited.delegate = self
        visited.setTag(tag: 0)
        
        setAddressToUI();
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        }else{
            loc_layout.isHidden = true
        }
        
        Hide_status = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "fmcg_value", defaultValue: "N")
        
        let ProductCaption = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "SAMPLE_BTN_CAPTION", defaultValue: "")
        if (!ProductCaption.isEmpty){
            productBtn.setText( text: ProductCaption)
        }
        productBtn.addTarget(self, action: #selector(OnProductLoad), for: .touchUpInside )
        
        let GiftCaption = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "GIFT_BTN_CAPTION", defaultValue: "")
        if (!GiftCaption.isEmpty){
            giftBtn.setText( text: GiftCaption)
        }
        
        giftBtn.addTarget(self, action: #selector(OnGiftLoad), for: .touchUpInside )
        
        chemistBtn.addTarget(self, action: #selector(OnClickChemLoad), for: .touchUpInside )
        pressedAddChemist.addTarget(self, action: #selector(OnClickChemSubmit), for: .touchUpInside )
        rcpaButton.addTarget(self, action: #selector(onClickShowButton), for: .touchUpInside )
        callButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        summaryButton.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
       
        summaryBackButton.isHidden = true

        genrateSummary()
        presenter.delegate = self
        
        if customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "CHEMCALL_RCPABUTTONYN", defaultValue: "N") == "Y" {
            rcpaButton.isHidden = false
            
        }else{
            rcpaButton.isHidden = true
        }

        
    }
    
    
    //MARK:- callButton
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedSummaryButton(){
        callButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        chemistSummaryview.isHidden = false
        chemistCallView.isHidden = true
    }
    
    func setTabsUI(){
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        chemistCallView.isHidden  = false
        chemistSummaryview.isHidden = true
    }
    
    func genrateSummary(){
        var headers = [ String]()
        var isCollaps = [Bool]()
        chemist_list = cbohelp.getCallDetail(table: "chemisttemp",look_for_id: "",show_edit_delete: "1")
        do {
             summary_list.append([try cbohelp.getMenuNew(menu: "DCR", code: "D_CHEMCALL").getString(key: "D_CHEMCALL") :    chemist_list])
        }catch{
            print(error)
        }
        
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        
        presenter = ParantSummaryAdaptor(tableView: chemistSummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        header = headers
        myTopView.setText(title: headers[0])
        
        chemistSummaryTableView.dataSource = presenter
        chemistSummaryTableView.delegate = presenter
    }
    
    @objc func pressedBack(){
        myTopView.CloseCurruntVC(vc: self)
    }
  
    
    @objc func OnClickChemSubmit(){
        // if (Custom_Variables_And_Method.GLOBAL_LATLON.equalsIgnoreCase("0.0,0.0")) {
        Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        // }
        
        
        let getCurrentTime = customVariablesAndMethod.get_currentTimeStamp();
        let planTime = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DcrPlantimestamp",defaultValue: customVariablesAndMethod.get_currentTimeStamp());
        let t1 = Float(getCurrentTime);
        let t2 = Float(planTime);
        
        let t3 = t1! - t2!;
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "REMARK_WW_MANDATORY",defaultValue: "").contains("C") &&  remark.getText() == "") {
            
            customVariablesAndMethod.getAlert(vc: self, title: "Alert !!!", msg: "Please enter remark");
            
            
        }else if ((t3 >= 0) || (t3 >= -0.9)) {
            
            do {
                setAddressToUI();
                submitChemist();
            } catch{
                print(error)
            }
            
            
        } else {
            customVariablesAndMethod.getAlert(vc: self, title: "Alert", msg: "Your Plan Time can not be \n Higher Than Current time...");
        }
        
        //myTopView.CloseCurruntVC(vc: self)

    }
    
    
    
    @objc func OnClickChemLoad(){
        do{
            let statement = try cbohelp.getChemistListLocal();
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
            
            
            
            Call_Dialog(vc: self, title: "Select ...", dr_List: docList, callTyp: "C", responseCode: CALL_DILOG).show()
            //docList = new ArrayList<SpinnerModel>();
            //GPS_Timmer_Dialog(context,mHandler,"Scanning Doctors...",GPS_TIMMER).show();
        }catch {
            print(error)
        }
    }
    
    @objc private func onClickShowButton(){
        
        if (chm_name == "") {
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Chemist First..");
            
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let vc = storyboard.instantiateViewController(withIdentifier: "ListExpend") as! ListExpend
                            
                            vc.che_id = chm_id
                            vc.VCIntent["title"] = chm_name
                           self.present(vc, animated: true, completion: nil)
        }
        
    }

    @objc func OnProductLoad(){
        
        if (chm_name == "") {
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Chemist First..");
            
        } else {
            Chm_sample_Dialog(vc: self, dr_List: docList, responseCode: PRODUCT_DILOG, sample_name: sample_name, sample_pob: sample_pob, sample_sample: sample_sample).setPrevious(sample_name_previous: sample_name_previous, sample_pob_previous: sample_pob_previous, sample_sample_previous: sample_sample_previous).show()
        }
        
    }
    
    @objc func OnGiftLoad(){
        if (chm_name == "") {
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Chemist First..");
        } else {
            Gift_Dialog(vc: self, responseCode: GIFT_DILOG, gift_name: gift_name, gift_qty: gift_qty,gift_typ: "chem", gift_name_previous: gift_name_previous,gift_qty_previous: gift_qty_previous).show()
        }
        
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
            
        
        case CALL_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //chem_name.text = docList[Int(inderData["Selected_Index"]!)!].getName()
            
            chm_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            chm_name = docList[Int(inderData["Selected_Index"]!)!].getName()
            chem_name.text = chm_name
            ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
            call_latLong = inderData["latLong"]!
            displayData()
            
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
        case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
            progressHUD.dismiss()
            print("selected_dr_id ",self.selected_dr_id)
            self.cbohelp.delete_Chemist_from_local_all(dr_id: self.selected_dr_id)
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
    
    
    
    
 
    
    
    
    func displayData(){
        if (cbohelp.searchChemist(chem_id: chm_id).contains(chm_id)) {
            chemist_list=cbohelp.getCallDetail(table: "chemisttemp",look_for_id: chm_id,show_edit_delete: "0");
            
            if (chemist_list["sample_name"]![0] != "") {
                sample_name = chemist_list["sample_name"]![0]
                sample_sample = chemist_list["sample_qty"]![0]
                sample_pob = chemist_list["sample_pob"]![0]
                
                name = chemist_list["sample_id"]![0]
                name2 = sample_pob
                sample = sample_sample
                
                let sample_name1 = sample_name.components(separatedBy: ",");
                let sample_qty1 = sample_sample.components(separatedBy: ",");
                let sample_pob1 = sample_pob.components(separatedBy: ",");
                ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
            }else{
                sample_name="";
                sample_pob="";
                sample_sample="";
                RemoveAllviewsinProduct(myStackView: myStackView)
            } 
            
            if (chemist_list["gift_name"]![0] != "") {
                
                gift_name = chemist_list["gift_name"]![0]
                gift_qty = chemist_list["gift_qty"]![0]
                
                name4 = gift_qty
                name3 = chemist_list["gift_id"]![0]
                
                let gift_name1 = gift_name.components(separatedBy: ",");
                let gift_qty1 = gift_qty.components(separatedBy: ",");
                ShowDrSampleGift(gift_name: gift_name1, gift_qty: gift_qty1);
            }else{
                gift_name = ""
                gift_qty = ""
                RemoveAllviewsinProduct(myStackView: GiftView)
            }
            
            pressedAddChemist.setText(text: "Update Chemist");
        }else{
            
            sample_name="";
            sample_pob="";
            sample_sample="";
            
            RemoveAllviewsinProduct(myStackView: myStackView)
            RemoveAllviewsinProduct(myStackView: GiftView)
            
            pressedAddChemist.setText(text: "Add Chemist");
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

    func  submitChemist() {

        customVariablesAndMethod.getBatteryLevel()
        let currentBatterLevel = Custom_Variables_And_Method.BATTERYLEVEL;
        if (loc.getText() == "") {
            loc.setText(text: "UnKnown Location");
        }
        let chm_name = chem_name.text
        
        let address = loc.getText()
        let dcrid = Custom_Variables_And_Method.DCR_ID;
        let PobAmt = pob_Amt.getText()
        var AllItemId = "";
        var AllItemQty = "";
        var AllGiftId = "";
        let AllSampleQty = "";
        var AllGiftQty = "";
        if (docList.isEmpty && chm_id == "") {
            
            if (Hide_status == "N") {
                customVariablesAndMethod.msgBox(vc: context,msg: "No Chemist in List....");
            } else {
                customVariablesAndMethod.msgBox(vc: context,msg: "No Retailer in List....");
            }
            
        } else if (chm_name == "--Select--") {
            
            if (Hide_status == "N") {
                customVariablesAndMethod.msgBox(vc: context,msg: "Please Select  Chemist from List....");
            } else {
                customVariablesAndMethod.msgBox(vc: context,msg: "Please Select  Retailer from List....");
            }
            
        } else if (Custom_Variables_And_Method.getInstance().isCheckForProduct(s: "C", context: self)){
        
                    if (!(PobAmt == "" || PobAmt == "0") && (sample_name == "")) {
                        //if (sample_name == "") {
                            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Atleast 1 product first");
            //            }else{
            //                //finish();
            //                myTopView.CloseCurruntVC(vc: context)
            //            }
                    } else {
                        
                        for i in 0 ..< 1{
                            AllItemId = AllItemId + name;
                            AllItemQty = AllItemQty + name2;
                        }
                        
                        if (name3 == "") {
                            AllGiftId = AllGiftId + "0";
                            AllGiftQty = AllGiftQty + "0";
                        } else {
                            
                            for i in 0 ..< 1{
                                AllGiftId = AllGiftId + name3;
                                AllGiftQty = AllGiftQty + name4;
                            }
                        }
                        
                        if (cbohelp.searchChemist(chem_id: chm_id).contains(chm_id)) {
                            cbohelp.updateChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address: call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: time,sample: sample,remark: remark.getText(),file: "", rate: rate, status: "", Competitor_Product: "");
                            print("chemist updated");
                            
                            

                            customVariablesAndMethod.msgBox(vc: context,msg: chm_name! + "  successfully updated", completion: {_ in
                                self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                            
                        } else {
                            
                            var locExtra = ""
                            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
                            let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
                            
                            if (currentBestLocation != CLLocation()) {
                                locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
                            }
                            
                            cbohelp.submitChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address:  call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: customVariablesAndMethod.currentTime(context: context), battryLevel: currentBatterLevel,sample: sample,remark: remark.getText(),file: "",LOC_EXTRA: locExtra,Ref_latlong: ref_latLong, rate: rate, status: "", Competitor_Product: "");
                            
                            cbohelp.addChemistInLocal(chemid: chm_id, chemname: chm_name!,visit_time: ""+customVariablesAndMethod.currentTime(context: context), chem_latLong: call_latLong, chem_address: Custom_Variables_And_Method.global_address,updated: updated,chem_km: chem_km,srno: customVariablesAndMethod.srno(context: context),LOC_EXTRA: locExtra);
                            
                            
                            print("chemist details", dcrid + "," + chm_id + "," + PobAmt + "," + AllItemId + "," + AllItemQty + "," + address + "," + AllGiftId + "," + AllGiftQty);
                            
                            chm_ok = getmydata()[0];
                            stk_ok = getmydata()[1];
                            exp_ok = getmydata()[2];
                            
                            
                            if (chm_ok == "") {
                                cbohelp.insertfinalTest(chemist: chm_id, stockist: stk_ok, exp: exp_ok);
                            } else {
                                cbohelp.updatefinalTest(chemist: chm_id, stockist: stk_ok, exp: exp_ok);
                            }
                            
                            pob_Amt.setText(text: "");
                            Custom_Variables_And_Method.CHEMIST_NOT_VISITED = "Y";
                            
                            customVariablesAndMethod.msgBox(vc: context,msg: chm_name! + " Added Successfully", completion: {_ in self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                            
                        }
                        
                        
                    }
        
        } else {
            
            for i in 0 ..< 1{
                AllItemId = AllItemId + name;
                AllItemQty = AllItemQty + name2;
            }
            
            if (name3 == "") {
                AllGiftId = AllGiftId + "0";
                AllGiftQty = AllGiftQty + "0";
            } else {
                
                for i in 0 ..< 1{
                    AllGiftId = AllGiftId + name3;
                    AllGiftQty = AllGiftQty + name4;
                }
            }
            
            if (cbohelp.searchChemist(chem_id: chm_id).contains(chm_id)) {
                cbohelp.updateChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address: call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: time,sample: sample,remark: remark.getText(),file: "", rate: rate, status: "", Competitor_Product: "");
                print("chemist updated");
                
                

                customVariablesAndMethod.msgBox(vc: context,msg: chm_name! + "  successfully updated", completion: {_ in
                    self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                
            } else {
                
                var locExtra = ""
                Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
                let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
                
                if (currentBestLocation != CLLocation()) {
                    locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
                }
                
                cbohelp.submitChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address:  call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: customVariablesAndMethod.currentTime(context: context), battryLevel: currentBatterLevel,sample: sample,remark: remark.getText(),file: "",LOC_EXTRA: locExtra,Ref_latlong: ref_latLong, rate: rate, status: "", Competitor_Product: "");
                
                cbohelp.addChemistInLocal(chemid: chm_id, chemname: chm_name!,visit_time: ""+customVariablesAndMethod.currentTime(context: context), chem_latLong: call_latLong, chem_address: Custom_Variables_And_Method.global_address,updated: updated,chem_km: chem_km,srno: customVariablesAndMethod.srno(context: context),LOC_EXTRA: locExtra);
                
                
                print("chemist details", dcrid + "," + chm_id + "," + PobAmt + "," + AllItemId + "," + AllItemQty + "," + address + "," + AllGiftId + "," + AllGiftQty);
                
                chm_ok = getmydata()[0];
                stk_ok = getmydata()[1];
                exp_ok = getmydata()[2];
                
                
                if (chm_ok == "") {
                    cbohelp.insertfinalTest(chemist: chm_id, stockist: stk_ok, exp: exp_ok);
                } else {
                    cbohelp.updatefinalTest(chemist: chm_id, stockist: stk_ok, exp: exp_ok);
                }
                
                pob_Amt.setText(text: "");
                Custom_Variables_And_Method.CHEMIST_NOT_VISITED = "Y";
                
                customVariablesAndMethod.msgBox(vc: context,msg: chm_name! + " Added Successfully", completion: {_ in self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                
            }
            
            
        }
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
        } catch {
            print(error)
        }
        raw.append(chm);
        raw.append(stk);
        raw.append(exp);
        return raw;
    }
    
    func RemoveAllviewsinProduct(myStackView : UIView){
        while( myStackView.subviews.count > 0 ) {
            myStackView.subviews[0].removeFromSuperview()
        }
    }
    
    func ShowDrSampleProduct( sample_name : [String],  sample_qty : [String], sample_pob : [String]){
       
        RemoveAllviewsinProduct(myStackView: myStackView)
        
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
    
    func ShowDrSampleGift( gift_name : [String],  gift_qty : [String]){
        let myStackView = GiftView!
        RemoveAllviewsinProduct(myStackView: myStackView)
        
        var heightConstraint : NSLayoutConstraint!
        // var stackViewHeightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!
        
        var previousStackView : UIStackView!
        
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myStackView.addSubview(myLabel)
        myLabel.text =  "Gift"
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
        myLabel2.text =  "Qty."
        
       
        
        let myinnerStackView = UIStackView()
        myinnerStackView.axis =  .horizontal
        myStackView.addSubview(myinnerStackView)
        myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false
        
       
        myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel2.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor ).isActive =  true
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
  
        previousStackView = myinnerStackView
        
        for i in 0 ..< gift_name.count{
            
            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myStackView.addSubview(myLabel)
            myLabel.text =  gift_name[i]
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
            myLabel2.text =  gift_qty[i]
            
           
            
            let myinnerStackView = UIStackView()
            myinnerStackView.axis =  .horizontal
            myStackView.addSubview(myinnerStackView)
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
            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
            
            //}
            
            
            heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true
            
            
            widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true
            
          
            previousStackView = myinnerStackView
            
            
        }
        
        
        previousStackView.bottomAnchor.constraint(equalTo: myStackView.bottomAnchor).isActive =  true
        
    }
}


// delegate methods

extension ChemistCall{
    
    
    func onEdit(id: String , name : String) {
        print(id , name)
        getAlert(id:id, name : name ,  title: "Edit")
    }
    
    func onDelete(id: String , name: String) {
     selected_dr_id = id //@rinku
//        getAlert(id : id ,name : name , title: "Delete")
        
        AppAlert.getInstance()
            .setPositiveTxt(positiveTxt: "Delete")
            .DecisionAlert(vc: self,
                           title: "Delete!!!",
                           massege: "Do you Really want to delete " + name + " ?",
                           listener: { () -> OnClickListener in
                            class anonymous  : OnClickListener {
                                var parent : ChemistCall!
                                var id: String!
                                var Dr_name: String!
                                func onPositiveClicked(item: UIView?, result: String) {
                                    
                                    //Start of call to service
                                    
                                    var params = [String : String]()
                                    params["sCompanyFolder"] = parent.cbohelp.getCompanyCode()
                                    params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
                                    params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
                                    params["iDR_ID"] = id
                                    params["sTableName"] =  "CHEMIST"
                                    
                                    
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
                                init(parent : ChemistCall,id: String,Dr_name : String) {
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
            self.chm_name = name
            self.chm_id = id
            self.chem_name.text = self.chm_name
            self.displayData()
        }
        
        let delete = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.setTabsUI()
            self.chm_name = name
            self.chm_id = id
            self.chem_name.text = self.chm_name
            self.cbohelp.delete_Chemist_from_local_all(dr_id: self.chm_id)
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
    
}





