//
//  ChemistR_Call.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class ChemistR_Call: CustomUIViewController, IChemist_R, ParantSummaryAdaptorDalegate {
  
    
    func onEdit(id: String, name: String) {
        print("onEdit")
    }
    
    func onDelete(id: String, name: String) {
        
        selected_che_id = id
        viewModel.DeleteChemist(id: id, name: name)
    }
    
    func getChild(groupPosition : Int , childname : String) -> [String : [String]]{
               return summary_list[groupPosition][childname]!
    }
    
    func updateCollapseHeader(collapse: [Bool], header: [String], list: [[String : [String : [String]]]]) {
       
        summary_list = list
        presenter = ParantSummaryAdaptor(tableView:reminderSummaryTableView, vc: self , summaryData : list , headers : header, isCollaps: collapse  )
        reminderSummaryTableView.dataSource = presenter
        reminderSummaryTableView.delegate = presenter
        presenter.delegate = self
        
    }
    
    
    func locationEnabled(enabled: Bool) {
        loc_layout.isHidden = enabled
    }
    
    
    func setTitle(text: String) {
        
        myTopView.setText(title: text)
    }
    
    func setChemist(text: String) {
        che_name.text = text
    }
    
    func remarkEnabled(enabled: Bool) {
        
        remark.isHidden = enabled
    }
    
    @objc func On_Summary_TabClicked() {
        
        callButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        reminderSummaryview.isHidden = false
        reminderCallView.isHidden = true
        
    }
    
    @objc func On_Call_TabClicked() {
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        reminderCallView.isHidden  = false
        reminderSummaryview.isHidden = true
    }
    
    @objc func addChemist() {
        
        if (Custom_Variables_And_Method.GLOBAL_LATLON == "0.0,0.0") {
            
            Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
        }
        
        var docrc = [String]();
        if(loc.getText() == "") {
            loc.setText(text: "UnKnown Location");
        }
        
        if (doc_name == ""){
            
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Chemist First...");
            
        } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "REMARK_WW_MANDATORY", defaultValue: "").contains("R") &&  remark.getText() == "") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please enter remark");
            
        } else {
            
            docrc = cbohelp.getChemRc();
            if(docrc.contains(che_id)) {
                customVariablesAndMethod.msgBox(vc: context,msg: doc_name + " Allready added ");
                
            } else {
                
                setAddressToUI();
                //submitDoctorRcInLocal();
               
                viewModel.addChemistRcInLocal(che_id: che_id, address: call_latLong+"!^"+loc.getText(), call_latLong: call_latLong, remark: remark.getText(), ref_latLong: ref_latLong)
                
                customVariablesAndMethod.msgBox(vc: context,msg: doc_name + "Added Successfully", completion: {_ in
                
                self.multiCallService.SendFCMOnCall(vc: self, response_code: self.MESSAGE_INTERNET_SEND_FCM, progressHUD: self.progressHUD, DocType: "C",Id: self.che_id,latlong: "")})
                
            }
            
        }
        
    }
    
    @objc func onChemistDropDown() {
        
        docList = viewModel.getChemistlist(context: context)
    }
    
    @objc func pressedBack(){
        
        myTopView.CloseCurruntVC(vc: self)
       
    }
    
    func setAddressToUI() {
        loc.setText(text: Custom_Variables_And_Method.GLOBAL_LATLON)
    }
    
    @IBOutlet weak var reminderSummaryTableView: UITableView!
       
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var callButton: CustomHalfRoundButton!
       
    @IBOutlet weak var slelectedTabBarButtom: UIView!

    @IBOutlet weak var summaryStackView: UIStackView!
       
    @IBOutlet weak var reminderCallView: CustomBoarder!
       
    @IBOutlet weak var reminderSummaryview: CustomBoarder!
    
    @IBOutlet weak var loc: CustomDisableTextView!
    @IBOutlet weak var che_name: UILabel!
    @IBOutlet weak var che_btn: UIButton!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var pressedAddChemist: CustomeUIButton!
    @IBOutlet weak var remark: CustomTextView!
    @IBOutlet weak var loc_layout: UIStackView!
       
    @IBOutlet weak var summaryViewHeight: NSLayoutConstraint!
            
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    
    var viewModel : VmChemist_R!
    
    let CALL_DILOG = 5, SUMMARY_DILOG = 7,REPORT_DIALOG = 9,MESSAGE_INTERNET_SEND_FCM = 10,MESSAGE_INTERNET_DRCHEMDELETE_MOBILE = 11
    
    var PA_ID = 0;
    var che_id="",doc_name="",che_name_reg="",che_id_reg = "",che_id_index = "",ch_name = "";
    var docList = [SpinnerModel]();
    
    var context : CustomUIViewController!
    var progressHUD : ProgressHUD!
    var multiCallService = Multi_Class_Service_call()
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    var ref_latLong = "", call_latLong = "";
    var selected_che_id = "-1"
    
    var presenter : ParantSummaryAdaptor!
    var summary_list = [[String : [String : [String]]]]()
    var headers = [String]()
    var isCollaps = [Bool]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        context = self
        
        progressHUD  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        
        viewModel = VmChemist_R(del: self, context: context)
        reminderCallView.isHidden = false
        reminderSummaryview.isHidden = true
        summaryBackButton.isHidden = true
        
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        locationEnabled(enabled: Custom_Variables_And_Method.location_required == "Y" ? false : true)
        
        remarkEnabled(enabled: customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DR_REMARKYN",defaultValue: "") == "Y" ? false : true)
        
        remark.setHint(placeholder: "Enter Remark")
        
        if ( VCIntent["title"] != nil) {
           
            setTitle(text: VCIntent["title"]!)
        }
        
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        
        
        che_btn.addTarget(self, action: #selector(onChemistDropDown), for: .touchUpInside )
        pressedAddChemist.addTarget(self, action: #selector(addChemist), for: .touchUpInside )
               
        callButton.addTarget(self, action: #selector(On_Call_TabClicked), for: .touchUpInside)
        summaryButton.addTarget(self, action: #selector(On_Summary_TabClicked), for: .touchUpInside)
                    
        viewModel.genrateSummary()
        
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
                che_id = docList[Int(inderData["Selected_Index"]!)!].getId()
                doc_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
                //che_name.text = doc_name
                setChemist(text: doc_name)
                
                
                ref_latLong =  docList[Int(inderData["Selected_Index"]!)!].getREF_LAT_LONG()
                call_latLong = inderData["latLong"]!
                
                //pressedAddDoctor.setText(text: "Update Chemist")
                break
                
            case MESSAGE_INTERNET_DRCHEMDELETE_MOBILE:
                progressHUD.dismiss()
                //self.cbohelp.delete_DoctorRemainder_from_local_all(dr_id: "self.selected_dr_id")
                self.cbohelp.delete_ChemistRemainder_from_local_all(chem_id: self.selected_che_id)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
