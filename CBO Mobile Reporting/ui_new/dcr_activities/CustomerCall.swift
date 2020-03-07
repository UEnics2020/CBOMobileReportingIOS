//
//  CustomerCall.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 23/07/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
import CoreLocation
class CustomerCall : CustomUIViewController,ParantSummaryAdaptorDalegate,CustomTextViewWithButtonDelegate,CheckBoxDelegate , FTPUploadDelegate{
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        openGallery()
    }
    
    func onEdit(id: String , name : String) {
//            AppAlert.getInstance()
//                .setNagativeTxt(nagativeTxt: "No")
//                .setPositiveTxt(positiveTxt: "Yes")
//                .DecisionAlert(vc: self,
//                               title: "Edit!!!",
//                               massege: "Do you want to Edit \(name) ?",
//                    listener: { () -> OnClickListener in
//                        class anonymous  : OnClickListener {
//                            var parent : CustomerCall!
//                            var id: String!
//                            var name: String!
//                            func onPositiveClicked(item: UIView?, result: String) {
//                                parent.setTabsUI()
//                                parent.chm_name = name
//                                parent.chm_id = id
//                                parent.CustomerName.text = name
//                                parent.displayData()
//
//                            }
//
//                            func onNegativeClicked(item: UIView?, result: String) {
//
//                            }
//                            init(parent : CustomerCall,id: String , name : String) {
//                                self.parent = parent
//                                self.id = id
//                                self.name = name
//                            }
//                        }
//                        return anonymous(parent: self,id: id,name: name)
//                })
        
        
    }
    
    func onDelete(id: String , name: String) {
            AppAlert.getInstance()
                .setPositiveTxt(positiveTxt: "Delete")
                .DecisionAlert(vc: self,
                               title: "Delete!!!",
                               massege: "Do you Really want to delete " + name + " ?",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : CustomerCall!
                                    var id: String!
                                    var Dr_name: String!
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        
                                        parent.chm_name = Dr_name
                                        parent.chm_id = id
                                        //Start of call to service
                                        
                                        var params = [String : String]()
                                        params["sCompanyFolder"] = parent.cbohelp.getCompanyCode()
                                        params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
                                        params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
                                        params["iCHEM_ID"] = id
                                        
                                        
                                        var tables = [Int]()
                                        tables.append(0)
                                        
                                        parent.progressHUD.show(text: "Please Wait..." +
                                            "\nDeleting " + Dr_name + " from DCR..." )
                                        //        self.view.addSubview(progressHUD)
                                        
                                        CboServices().customMethodForAllServices(params: params, methodName: "DCRLEAD_DELETE_COMMIT", tables: tables, response_code: parent.MESSAGE_INTERNET_DRCHEMDELETE_MOBILE, vc : parent)
                                        
                                        
                                        //End of call to service
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : CustomerCall,id: String,Dr_name : String) {
                                        self.parent = parent
                                        self.id = id
                                        self.Dr_name = Dr_name
                                    }
                                }
                                return anonymous(parent: self,id: id,Dr_name : name)
                })
       
        
        
    }
    
    
    func onClickListnter(sender: CustomTextViewWithButton) {
        switch (sender.getTag()) {
        case WORK_WITH_DILOG:
            onClickWorkWith()
            
        default:
            print("tag not assighned")
        }
    }
    

    
    @IBOutlet weak var competitiveProduct: CustomTextView!
    @IBOutlet weak var OthRemark: CustomTextView!
    @IBOutlet weak var statusTxt: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var statusLayout: CustomBoarder!

    @IBOutlet weak var remarkTxt: UILabel!
    @IBOutlet weak var remarkBtn: UIButton!
    @IBOutlet weak var remarkLayout: CustomBoarder!
    @IBOutlet weak var loc: CustomDisableTextView!
    @IBOutlet weak var loc_layout: UIStackView!
    
    @IBOutlet weak var leadLayout: UIStackView!
    @IBOutlet weak var leadBtn: CustomeUIButton!
    @IBOutlet weak var leadSummary: CustomeUIButton!
    
    @IBOutlet weak var productGiftLayout: UIStackView!
    @IBOutlet weak var giftBtn: CustomeUIButton!
    @IBOutlet weak var productBtn: CustomeUIButton!
    @IBOutlet weak var summaryBackBtn: CustomeUIButton!
    @IBOutlet weak var SummaryTableView: UITableView!
    @IBOutlet weak var CustomerBtn: UIButton!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var slectedTabBarButom: UIView!
    @IBOutlet weak var SummaryBtn: CustomHalfRoundButton!
    @IBOutlet weak var CallBtn: CustomHalfRoundButton!
    @IBOutlet weak var Topview: TopViewOfApplication!
    @IBOutlet weak var Callview: CustomBoarder!
    @IBOutlet weak var SummaryView: CustomBoarder!
    
    @IBOutlet weak var LeadView: UIView!
    @IBOutlet weak var GiftView: UIView!
    @IBOutlet weak var myStackView: UIView!
    
    @IBOutlet weak var work_with: CustomTextViewWithButton!
    
    @IBOutlet weak var addCustomer: CustomeUIButton!
    
    @IBOutlet weak var addAttachment: CheckBox!
    @IBOutlet weak var AttachmentImageView: UIImageView!
    
    var objImagePicker : ImagePicker!
    
    var context : CustomUIViewController!
    var progressHUD :  ProgressHUD!
    var multiCallService = Multi_Class_Service_call()
    var imagePickerController = UIImagePickerController()
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    var presenter : ParantSummaryAdaptor!
    var header = [String]()
    
    var customer_list = [String : [String]]()
    var summary_list = [[String : [String : [String]]]]()
    var docList = [SpinnerModel]();
    
    let CALL_DILOG = 5,PRODUCT_DILOG = 6,GIFT_DILOG = 7, SUMMARY_DILOG = 8, REPORT_DIALOG = 9, MESSAGE_INTERNET_SEND_FCM =  10, MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11, WORK_WITH_DILOG = 12,REMARK_DILOG = 13,MESSAGE_INTERNET_LEAD_SUMMARY_URL = 14,LEAD_DILOG = 15,MESSAGE_INTERNET_LEAD_COMMIT = 16,STATUS_DILOG = 17
    
    var remark_list = [String]()
    var status_list = [String]()
    
    var name = "", chm_id = "", chm_name = "",resultList="",dr_name_reg="",dr_id_reg = "",dr_id_index = "";
    var name2 = "", name3 = "", name4 = "";
    var sample_name="",sample_pob="",sample_sample="";
    var gift_name="",gift_qty="";
    var lead_names="",lead_ids="";
    var lead_names_previous="",lead_ids_previous="";
    
    var sample_name_previous="",sample_pob_previous="",sample_sample_previous="";
    var gift_name_previous="",gift_qty_previous="";
    
    
    var dcrid = 0;
    var result = 0.0;
    var sample = "0.0";
    var rate = "";
    var time = "";
    
    var work_with_name = ""
    var work_with_id = ""
    
    var ref_latLong = "";
    var call_latLong = ""
    var LeadSummaryLink = "";
    var filename="";
    
    var Activitytitle = "Customer Call";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Callview.isHidden = false
        SummaryView.isHidden = true
        
        slectedTabBarButom.backgroundColor = AppColorClass.tab_sellected
        CallBtn.setButtonColor(color: AppColorClass.tab_sellected!)
        SummaryBtn.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        context = self
        progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        Topview.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        if VCIntent["title"] != nil{
            Activitytitle = VCIntent["title"]!
        }
        
        Topview.setText(title: Activitytitle)
        
        if(Custom_Variables_And_Method.location_required == "Y") {
            loc_layout.isHidden = false
        }else{
            loc_layout.isHidden = true
        }
        
        addAttachment.delegate = self
        filename = ""
        
        work_with.delegate = self
        work_with.setTag(tag: WORK_WITH_DILOG)
        work_with.setHint(placeholder: "Press + Sign for Work-With")
        
        remark_list = cbohelp.get_Doctor_Call_Remark();
        remarkBtn.addTarget(self, action: #selector(OnClickRemarkLoad), for: .touchUpInside )
        
        if (customVariablesAndMethod.IsProductEntryReq(context: context)) {
        
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
        }else{
//            giftBtn.isHidden = true
//             productBtn.isHidden = true
            productGiftLayout.isHidden = true
        }
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCR_LEAD_ENTRY_YN", defaultValue: "Y") != "Y"){
            
            leadLayout.isHidden = true
        }
        
        leadBtn.addTarget(self, action: #selector(OnLeadLoad), for: .touchUpInside )
        leadSummary.addTarget(self, action: #selector(OnLeadSummaryLoad), for: .touchUpInside )
        
        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCR_CALL_STATUS_YN", defaultValue: "Y") != "Y"){
            statusLayout.isHidden = true
        }
        status_list = cbohelp.get_Doctor_Call_Status_List();
         statusBtn.addTarget(self, action: #selector(OnClickStatusLoad), for: .touchUpInside )
    
        OthRemark.setHint(placeholder: "Call Discussion")
       competitiveProduct.setHint(placeholder: "Competitor Product being used")
        
        CustomerBtn.addTarget(self, action: #selector(OnClickCustomerLoad), for: .touchUpInside )
        
         addCustomer.addTarget(self, action: #selector(commitLead), for: .touchUpInside )
        
        
        CallBtn.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        SummaryBtn.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
        
        
        summaryBackBtn.isHidden = true
        
        genrateSummary()
        presenter.delegate = self
    }
    
    
    
    //MARK:- callButton
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedSummaryButton(){
        CallBtn.setButtonColor(color: AppColorClass.tab_unsellected!)
        SummaryBtn.setButtonColor(color: AppColorClass.tab_sellected!)
        SummaryView.isHidden = false
        Callview.isHidden = true
    }
    
    func setTabsUI(){
        CallBtn.setButtonColor(color: AppColorClass.tab_sellected!)
        SummaryBtn.setButtonColor(color: AppColorClass.tab_unsellected!)
        SummaryView.isHidden  = true
        Callview.isHidden = false
    }
    
    func genrateSummary(){
        var headers = [ String]()
        var isCollaps = [Bool]()
        customer_list = cbohelp.getCallDetail(table: "chemisttemp",look_for_id: "",show_edit_delete: "1")
        do {
            summary_list.append([Activitytitle :    customer_list])
        }catch{
            print(error)
        }
        
        for header in summary_list{
            for header1 in  header{
                headers.append(header1.key)
                isCollaps.append(false)
            }
        }
        
        presenter = ParantSummaryAdaptor(tableView: SummaryTableView, vc: self , summaryData : summary_list , headers : headers, isCollaps: isCollaps  )
        header = headers
        //Topview.setText(title: headers[0])
        
        SummaryTableView.dataSource = presenter
        SummaryTableView.delegate = presenter
    }
    
    @objc func pressedBack(){
        Topview.CloseCurruntVC(vc: self)
    }
    
    

    
    
    
    @objc func OnClickCustomerLoad(){
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
    
    
    func onClickWorkWith() {
        if( chm_name == ""){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Customer....")
        }else{
            var msg = [String : String]()
            msg["header"] = "Select Work-With..."
            msg["sDCR_DATE"] = "1"
            Work_With_Dialog(vc: self, msg: msg, responseCode: WORK_WITH_DILOG).show()
        }
    }
    
    @objc func OnClickRemarkLoad(){
        if( chm_name == ""){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Customer....")
        }else{
            Remark_Dialog(vc: self, title: "Select Remark....", List: remark_list, responseCode: REMARK_DILOG).show()
        }
    }
    
    @objc func OnClickStatusLoad(){
        if( chm_name == ""){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please select Customer....")
        }else{
            Remark_Dialog(vc: self, title: "Select Status....", List: status_list, responseCode: STATUS_DILOG).show()
        }
    }
    
    @objc func OnProductLoad(){
        if (chm_name == "") {

            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Customer First..");
        } else {
            Chm_sample_Dialog(vc: self, dr_List: docList, responseCode: PRODUCT_DILOG, sample_name: sample_name, sample_pob: sample_pob, sample_sample: sample_sample).setPrevious(sample_name_previous: sample_name_previous, sample_pob_previous: sample_pob_previous, sample_sample_previous: sample_sample_previous).show()
        }

    }
    
    @objc func OnLeadLoad(){
        if (chm_name == "") {
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Customer First..");
        } else {
            Lead_Dialog(vc: self, dr_List: docList, responseCode: LEAD_DILOG, lead_names: lead_names).setPrevious(lead_names_previous: lead_names_previous).show()
        }
        
    }
    
    @objc func OnLeadSummaryLoad(){
         customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: leadSummary.getText(), url: LeadSummaryLink + "&CHEM_ID=" + chm_id)
    }

    @objc func OnGiftLoad(){
        if (chm_name == "") {

            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Customer First..");
        } else {
            Gift_Dialog(vc: self, responseCode: GIFT_DILOG, gift_name: gift_name, gift_qty: gift_qty,gift_typ: "chem", gift_name_previous: gift_name_previous,gift_qty_previous: gift_qty_previous).show()
        }

    }
    
   
    
    @objc func commitLead(){
        if (chm_name == "") {
        
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Customer First..");
        }
//        else if(work_with_id.trimmingCharacters(in: .whitespaces).isEmpty ){
//            customVariablesAndMethod.msgBox(vc: context, msg: "Please Select Workwith...");
//        }
        else if (OthRemark.getText().trimmingCharacters(in: .whitespaces).isEmpty){
            customVariablesAndMethod.msgBox(vc: context, msg: "Please enter Call Discussion...");
        }
//        else if (lead_ids.trimmingCharacters(in: .whitespaces).isEmpty &&
//        leadLayout.isHidden == false){
//            customVariablesAndMethod.msgBox(vc: context, msg: "Please Select atleast one lead...");
//        }
        else if(!filename.trimmingCharacters(in: .whitespaces).isEmpty) {
            objImagePicker.saveImageDocumentDirectory(fileName: filename, image: AttachmentImageView.image!, FOLDER_NAME: objImagePicker.albumName)
            
            
            //                  AttachmentImageView.image! = objImagePicker.getPhotoFromCustomAlbum()
            
            let ftpUpload = Up_Down_Ftp()
            
            ftpUpload.UploadDelegate = self
            //2
            progressHUD = ProgressHUD(vc: self)
            progressHUD.show(text: "Please Wait...\nUploading Image")
            if !(UIImage(contentsOfFile: objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))!.convertImageToUploadableData().isEmpty){
                
                print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))
                // set Image name
                ftpUpload.uploadFile(data: (AttachmentImageView.image?.convertImageToUploadableData())!, fileName: filename)
                
            }
        }else{

            LeadCommit();
        }
    }

    
    func upload_complete(IsCompleted: String) {
        
        
        switch IsCompleted {
            
            case "S":
                //progressHUD.show(text: "Please Wait...\nUploading Image")
                break
            
            case "Y":
                progressHUD.dismiss()
                //customVariablesAndMethod.msgBox(vc: self, msg: "Photo Upload Completed")
                LeadCommit();
                break
            case "530":
                progressHUD.dismiss()
                customVariablesAndMethod.msgBox(vc: self, msg: "No Details found for upload\nPlease Download Data From Utilities Page....")
                break
            case "50":
                progressHUD.dismiss()
                break
            
            default:
                progressHUD.dismiss()
                customVariablesAndMethod.msgBox(vc: self,msg:"UPLOAD FAILED \n Please try again")
        }
        
    }
    
    private func LeadCommit(){
    //Start of call to service
        
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        params["iDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
        params["iCHEM_ID" ]  =  chm_id
        params["sITEM_ID"] = lead_ids
        params["sSTATUS" ]  = ""
        params["sREAMRK"] = OthRemark.getText()
        params["sCHEM_STATUS" ]  =  statusTxt.text!
        params["sCOMPETITOR_REMARK"] = competitiveProduct.getText()

        var tables = [Int]()
        tables.append(0)

        progressHUD.show(text: "Please wait ..." )

        CboServices().customMethodForAllServices(params: params, methodName: "DCRLEAD_COMMIT_1", tables: tables, response_code: MESSAGE_INTERNET_LEAD_COMMIT, vc : self)


    
    //End of call to service
    }
    
    
    func  submitChemist() {
        
        customVariablesAndMethod.getBatteryLevel()
        let currentBatterLevel = Custom_Variables_And_Method.BATTERYLEVEL;
        if (loc.getText() == "") {
            loc.setText(text: "UnKnown Location");
        }
        
        
        let address = loc.getText()
        let dcrid = Custom_Variables_And_Method.DCR_ID;
        var updated = "0";
        var chem_km = "0";
        let PobAmt = "0.0"
        var AllItemId = "";
        var AllItemQty = "";
        var AllGiftId = "";
        let AllSampleQty = "";
        var AllGiftQty = "";
     
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
                cbohelp.updateChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address: call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: time,sample: sample,remark: OthRemark.getText(),file: "", rate: rate, status: statusTxt.text!, Competitor_Product: competitiveProduct.getText());
                print("chemist updated");
                
                
                
                customVariablesAndMethod.msgBox(vc: context,msg: chm_name + "  successfully updated", completion: {_ in
                    self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                
            } else {
                var locExtra = ""
                Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
                let currentBestLocation = customVariablesAndMethod.getObject(context: context,key: "currentBestLocation");
                
                if (currentBestLocation != CLLocation()) {
                    locExtra = "Lat_Long  \(currentBestLocation.coordinate.latitude),  \(currentBestLocation.coordinate.longitude ), Accuracy \(currentBestLocation.horizontalAccuracy ) , Time \( currentBestLocation.timestamp), Speed \( currentBestLocation.speed ), Provider "
                }
                
                cbohelp.submitChemistInLocal(dcrid: dcrid, chemid: chm_id, pobamt: PobAmt, allitemid: AllItemId, allitemqty: AllItemQty, address:  call_latLong + "!^" + address, allgiftid: AllGiftId, allgiftqty: AllGiftQty, time: customVariablesAndMethod.currentTime(context: context), battryLevel: currentBatterLevel,sample: sample,remark: OthRemark.getText(),file: "",LOC_EXTRA: locExtra,Ref_latlong: ref_latLong, rate: rate, status: statusTxt.text!, Competitor_Product: competitiveProduct.getText());
                
                cbohelp.addChemistInLocal(chemid: chm_id, chemname: chm_name,visit_time: ""+customVariablesAndMethod.currentTime(context: context), chem_latLong: call_latLong, chem_address: Custom_Variables_And_Method.global_address,updated: updated,chem_km: chem_km,srno: customVariablesAndMethod.srno(context: context),LOC_EXTRA: locExtra);
                
                
                print("chemist details", dcrid + "," + chm_id + "," + PobAmt + "," + AllItemId + "," + AllItemQty + "," + address + "," + AllGiftId + "," + AllGiftQty);
                
        
                Custom_Variables_And_Method.CHEMIST_NOT_VISITED = "Y";
                
                customVariablesAndMethod.msgBox(vc: context,msg: chm_name + " Added Successfully", completion: {_ in self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.chm_id,latlong: "")})
                
            }
            
            
        
    }
    
    
    private func IsLeadSummaryRequired(){
        leadSummary.isHidden = LeadSummaryLink.trimmingCharacters(in: .whitespaces).isEmpty ;
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {


        case CALL_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //chem_name.text = docList[Int(inderData["Selected_Index"]!)!].getName()

            chm_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            chm_name = docList[Int(inderData["Selected_Index"]!)!].getName()
            CustomerName.text = chm_name
            ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
            call_latLong = inderData["latLong"]!
            
           
            displayData()
            LeadSummaryLink = ""
            IsLeadSummaryRequired()
            if (!cbohelp.getMenuUrl(menu: "TRANSACTION", menu_code: "T_LEADM").trimmingCharacters(in: .whitespaces).isEmpty ){
                getLeadSummaryURL(chm_id: chm_id);
            }

            break
        case MESSAGE_INTERNET_LEAD_SUMMARY_URL:
            do{
                let  jsonArray =   dataFromAPI["Tables0"]!
                let innerJson = jsonArray[0] as! [String : AnyObject]
                LeadSummaryLink = try innerJson.getString(key: "LEAD_URL");
                IsLeadSummaryRequired()
            }catch {
                print("MYAPP", "objects are: \(error)")
                customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
                
                
                
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription)", vc: context)
                
                objBroadcastErrorMail.requestAuthorization()
                
            }
            progressHUD.dismiss()
            break
        case MESSAGE_INTERNET_LEAD_COMMIT :
            submitChemist()
            progressHUD.dismiss()
            break;
        case WORK_WITH_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            
            work_with_name = inderData["workwith_name"]!
            work_with_id = inderData["workwith_id"]!
            
            work_with.setText(text: work_with_name)
            break
        case REMARK_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            remarkTxt.text = remark_list[Int(inderData["Selected_Index"]!)!]
//            if (remarkTxt.text?.lowercased() == "other"){
//                remark.setText(text: "");
//                remark.isHidden = false
//            }else{
//                remark.setText(text: remarkTxt.text!);
//                remark.isHidden = true
//            }
            break
            
        case STATUS_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            statusTxt.text = status_list[Int(inderData["Selected_Index"]!)!]
           
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

            //pob_Amt.setText(text: inderData["resultpob"]!)
            sample_name=resultList;
            sample_sample=sample;
            sample_pob=name2;

            let sample_name1 = resultList.components(separatedBy: ",");
            let sample_qty1 = sample.components(separatedBy: ",");
            let sample_pob1 = name2.components(separatedBy: ",");
            ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
            break
            
        case LEAD_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
           
            
            lead_names = inderData["resultList"]!
            lead_ids = inderData["val"]!
            
            
            let lead_names1 = lead_names.components(separatedBy: ",");
            ShowDrSampleGift(myStackView: LeadView,gift_name: lead_names1, gift_qty: [],title_name: "Lead",title_qty: "");
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
            ShowDrSampleGift(myStackView: GiftView,gift_name: gift_name1, gift_qty: gift_qty1,title_name: "Gift",title_qty: "Qty.");
            break
        case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
            progressHUD.dismiss()
            self.cbohelp.delete_Chemist_from_local_all(dr_id: self.chm_id)
            self.pressedBack()

            break
        case MESSAGE_INTERNET_SEND_FCM + 100 :
            self.multiCallService.parser_FCM(dataFromAPI: dataFromAPI)
            break
        case MESSAGE_INTERNET_SEND_FCM :
            progressHUD.dismiss()
            self.Topview.CloseAllVC(vc: self.context)
            break
        case 99:
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            progressHUD.dismiss()
            print("Error")
        }
    }




    public func getLeadSummaryURL(chm_id : String){
        
        //Start of call to service
        
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iCHEM_ID" ]  =  chm_id
        params["iLOGIN_PA_ID" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        
        var tables = [Int]()
        
        
        tables.append(0)
        
        progressHUD.show(text: "Please wait ..." )
        //        self.view.addSubview(progressHUD)
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCRLEAD_PENDING_URL_1", tables: tables, response_code: MESSAGE_INTERNET_LEAD_SUMMARY_URL, vc : self)
        
        
        //End of call to service
    
    
    }




    func displayData(){
        if (cbohelp.searchChemist(chem_id: chm_id).contains(chm_id)) {
            customer_list=cbohelp.getCallDetail(table: "chemisttemp",look_for_id: chm_id,show_edit_delete: "0");

            if (customer_list["sample_name"]![0] != "") {
                sample_name = customer_list["sample_name"]![0]
                sample_sample = customer_list["sample_qty"]![0]
                sample_pob = customer_list["sample_pob"]![0]

                name = customer_list["sample_id"]![0]
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

            if (customer_list["gift_name"]![0] != "") {

                gift_name = customer_list["gift_name"]![0]
                gift_qty = customer_list["gift_qty"]![0]

                name4 = gift_qty
                name3 = customer_list["gift_id"]![0]

                let gift_name1 = gift_name.components(separatedBy: ",");
                let gift_qty1 = gift_qty.components(separatedBy: ",");
                ShowDrSampleGift(myStackView: GiftView!,gift_name: gift_name1, gift_qty: gift_qty1,title_name: "Gift",title_qty: "Qty.");
            }else{
                gift_name = ""
                gift_qty = ""
                RemoveAllviewsinProduct(myStackView: GiftView)
            }

            addCustomer.setText(text: "Update Customer");
        }else{

            sample_name="";
            sample_pob="";
            sample_sample="";

            RemoveAllviewsinProduct(myStackView: myStackView)
            RemoveAllviewsinProduct(myStackView: GiftView)

            addCustomer.setText(text: "Add Customer");
        }

        sample_name_previous=sample_name;
        sample_pob_previous=sample_pob;
        sample_sample_previous=sample_sample;

        gift_name_previous = gift_name;
        gift_qty_previous = gift_qty;
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

    func ShowDrSampleGift(myStackView : UIView, gift_name : [String],  gift_qty : [String],title_name : String,title_qty : String){
        
        RemoveAllviewsinProduct(myStackView: myStackView)

        var heightConstraint : NSLayoutConstraint!
        // var stackViewHeightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!

        var previousStackView : UIStackView!


        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myStackView.addSubview(myLabel)
        myLabel.text =  title_name //"Gift"
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
        myLabel2.text = title_qty // "Qty."



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
            if(gift_qty.count>i){
                myLabel2.text =  gift_qty[i]
            }else{
                myLabel2.text =  ""
            }



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

extension CustomerCall : ImagePickerDelegate{
    func getImage(image: UIImage) {
        AttachmentImageView.isHidden = false
        AttachmentImageView.image = image
        
        // filename
        filename = "\(Custom_Variables_And_Method.PA_ID)_\(Custom_Variables_And_Method.DCR_ID)_\(chm_id)_\(customVariablesAndMethod.get_currentTimeStamp()).jpg"
    }
    
    
    @objc func openGallery(){
        objImagePicker = ImagePicker(imagePickerController: imagePickerController, vc: self,alertControllerStyle: .alert,title: "Select Photo" )
        imagePickerController.delegate = objImagePicker
        objImagePicker.delegate = self
        
        objImagePicker.createFolderinApplicationDirectory(FOLDER_NAME: objImagePicker.albumName)
    }
    
}
