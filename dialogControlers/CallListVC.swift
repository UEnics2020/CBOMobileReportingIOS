//
//  CallListVC.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 13/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class CallListVC: CustomUIViewController , UITableViewDataSource , UITableViewDelegate,CustomTextViewDelegate {
    func onTextChangeListner(sender: CustomTextView, text: String) {
        let tag = sender.getTag() as! Int
        switch tag {
        case Search_tag:
            searchInList(search: text)
            break
            
        default:
            print ("no tag assigned")
        }
    }
    var multiCallService : Multi_Class_Service_call!
   var progressHUD : ProgressHUD!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var mySearchBar: CustomTextView!
    
    @IBOutlet weak var refresh: CustomeUIButton!
    

    //let data = [1,2,3,4,5,6,7,8,9,10]
    @IBOutlet weak var cancleBtn: CustomeUIButton!
    var customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    var cbohelp = CBO_DB_Helper.shared
    var syncServices: SyncService!
    var progess : ProgressHUD!
    var vc : CustomUIViewController!
    var dr_List = [SpinnerModel]()
    var responseCode : Int!
    var showGeoFencing : Int = 0
    var callTyp = "D"
    var Search_tag = 1;
    let MESSAGE_INTERNET_SYNC=1,MESSAGE_INTERNET_DOWNLOADALL = 2,MESSAGE_INTERNET_IS_CALL_UNLOCKED=3;
    var ReplyMsg = [String : String]()
    var latLong = "";
    var tempValues : SpinnerModel!
    var DR_COLOR = ""
    var CheckType = ""
    var enableGeoFencing = false;
    var isGeoFencingType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         progess = ProgressHUD(vc: self)
        multiCallService = Multi_Class_Service_call()
        myTableView.delegate = self
        self.mySearchBar.delegate = self
        mySearchBar.setTag(tag: Search_tag)
        mySearchBar.setHint(placeholder: "Enter Name to Search..")
        
        showGeoFencing = Int(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "IsBackDate", defaultValue: "0"))!
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        
        myTopView.setText(title: VCIntent["title"]!)
        
        myTopView.backButton.addTarget(self, action: #selector(closeCurrentView), for: .touchUpInside)
        refresh.addTarget(self, action: #selector(refreshLocatiion), for: .touchUpInside)
        cancleBtn.addTarget(self, action: #selector(closeCurrentView), for: .touchUpInside)
        
        DR_COLOR = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DR_COLOR",defaultValue: "");
        
        self.myTableView.dataSource = self
        self.myTableView.register(CallRowCellTableViewCell.self, forCellReuseIdentifier: "cell")
        
        if dr_List.count == 0{
            
            var title = "Doctor"
            switch callTyp{
            case "C":
                title = "Chemist"
                break
            case "S" :
                title = "Stockist"
                break
            case "D","M" :
                title = "Doctor"
                break
            default:
                title = "Data"
            }
            
            customVariablesAndMethod.msgBox(vc: vc, msg: "No \(title) in List")
        }
        
        if (callTyp != "DS" && callTyp != "M"){
            enableGeoFencing = true;
        }
        
        switch callTyp{
        case "D":
            isGeoFencingType = "D"
            break
        case "C" :
            isGeoFencingType = "C"
            break
        case "S" :
            isGeoFencingType = "S"
            break
        case "DA" :
            isGeoFencingType = "R"
            break
        case "PA" :
            isGeoFencingType = "P"
            break
        default:
            isGeoFencingType = ""
        }
        
        
    }
    
    @objc func refreshLocatiion()
    {
       //
       
        FORCEFULLY_ACCEPT_GPS_LOCATION = true
//       progess = ProgressHUD(vc : self)
//        progess.show(text: "Please Wait.. \nRefresh in progess..." )
//        sleep(1)
//        progess.dismiss()
        //self.dismiss(animated: true, completion: nil)
                multiCallService.DownLoadAll(vc: self, response_code: MESSAGE_INTERNET_DOWNLOADALL,progressHUD: progess)
    }
    
    @objc func closeCurrentView()
    {
        myTopView.CloseCurruntVC(vc: self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dr_List.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CallRowCellTableViewCell", owner: self, options: nil)?.first as! CallRowCellTableViewCell
        
        cell.selectionStyle = .none
        
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        
        tempValues = dr_List[indexPath.row]
        
        cell.lblName.text = tempValues.getName()
        
        latLong = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON)

        
        let isGeoFencingRequired = Custom_Variables_And_Method.getInstance().isGeoFencingRequired(s: isGeoFencingType, context: self)
        
        let geo_fancing_km = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc,key: "GEO_FANCING_KM",defaultValue: "0");
        //let geo_fancing_km = "0.1"
        if(tempValues.getAPP_PENDING_YN() != ("0")){
            cell.rightView.isHidden = false
            cell.rightView.backgroundColor = UIColor(hex : "E2571F");
            cell.backgroundColor = UIColor(hex: "E2571F");
            cell.lblFarAway.text = "Additional Area Approval pending..."
        } else if(geo_fancing_km == ("0") || isGeoFencingRequired == false || showGeoFencing == 0 || !enableGeoFencing){//DS = doctor sample //M = MISSED CALL
            cell.rightView.isHidden = true
            cell.lblFarAway.text = "On Call"
        } else if (tempValues.getLoc() == ("")){
            cell.lblFarAway.text = "Registration pending..."
            cell.rightView.backgroundColor = UIColor(hex : "E2571F")
        } else {
            var  km1 = 0.0 ,km2 = -1.0,km3 = -1.0;
//            print(Double(tempValues.getLoc().components(separatedBy: ",")[0])!)
//            print(Double(tempValues.getLoc().components(separatedBy: ",")[1])!)
//            print(Double(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON).components(separatedBy: ",")[0])!)
//            print(Double(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON).components(separatedBy: ",")[1])!)
            
            km1 = Double(distance(lat1: Double(tempValues.getLoc().components(separatedBy: ",")[0].trimmingCharacters(in: .whitespaces))!, lon1: Double(tempValues.getLoc().components(separatedBy: ",")[1].trimmingCharacters(in: .whitespaces))!
                ,  lat2: Double(latLong.components(separatedBy: ",")[0])!, lon2: Double(latLong.components(separatedBy: ",")[1])!, unit: "K"));
            
            if (tempValues.getLoc2() != ("")) {
                km2 = Double(distance(lat1: Double(tempValues.getLoc2().components(separatedBy: ",")[0].trimmingCharacters(in: .whitespaces))!, lon1: Double(tempValues.getLoc2().components(separatedBy: ",")[1].trimmingCharacters(in: .whitespaces))!
                    ,  lat2: Double(latLong.components(separatedBy: ",")[0])!, lon2: Double(latLong.components(separatedBy: ",")[1])!, unit: "K"));
            }else{
                km2 = km1;
            }
            
            if (tempValues.getLoc3() != ("")) {
                km3 = Double(distance(lat1: Double(tempValues.getLoc3().components(separatedBy: ",")[0].trimmingCharacters(in: .whitespaces))!, lon1: Double(tempValues.getLoc3().components(separatedBy: ",")[1].trimmingCharacters(in: .whitespaces))!
                    ,  lat2: Double(latLong.components(separatedBy: ",")[0])!, lon2: Double(latLong.components(separatedBy: ",")[1])!, unit: "K"));
            }else{
                km3 = km1;
            }
            
            
            
            let km = getShortestDistance(km1: km1,km2: km2,km3: km3);
            
            if (km > Double(geo_fancing_km)!){
                cell.lblFarAway.text = "\(km)  Km Away";
                cell.rightView.backgroundColor = UIColor(hex : "E2921F");
            }else{
                cell.rightView.backgroundColor = AppColorClass.logo_green
                cell.lblFarAway.text =  "Within Range"
            }
            
        }
       
        
        if (tempValues.getCOLORYN() == ("0")){
            cell.lblName.textColor = AppColorClass.colorPrimaryDark
        }else{
            if(DR_COLOR == ("")) {
                cell.lblName.textColor = UIColor(hex: "F9BA22");
            }else{
                cell.lblName.textColor = UIColor(hex: DR_COLOR.replacingOccurrences(of: "#", with: ""));
            }
        }
        
        if (tempValues.getCALLYN() == ("0")){
            if (tempValues.getAPP_PENDING_YN() == ("0")){
                cell.backgroundColor = UIColor(hex: "FFFFFF");
            }else{
                cell.backgroundColor = UIColor(hex: "E2571F");
            }
        }else{
            cell.lblFarAway.text =  "Call Done."
            cell.rightView.backgroundColor = UIColor(hex : "C0C0C0");
             cell.backgroundColor = UIColor(hex: "C0C0C0");
        }
        
        
        if (tempValues.getPANE_TYPE() != ("1")) {
            //row.setBackgroundResource(R.color.colorPrimaryDark);
            if (tempValues.getCOLORYN() == ("0")) {
                cell.lblName.textColor = UIColor(hex: "187823");
            } else{
                if(DR_COLOR == ("")) {
                    cell.lblName.textColor = UIColor(hex: "F9BA22");
                }else{
                    cell.lblName.textColor = UIColor(hex: DR_COLOR.replacingOccurrences(of: "#", with: ""));
                }
            }
        }

        if (tempValues.isHighlighted()){
            cell.lblName.textColor = UIColor(hex: "FF8333");
        }
//        else {
//            cell.lblName.textColor = UIColor(hex: "000000");
//        }
        
        return cell
    }
    
    
    func getShortestDistance( km1 : Double, km2  : Double, km3  : Double) -> Double{
        if ((km2 == -1.0 && km3 == -1.0) || ( km3 == -1.0 && km1 < km2 ) || ( km2 == -1.0 && km1<km3 ) || (km1<=km2 && km1<=km3) ){
            tempValues.setREF_LAT_LONG( REF_LAT_LONG: tempValues.getLoc());
                return km1;
        }
        if ((km3 == -1.0) || (km2 < km3 && km2 != -1.0)){
            tempValues.setREF_LAT_LONG( REF_LAT_LONG: tempValues.getLoc2());
            return km2;
        }
        tempValues.setREF_LAT_LONG( REF_LAT_LONG: tempValues.getLoc3());
        return km3;
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : SpinnerModel = dr_List[indexPath.row]
        var dr_id_index = ""
        
        ReplyMsg.removeAll()
        ReplyMsg["Selected_Index"]  = "\(indexPath.row)"
        ReplyMsg["latLong"]  = latLong
        ReplyMsg["dr_id_index"]  = dr_id_index
        ReplyMsg["dr_name"]  = model.getName()
      
        
       
        let cell = tableView.cellForRow(at: indexPath) as! CallRowCellTableViewCell
        if (model.getAPP_PENDING_YN() != ("0")){
            if (!customVariablesAndMethod.IsGPS_GRPS_ON(context: vc)) {
                //customVariablesAndMethod.Connect_to_Internet_Msg(context);
                AppAlert.getInstance()
                    .setNagativeTxt(nagativeTxt: "Cancel")
                    .setPositiveTxt(positiveTxt: "Check")
                    .DecisionAlert(vc: self,
                                   title: "Approval Pending !!!",
                                   massege: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc,key: "DCRDRADDAREA_APP_MSG",defaultValue: "Your Additional Area Approval is Pending... \nYou Additional Area must be approved first !!!\n" + "Please contact your Head-Office for APPROVAL"),
                                   listener: { () -> OnClickListener in
                                    class anonymous  : OnClickListener {
                                        var parent : CallListVC!
                                        func onPositiveClicked(item: UIView?, result: String) {
                                            parent.CheckIfCallsUnlocked(type: "ADDAREA")
                                        }
                                        
                                        func onNegativeClicked(item: UIView?, result: String) {
                                            
                                        }
                                        init(parent : CallListVC) {
                                            self.parent = parent
                                        }
                                    }
                                    return anonymous(parent: self)
                    })

                
            } else {
                CheckIfCallsUnlocked(type: "ADDAREA")
            }
        }else if (cell.lblFarAway.text == "Registration pending..."){
            if (customVariablesAndMethod.IsGPS_GRPS_ON(context: vc)) {

                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "Doctor_registration_GPS") as! Doctor_registration_GPS
               
                var msg = [String :String]()
                msg["callTyp"] = callTyp
                msg["dr_id"] = dr_List[indexPath.row].getId()
                msg["dr_name"] = dr_List[indexPath.row].getName()
                myviewcontroller.VCIntent = msg
                myviewcontroller.Parent_VC = self
               
                
                self.present(myviewcontroller, animated: true, completion:  nil)
                
            }
        }else if(cell.lblFarAway.text!.contains("Km Away")) {
            var km = cell.lblFarAway.text!
            customVariablesAndMethod.getDecisionAlert(vc: self, title: "Not In Range",Ok_Title: "Complaint", msg: "You are \(km)  from \(cell.lblName.text!)", completion: {_ in
            
                km = km.replacingOccurrences(of: "Km Away", with: "").trimmingCharacters(in: .whitespaces)
                
                if(self.dr_List[indexPath.row].getLoc2() == ("") && Double(km)! < Double(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "RE_REG_KM",defaultValue: "5"))!){
                    dr_id_index = "2";
                }else if(self.dr_List[indexPath.row].getLoc3() == ("") && Double(km)! < Double(self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "RE_REG_KM",defaultValue: "5"))!){
                    dr_id_index = "3";
                }
                
                self.ReplyMsg["dr_id_index"]  = dr_id_index
                
                if(dr_id_index != ("") ){
                    self.cbohelp.updateLatLong(latlong: self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON),id: self.dr_List[indexPath.row].getId(),type: self.callTyp,index: dr_id_index);
                    
                    
                    if (self.customVariablesAndMethod.internetConneted(context: self , ShowAlert: false,SkipMadatory: true)) {

                        self.syncServices = SyncService(context: self)
                        self.progess = ProgressHUD(vc : self)
                        self.progess.show(text: "Please Wait.. \nRegistration in progess..." )
                        self.syncServices.DCR_sync_all(responseCode: self.MESSAGE_INTERNET_SYNC,ReplyYN : "Y")

                    }else{
                        self.customVariablesAndMethod.getAlert(vc :self,title : "Registered",msg : "\(cell.lblName.text!)  Successfully Re-Registered(\(dr_id_index))",completion: {_ in
                            self.dismiss(animated: true, completion: nil)
                            self.vc.getDataFromApi(response_code: self.responseCode, dataFromAPI: ["data" : [self.ReplyMsg]])
                        });
                    }
                }else{
                    self.customVariablesAndMethod.getAlert(vc: self, title: "Thank you!", msg: "Complaint Sent To Head Office Sucessfully...")
                }
           })
        }else if( Int(dr_List[indexPath.row].getFREQ())! != 0 && Int(dr_List[indexPath.row].getFREQ())! <  Int(dr_List[indexPath.row].getNO_VISITED())!) {
//
            customVariablesAndMethod.getAlert(vc: self,title: "Visit Freq. Exceeded",msg: "For \(dr_List[indexPath.row].getName)\n Allowed Freq. : \(dr_List[indexPath.row].getFREQ())\n Visited       :  \(dr_List[indexPath.row].getNO_VISITED())" , completion :  {_ in
                  self.dismiss(animated: true, completion: nil)
            });
        }else {
            self.dismiss(animated: true, completion: nil)
            vc.getDataFromApi(response_code: responseCode, dataFromAPI: ["data" : [ReplyMsg]])
        }
    }
    
    
    func CheckIfCallsUnlocked(type : String) {
        //Start of call to service
        
        
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPA_ID" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
        params["sTYPE"] = type
        CheckType = type
        
        var tables = [Int]()
        tables.append(0)
        
        progressHUD = ProgressHUD(vc: self)
        progressHUD.show(text: "Please Wait.. \n Checking Your Call Status...")
        
        CboServices().customMethodForAllServices(params: params, methodName: "CallUnlockStatus", tables: tables, response_code: MESSAGE_INTERNET_IS_CALL_UNLOCKED, vc : self)
        
        //End of call to service
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        switch response_code {
        case MESSAGE_INTERNET_SYNC:
            syncServices.parser_sync(result: dataFromAPI)
            //self.dismiss(animated: true, completion: nil)
            //self.vc.getDataFromApi(response_code: self.responseCode, dataFromAPI: ["data" : [ReplyMsg]])
            self.customVariablesAndMethod.getAlert(vc :self,title : "Registered",msg : "\(ReplyMsg["dr_name"]!)  Successfully Re-Registered(\(ReplyMsg["dr_id_index"]!))",completion: {_ in
                self.dismiss(animated: true, completion: nil)
                self.vc.getDataFromApi(response_code: self.responseCode, dataFromAPI: ["data" : [self.ReplyMsg]])
            });
            
        case MESSAGE_INTERNET_DOWNLOADALL:
            multiCallService.parser_DCRCOMMIT_DOWNLOADALL(dataFromAPI : dataFromAPI)

            customVariablesAndMethod.getAlert(vc: self, title: "Refreshed...", msg: "DCR Sucessfully Refreshed...",completion : {_ in
                self.myTopView.CloseCurruntVC(vc: self)
            })
            break;
        case MESSAGE_INTERNET_IS_CALL_UNLOCKED:
            
            parser_is_call_unlocked(dataFromAPI : dataFromAPI)
            progressHUD.dismiss()
            break;
        case 99:
            progess.dismiss()
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            self.dismiss(animated: true, completion: nil)
            print("Error")
        }
        progess.dismiss()
    }
    
    func searchInList(search : String){
        
        for l in 0 ..< dr_List.count {
            if (search != "" && search.count <= dr_List[l].getName().count) {
                if (dr_List[l].getName().lowercased().contains(search.lowercased().trimmingCharacters(in: .whitespaces))) {
                    //mydr_List.smoothScrollToPosition(l);
                    let indexPath = IndexPath(row: l, section: 0)
                    myTableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    for j in l ..< dr_List.count {
                        if (search.count <= dr_List[j].getName().count) {
                            if (dr_List[j].getName().lowercased().contains(search.lowercased().trimmingCharacters(in: .whitespaces))) {
                                dr_List[j].setHighlight(highlight: true);
                            }else{
                                dr_List[j].setHighlight(highlight: false);
                            }
                        }else{
                            dr_List[j].setHighlight(highlight: false);
                        }
                    }
                    break;
                }else{
                    dr_List[l].setHighlight(highlight: false);
                }
            }else{
                dr_List[l].setHighlight(highlight: false);
            }
        }
        myTableView.reloadData()
    }
    
    
    
    private func parser_is_call_unlocked(dataFromAPI : [String : NSArray]) {
        
        do {
            if (!dataFromAPI.isEmpty){
                let jsonArray =  dataFromAPI["Tables0"]!
                
                for i in 0 ..< jsonArray.count{
                    let innerJson = jsonArray[i] as! [String : AnyObject]
                    if (CheckType == "ADDAREA"){
                        if  (jsonArray.count > 0 && (innerJson["CALL_UNLOCK"]! as! String == ("Y"))) {
                            cbohelp.doctorApproved(APP_PENDING_YN :"0");
                            customVariablesAndMethod.getAlert(vc: self, title: "Approved !!!", msg: "Your Additional Area have been Approved \nYou can please proceed",completion : {_ in
                                self.myTopView.CloseCurruntVC(vc: self)
                            })
                            
                        }
                        else {
                            customVariablesAndMethod.getAlert(vc: self, title: "Approval Pending !!!", msg: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc,key: "DCRDRADDAREA_APP_MSG",defaultValue: "Your Additional Area Approval is Pending... \nYou Additional Area must be approved first !!!\n" + "Please contact your Head-Office for APPROVAL"))
                        }
                    }else if (CheckType == "A"){
                        if  (jsonArray.count > 0 && (innerJson["CALL_UNLOCK"]!.contains("[DIVERT_UNLOCK]"))) {
                            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "DIVERTLOCKYN", value : "" );
                            customVariablesAndMethod.getAlert(vc: self, title: "Route Approved !!!", msg: "Your Calls have been Approved \nYou can please proceed",completion : {_ in
                                self.myTopView.CloseCurruntVC(vc: self)
                            })
                            
                        }
                        else {
                            customVariablesAndMethod.getAlert(vc: self, title: "Route Approval !!!", msg: "Your Route Approval is Pending... \nYou Route must be approved first !!!\nPlease contact your Head-Office for APPROVAL")
                        }
                    } else {
                        if (jsonArray.count > 0 && ( innerJson["CALL_UNLOCK"]?.contains("[CALL_UNLOCK]"))!) {
                            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "CALL_UNLOCK_STATUS", value : "[CALL_UNLOCK]");
                            customVariablesAndMethod.getAlert(vc : self, title : "CALL UNLOCKED", msg : "Your Calls have been Unlocked \nYou can please proceed",completion : {_ in
                                self.myTopView.CloseCurruntVC(vc: self)
                            })
                        } else {
                            let FIRST_CALL_LOCK_TIME = (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self, key :"FIRST_CALL_LOCK_TIME", defaultValue:  "0"));
                            customVariablesAndMethod.getAlert( vc : self, title:  "CALL LOCKED", msg : "Your Calls has been Locked... \nYou must have made your first Call before " + FIRST_CALL_LOCK_TIME + " O'clock\n" +
                                "Please contact your Head-Office to UNLOCK");
                            // customVariablesAndMethod.getAlert(context,"CALL LOCKED","Your Calls has not been Unlocked yet \nPlease contact your administrator to proceed");
                            
                        }
                    }
                }
            }
        }catch {
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
    }

    
}



