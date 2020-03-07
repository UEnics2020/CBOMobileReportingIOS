//
//  CBOContentViewController.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 06/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import SQLite
import CoreLocation
class DcrmenuInGrid: CustomUIViewController, MenuGridAdaptorDelegate {
    
    let objCustomCollectionViewLayout = CustomCollectionViewLayout()
    @IBOutlet weak var DCRcollectionView: UICollectionView!
    
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var DRC_Menu = [[String : String]]()
    var progressHUD : ProgressHUD!
    var context : CustomUIViewController!
    
    
    
    private let MESSAGE_INTERNET_DCR_PLAN = 1;
    private let MESSAGE_INTERNET_IS_CALL_UNLOCKED = 2;
//    View v;
    var fmcg : String!
//    GridView gridView;
//    NetworkUtil networkUtil;
    
//    Animation anim;
    var GPS_STATUS_IS : String!
//    MyCustomMethod myCustomMethod;
//    ServiceHandler serviceHandler;
    var PA_ID : Int!
    private let REQUEST_CHECK_SETTINGS = 1000
//    GoogleApiClient googleApiClient;
//    LocationRequest locationRequest;
       var tpPendingDate = ""
    var empIs : String!
    var marQueeeText : String!
    var DCR_ID,Doctor_id_for_POB: String!
    var Doctor_Name_for_POB : String!
    
    var listOfAllTab: [String]!
    var count : [Int]!
    var getKeyList = [String]()
    var keyValue : [[String : String ]]!
//    public ProgressDialog progress1;
    var CheckType : String!
    //Boolean FlagCancelled=true;
    
    var Appraisal_list :  [[String:  String]]!
    var mandatory_pending_exp_head : [[String : String]]!
     var count_Calls = [Int]()
    var adpator : MenuGridAdaptor!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /*
         
         progressHUD = ProgressHUD(vc : self)
                        context = self
                        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()

                        //networkUtil = new NetworkUtil(getActivity());
                //        anim = AnimationUtils.loadAnimation(getActivity(), R.anim.anim_alfa_2016);
                //        myCustomMethod = new MyCustomMethod(getActivity())
                        
                        
                        fmcg = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self,key : "fmcg_value", defaultValue : "N");
                       
                        
                        
                        //MARK:- check weather defauyl value is Y or N
                        GPS_STATUS_IS = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self,key  : "gps_needed" ,defaultValue:  "Y");
                        
                      
                        
                        addAllTab();
                //        DCRcollectionView.delegate = self
                //        DCRcollectionView.dataSource = self;
                //        DCRcollectionView.register(UINib(nibName: "CBOContantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
                //        DCRcollectionView.collectionViewLayout = objCustomCollectionViewLayout.MycollectionViewCellSpaceing(collectionView : DCRcollectionView)
                        
                        adpator = MenuGridAdaptor(collectionViewGrid: DCRcollectionView, vc: self, menu: DRC_Menu ,count_Calls: count_Calls)
                        
                        adpator.delegate = self
                        
                        // Do any additional setup after loading the view.
                        
                        DCRcollectionView.delegate = adpator;
                        
                        DCRcollectionView.dataSource = adpator;
         
         */
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*addAllTab();
        
        DCRcollectionView.reloadData()
     
        DCR_ID = Custom_Variables_And_Method.DCR_ID;
        PA_ID = Custom_Variables_And_Method.getIntValue(value: cbohelp.getPaid());*/
        
        
         progressHUD = ProgressHUD(vc : self)
                context = self
                customVariablesAndMethod = Custom_Variables_And_Method.getInstance()

                //networkUtil = new NetworkUtil(getActivity());
        //        anim = AnimationUtils.loadAnimation(getActivity(), R.anim.anim_alfa_2016);
        //        myCustomMethod = new MyCustomMethod(getActivity())
                
                
                fmcg = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self,key : "fmcg_value", defaultValue : "N");
               
                
                
                //MARK:- check weather defauyl value is Y or N
                GPS_STATUS_IS = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc : self,key  : "gps_needed" ,defaultValue:  "Y");
                
              
                
                addAllTab();
        //        DCRcollectionView.delegate = self
        //        DCRcollectionView.dataSource = self;
        //        DCRcollectionView.register(UINib(nibName: "CBOContantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        //        DCRcollectionView.collectionViewLayout = objCustomCollectionViewLayout.MycollectionViewCellSpaceing(collectionView : DCRcollectionView)
                
                adpator = MenuGridAdaptor(collectionViewGrid: DCRcollectionView, vc: self, menu: DRC_Menu ,count_Calls: count_Calls)
                
                adpator.delegate = self
                
                // Do any additional setup after loading the view.
                
                DCRcollectionView.delegate = adpator;
                
                DCRcollectionView.dataSource = adpator;
        
        
        DCR_ID = Custom_Variables_And_Method.DCR_ID;
        PA_ID = Custom_Variables_And_Method.getIntValue(value: cbohelp.getPaid());
        
    }

//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return DRC_Menu.count
//    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CBOContantCollectionViewCell {
//
//        cell1.myImageView.image = setImage(menu_code:  DRC_Menu[indexPath.row]["menu_code"]! )
//        cell1.myNotificationBackground.layer.cornerRadius = cell1.myNotificationBackground.frame.height / 2
//        if count_Calls[indexPath.row] ==  0{
//            cell1.myNotificationBackground.isHidden = true
//            cell1.myNotificationCounter.text = ""
//        }else {
//            cell1.myNotificationBackground.isHidden = false
//            cell1.myNotificationCounter.text = "\(count_Calls[indexPath.row])"
//        }
//        cell1.myLabel.text = DRC_Menu[indexPath.row]["menu_name"]
//        return cell1
//        }
//    return UICollectionViewCell()
//    }



//    func setImage(menu_code : String) -> UIImage{
//        var image : UIImage!
//
//
//        if (menu_code == ("D_DP")) {
//
//            image = UIImage(named: "dcr_reports_white.png")
//
//        } else if (menu_code == ("D_RCCALL")) {
//            image = UIImage(named: "reminder_card_white.png")
//        } else if (menu_code == ("D_DRCALL")) {
//            image = UIImage(named: "doctor_call_white.png")
//        }
//        else if (menu_code == ("D_DR_RX") || menu_code == ("D_RX_GEN") || menu_code == ("D_RX_GEN_NA")) {
//            image = UIImage(named: "add_doctor.png")
//        }
//        else if (menu_code == ("D_DRSAM")) {
//            image = UIImage(named: "doctor_sameple_white.png")
//        } else if (menu_code == ("D_DRSAM")) {
//            image = UIImage(named: "chemist_call_white.png")
//        } else if (menu_code == ("D_CHEMCALL")) {
//            image = UIImage(named: "chemist_call_white.png")
//        } else if (menu_code == ("D_RETCALL")) {
//            image = UIImage(named: "chemist_call_white.png")
//        } else if (menu_code == ("D_STK_CALL")) {
//            image = UIImage(named: "stockist_call_white.png")
//        } else if (menu_code == ("D_NLC_CALL")) {
//            image = UIImage(named: "non_listedcall.png")
//        }else if (menu_code == ("D_FAR")) {
//            image = UIImage(named: "farmer_meeting_white.png")
//        } else if (menu_code == ("D_AP")) {
//            image = UIImage(named: "appraisal.png")
//        } else if (menu_code == ("D_EXP")) {
//            image = UIImage(named: "expense_white.png")
//        } else if (menu_code == ("D_SUM")) {
//            image = UIImage(named: "summary_white.png")
//        } else if (menu_code == ("D_FINAL")) {
//            image = UIImage(named: "final_submit_white.png")
//        }else{
//            image = UIImage(named: "reset_day_plan_white.png")
//        }
//
//        return image!
//    }

//
//    //MARK:- function to access the cell from collection view
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        onClickListener(menu_code: DRC_Menu[indexPath.row]["menu_code"]! , name : DRC_Menu[indexPath.row]["menu_name"]!)
//    }

    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: "DCR", menu_code: menu_code)
        if (!url.isEmpty){
            
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
            
        } else {
            let expence_status = getmydata()[2]
            
            switch menu_code{
                
            case "D_DP":
                // setLetLong(nameOnClick);
                onClickDayPlanning()
//                if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"ASKUPDATEYN","N").equals("Y")) {
//                    new GetVersionCode(getActivity()).execute();
//                }
                
                break
                
            case "D_DRCALL":
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                   
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                
                
                } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_code", defaultValue: "W") == "CSC"){
                    
                    let working_type=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_head",defaultValue: "");
                    customVariablesAndMethod.getAlert(vc: self,title: "Call Not Allowed",msg: "You have planed your DCR as\n \"\(working_type)\" \n you can't any Doctor..");
                    
                    
                } else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else {
                   // setLetLong(nameOnClick);
                    
                    
                   /* if (Custom_Variables_And_Method.getInstance().isVisualAddDownloadRequired(context: self)) {
                                                              
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "VisualAidDownload") as! VisualAidDownload
                                                                      
                        visualAidDownloadVC.VCIntent["title"] = "VisualAd Download"
                        visualAidDownloadVC.VCIntent["V_DOWNLOAD"] = "Y"
                                                                      
                        self.present(visualAidDownloadVC, animated: true, completion: nil)
                        
                    } else {*/
                        onClickDrCall(name: name);
                    //}
                    
                    
                }
                break
                
            case "D_RCCALL" :
                
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_code", defaultValue: "W") == "CSC"){
                    let working_type=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_head",defaultValue: "");
                    customVariablesAndMethod.getAlert(vc: self,title: "Call Not Allowed",msg: "You have planed your DCR as\n \"\(working_type)\" \n you can't any Doctor..");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else {
                    // setLetLong(nameOnClick);
                    onClickReminder(name: name);
                }
               
                break
                
            case "D_CHEM_RCCALL" :
                
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                                   customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_code", defaultValue: "W") == "CSC"){
                                   let working_type=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_head",defaultValue: "");
                                   customVariablesAndMethod.getAlert(vc: self,title: "Call Not Allowed",msg: "You have planed your DCR as\n \"\(working_type)\" \n you can't any Doctor..");
                } else {
                    // setLetLong(nameOnClick);
                    onClickChemistReminder(name: name);
                }
                         
             break
                
            case "D_RX_GEN","D_RX_GEN_NA":
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else{
                    onClickRxGen(title: name)
                }
                break
            case "D_CHEMCALL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else{
                    onClickChemistCall(title: name)
                }
                break
            case "D_CUST_CALL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else {
                    // setLetLong(nameOnClick);
                    onClickCustomerCall(title: name)
                }
                break
            case "D_RETCALL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else{
                    onClickChemistCall(title: name)
                }
                break
            case "D_STK_CALL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else{
                    onClickStockistCall(title: name)
                }
                
                break
            case "D_DRSAM" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_code", defaultValue: "W") == "CSC"){
                    let working_type=customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "working_head",defaultValue: "");
                    customVariablesAndMethod.getAlert(vc: self,title: "Call Not Allowed",msg: "You have planed your DCR as\n \"\(working_type)\" \n you can't any Doctor..");
                }else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Doctor_Sample") as!
                    Doctor_Sample
                    vc.VCIntent["title"] = name
                    vc.VCIntent["Back_allowed"] = "Y"
                    vc.VCIntent["id"] = ""
                    self.present(vc, animated: true, completion: nil)
                }
                
                break
                
                
                
            case "D_DAIRY" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else {
                    // setLetLong(nameOnClick);
                    onClickDairyCall(name: name, docType: "D")
                }
                
                break
        
            case "D_POULTRY" :
                
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                }else if(!(expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") &&
                    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                    customVariablesAndMethod.msgBox(vc: context,msg: "Now, Not allowed any call because you  have Submitted your Expense...");
                } else {
                    // setLetLong(nameOnClick);
                    onClickDairyCall(name: name, docType: "P")
                }
                
                break
                
                
            case "D_NLC_CALL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "NonListedCall") as!
                    NonListedCall
                    
                    vc.VCIntent["title"] = name
                    //                vc.VCIntent["form_type"] = "sum"
                    //                vc.VCIntent["Back_allowed"] = "Y"
                    print("pressed summery option")
                    self.present(vc, animated: true, completion: nil)
                }
                break
//            case "D_FAR" :
////                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
////                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
////                } else{
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc = storyboard.instantiateViewController(withIdentifier: "Farmer_registration_form") as!
//                    Farmer_registration_form
//
//                    vc.VCIntent["title"] = name
//                    self.present(vc, animated: true, completion: nil)
////                }
//
//                break
                
            case "D_EXP" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else if (customVariablesAndMethod.internetConneted(context: self)){
                    if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                        var chemist_status = "1"
                        var stockist_status = "1"
                        //var expence_status = "1"
                        
                        
                        var drInLocal = [String]();
                        
                           let Hide_status = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "fmcg_value", defaultValue: "N")
                            
                            drInLocal = cbohelp.tempDrListForFinalSubmit();
                            var dr_call_size = drInLocal.count
                            let working_code = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code", defaultValue: "W")
                            
                           if ((working_code == "OCC" || working_code == "OSC" || working_code == "CSC" || (working_code.contains("NR") && working_code.contains("W"))) || Hide_status.uppercased() == "Y"){

                                dr_call_size = 1;
                            }
                            
                        
                        if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CALLNA_AFTEREXPSUBMIT",defaultValue: "") == "Y"){
                            chemist_status = getmydata()[0]
                            stockist_status = getmydata()[1]
                            //expence_status = getmydata()[2]
                            dr_call_size = 1;
                        }
                          
                            if (dr_call_size <= 0) {
                                customVariablesAndMethod.msgBox(vc: context,msg: "Please Visit atleast One Doctor");
                            } else if (chemist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CHEMIST_NOT_VISITED",defaultValue: "") != "Y") {
                                customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Not Visited In Chemist Call");
                            } else if (stockist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "STOCKIST_NOT_VISITED",defaultValue: "") != "Y") {
                                customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Not Visited In Stockist Call");
                            }else{
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "Expenses_NotWorkingVC") as! Expenses_NotWorkingVC
                                                        
                                // let vc = storyboard.instantiateViewController(withIdentifier: "ExpenseNew") as! ExpenseNew
                                   vc.VCIntent["title"] = name
                                   vc.VCIntent["form_type"] = "exp"
                                   vc.VCIntent["Back_allowed"] = "Y"
                                   self.present(vc, animated: true, completion: nil)
                            }
                    }
                }
                  break
                 //summary
            case "D_SUM" :
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DCRSummery") as!
                DCRSummery
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                vc.VCIntent["title"] = name
                vc.VCIntent["form_type"] = "sum"
                vc.VCIntent["Back_allowed"] = "Y"
                print("pressed summery option")
                self.present(vc, animated: false, completion: nil)
                break
                
            case "D_FAR" :
                
                
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "CAMViewController") as! CAMViewController
                                    
                           
                            vc.VCIntent["title"] = name
                            //vc.VCIntent["dr_id"] = self.Doctor_id_for_POB
                    //      vc.VCIntent["form_type"] = "sum"
                    //      vc.VCIntent["Back_allowed"] = "Y"
                                    
                            self.present(vc, animated: true, completion: nil)
                    
                }
                
                
                break
                
                
                /*if (DCR_ID.equals("0") || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context, "dcr_date_real").equals("")) {
                    customVariablesAndMethod.msgBox(context, "Please open your DCR Days first....");
                } else if (!customVariablesAndMethod.checkIfCallLocationValid(context, false, SkipLocationVarification)) {
                    //customVariablesAndMethod.msgBox(context,"Verifing Your Location");
                    LocalBroadcastManager.getInstance(context).registerReceiver(mLocationUpdated,
                            new IntentFilter(Const.INTENT_FILTER_LOCATION_UPDATE_AVAILABLE));
                } else {
                    onClickFarmerRegistor();
                }
                break;*/
          
                
            case "D_FINAL" :
                if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                } else {
                
                    if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "MISSED_CALL_OPTION", defaultValue: "N") != ("D") || checkForDoctorPOB()) {/* && ( customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DRCALLPRODUCT_MANDATORYYN", defaultValue: "N") != ("Y") || checkForDoctorPOBLeft() )) {*/
                        onClickFinalSubmit();
                    } else { if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "MISSED_CALL_OPTION", defaultValue: "N") == ("D")){
                            
                            AppAlert.getInstance().Alert(vc: self,title: "Pending!!!",massege: "Call to some Planed Doctor is Pending...") {
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DoctorCallViewController")  as! DoctorCallViewController
                                myviewcontroller.VCIntent["title"] = "Planed Doctor Call pending..."
                                myviewcontroller.VCIntent["id"] = self.Doctor_id_for_POB
                                myviewcontroller.VCIntent["remark"] = "Call Pending"
                                self.present(myviewcontroller, animated: true, completion:  nil)
                            };
                            
                    } else {
                        
                        var drInLocal = [String]();
                        drInLocal = cbohelp.tempDrListForFinalSubmit();
                        let dr_call_size=drInLocal.count
                        
                        if (dr_call_size <= 0) {
                            customVariablesAndMethod.msgBox(vc: context,msg: "Please Visit atleast One Doctor");
                        
                        } else {
                            print("Doctor_id_for_POB ",self.Doctor_id_for_POB)
                            AppAlert.getInstance().Alert(vc: self,title: "Product Detailed!!!",massege: "First you have to complete product detailing of Doctors...") {
                                
                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let vc = storyboard.instantiateViewController(withIdentifier: "Doctor_Sample") as! Doctor_Sample
                                  vc.VCIntent["title"] = "Dr. Sample...."
                                  vc.VCIntent["Back_allowed"] = "N"
                                  vc.VCIntent["dr_id"] = self.Doctor_id_for_POB
                                 vc.VCIntent["dr_name"] = self.Doctor_Name_for_POB
                                 self.present(vc, animated: true, completion: nil)
                                
                             };
                            
                        }
                            
                    }
                        
                    }
            }
                break
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
          
        }

    }
    
    private func onClickDairyCall(name: String , docType : String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DairyCall") as! DairyCall
        
        vc.VCIntent["title"] = name
        vc.VCIntent["docType"] = docType
        vc.VCIntent["Back_allowed"] = "Y"
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
        
        
    func checkForDoctorPOB() -> Bool{
            if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code", defaultValue: "W") == ("CSC")){
                return true;
            }
            var drlist = [String]();
            var drlistName = [String]();
            
            do{
                let statement = try cbohelp.getDoctorListLocal(plan_type: "1",caltype: nil);
                while let c = statement.next(){
                    try drlist.append("\(String(describing: c[cbohelp.getColumnIndex(statement :statement ,Coloumn_Name: "dr_id")]!))");
                     try drlistName.append("\(String(describing: c[cbohelp.getColumnIndex(statement :statement ,Coloumn_Name: "dr_name")]!))");
                }
                let Doctor_list = cbohelp.getDoctor();
                for i in 0..<drlist.count {
                    if !Doctor_list.contains(drlist[i]) {
                        Doctor_id_for_POB = drlist[i]
                        Doctor_Name_for_POB = drlistName[i]
                        return false;
                    }
                }
                
                
            }catch{
                print(error)
            }
            
            return true;
        }
       
    func checkForDoctorPOBLeft() -> Bool{
             
          let doctor_list = cbohelp.getCallDetail(table: "tempdr",look_for_id: "",show_edit_delete: "0");
                      
        if  doctor_list["id"]![0]  != "-99"{
            for i in 0..<doctor_list["id"]!.count {
            //for i in 0 ..< doctor_list["id"]!.count {
                if (doctor_list["sample_name"]![0] != "") {
                    Doctor_id_for_POB = doctor_list["id"]![i]
                    Doctor_Name_for_POB = doctor_list["name"]![i]
                    return true;
                }
            }
        }
        return false;
    }
    
    func getmydata() -> [String] {
        var raw = [String]();
        var chm = ""
        var stk = ""
        var exp = ""
        do {
            var statement = try cbohelp.getFinalSubmit();
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
    ///////////////////onClick FinalSubmit////////////
    func onClickFinalSubmit() {

        var farmer_Visited = [String]();
        farmer_Visited = cbohelp.collect_all_data();
        var mWork_val = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_head",defaultValue: "W")
    
        Appraisal_list=cbohelp.get_Appraisal(flag: "0",pa_id: "");
        mandatory_pending_exp_head = cbohelp.get_mandatory_pending_exp_head();
    
        let chemist_status = getmydata()[0]
        let stockist_status = getmydata()[1]
        let expence_status = getmydata()[2]
        var drInLocal = [String]()
        drInLocal = cbohelp.tempDrListForFinalSubmit()
    
        if (!customVariablesAndMethod.drChemEntryAllowed(context: context)) {
    
            if (DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....")
            } else if (drInLocal.count <= 0 && (cbohelp.getCountphdairy_dcr(DOC_TYPE: "D") == 0 && (cbohelp.getCountphdairy_dcr(DOC_TYPE: "P") == 0) && chemist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CHEMIST_NOT_VISITED",defaultValue: "") != "Y" && stockist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "STOCKIST_NOT_VISITED",defaultValue: "") != "Y")) {
    
                customVariablesAndMethod.getAlert(vc: context,title: "No Calls found !!!",msg: "Your DCR has-been Locked, please reset your DCR from Utilites")
                
            } else if (expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") {
    
                customVariablesAndMethod.msgBox(vc: context,msg: "Please submit Your Expense First... ");
    
            } else if (!customVariablesAndMethod.internetConneted(context: self,ShowAlert: false)){
                customVariablesAndMethod.Connect_to_Internet_Msg(context: context)
    
            } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "APPRAISALMANDATORY",defaultValue: "") == "Y" && Appraisal_list.count != 0) {
    
            var pending_list="";
            for i in 0 ..< Appraisal_list.count {
                pending_list += Appraisal_list[0]["PA_NAME"]!+"\n";
            }
                customVariablesAndMethod.getAlert(vc: context,title: "Appraisal Pending",msg: pending_list)
    
            }else if (mandatory_pending_exp_head.count != 0) {
            
            var pending_list="";
             for i in 0 ..< mandatory_pending_exp_head.count {
                pending_list += mandatory_pending_exp_head[0]["PA_NAME"]!+"\n"
            }
                customVariablesAndMethod.getAlert(vc: context,title: "Expenses Pending",msg: pending_list)
            
            } else {
                
                if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCRSUMMARYONFINALSUBMIT", defaultValue: "N") == "Y") {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DCRSummery") as!
                    DCRSummery
                    vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    vc.VCIntent["title"] = "Summary"
                    vc.VCIntent["form_type"] = "sum"
                    vc.VCIntent["Back_allowed"] = "N"
                    vc.VCIntent["ShowAsPopUp"] = "Y"
                    vc.VCIntent["AllowFinalSubmit"] = "Y"
                    self.present(vc, animated: false, completion: nil)
                    
                } else {
                    openFilnaSubmit()
                }
                
                
            }
    
        } else if ((mWork_val.lowercased() == ("working and group metting of dairy farmer")) && (DCR_ID != "0") && (farmer_Visited.count == 0)) {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Visit atleast One Farmer \n Just Go back Main Menu in Transtion and Add...")
    
        } else if ((mWork_val.lowercased() == ("group metting of dairy farmer")) && (DCR_ID == ("0")) && (farmer_Visited.count == 0)) {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Visit atleast One Farmer \n Just Go back Main Menu in Transtion and Add...");
    
        } else if (customVariablesAndMethod.internetConneted(context: self) && customVariablesAndMethod.IsGPS_ON(context: self)) {
            result4FinalSubmit();
        }

    }
    
  
    public func PreFinalSubmit() {
        IfDrConditionFulfiled(listener: IfDrConditionFulfiledlistener(parent: context as! DcrmenuInGrid))
    }
    
    //// check the condition for all the menus in dcr
    
    
    class IfDrConditionFulfiledlistener : Response {
        var parent : DcrmenuInGrid!
        init(parent : DcrmenuInGrid) {
            self.parent = parent
        }
        func onSuccess(message: [String : AnyObject]) {
            
        }
        
        func onError(title: String, description: String) {
            AppAlert.getInstance()
                .setNagativeTxt(nagativeTxt: "Cancel")
                .setPositiveTxt(positiveTxt: "Check")
                .DecisionAlert(vc: parent,
                               title: title,
                               massege: description,
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var description : String!
                                    var parent : DcrmenuInGrid!
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        if (description != ("Please make atleast One Call....")) {
                                            //parent.OnGridItemClick("D_DRCALL", true);
                                        }
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : DcrmenuInGrid,description : String) {
                                        self.parent = parent
                                        self.description = description
                                    }
                                }
                                return anonymous(parent: self.parent,description : description)
                })
            
        }
    }
    
    private func IfDrConditionFulfiled(listener :  Response) {
    
    let Hide_status = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "fmcg_value", defaultValue: "N")
    
//    ArrayList<String>  drInLocal = cboDbHelper.tempDrListForFinalSubmit();
//    int dr_call_size = drInLocal.size();
//    if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code", "W").equals("OCC")||
//    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code","W").equals("OSC")||
//    customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code","W").equals("CSC")||
//    (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code","W").contains("NR")
//    && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code","W").contains("W"))){
//    dr_call_size=1;
//    }
//
//    // valid for only  working_code that contains NR i.e its for only new concept of working type
//    // new concept of working type is if any validation for final submit is to be skiped for a menu then
//    //workingcode = NR
//    //
//    if (drInLocal.size() <= 0 && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"working_code","W").contains("NR")  &&
//    (cboDbHelper.getmenu_count("chemisttemp") == 0 && (cboDbHelper.getmenu_count("phdcrstk") == 0))
//    && (cboDbHelper.getCountphdairy_dcr("D") == 0 && (cboDbHelper.getCountphdairy_dcr("P") == 0))) {
//    if (listener != null) {
//    listener.onError("No Calls found !!!", "Please make atleast One Call....");
//    }
//
//    }else if (dr_call_size <= 0 &&
//    (Hide_status.equalsIgnoreCase("N") &&
//    !customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(context,"Doctor_NOT_REQUIRED").equals("Y"))) {
//    if (listener != null) {
//    listener.onError("No Doctor Called!!!!", "Please make atleast One Doctor Call.... ");
//    }
//    }else{
//    if (listener != null){
//    listener.onSuccess(null);
//    }
//    }
    }
    
    func result4FinalSubmit() {
        let chemist_status = getmydata()[0]
        let stockist_status = getmydata()[1]
        let expence_status = getmydata()[2]
        var drInLocal = [String]();
        
        
        let farmer_Visited = cbohelp.collect_all_data();
        let Hide_status = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "fmcg_value", defaultValue: "N")
        
        drInLocal = cbohelp.tempDrListForFinalSubmit();
        var dr_call_size=drInLocal.count
        let working_code = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "working_code", defaultValue: "W")
        
       if ((working_code == "OCC" || working_code == "OSC" || working_code == "CSC" || (working_code.contains("NR") && working_code.contains("W"))) || Hide_status.uppercased() == "Y"){

            dr_call_size = 1;
        }
        
      
    
        if (dr_call_size <= 0) {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Visit atleast One Doctor");
        } else if (chemist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "CHEMIST_NOT_VISITED",defaultValue: "") != "Y") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Not Visited In Chemist Call");
        } else if (stockist_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "STOCKIST_NOT_VISITED",defaultValue: "") != "Y") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please Select Not Visited In Stockist Call");
        } else if (farmer_Visited.count == 0 && (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:context,key: "FARMERREGISTERYN", defaultValue: "") == ("Y"))) {
            do {
                try customVariablesAndMethod.msgBox(vc: self, msg: "Please Visit atleast One\( cbohelp.getMenuNew(menu: "DCR", code: "D_FAR"))")
            }
            catch {  print(error) }
        }
        else if (expence_status == "" && customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "Expense_NOT_REQUIRED",defaultValue: "") != "Y") {
            customVariablesAndMethod.msgBox(vc: context,msg: "Please submit Your Expense First... ");
        }
        else if (!customVariablesAndMethod.internetConneted(context: self,ShowAlert: false)){
            customVariablesAndMethod.Connect_to_Internet_Msg(context: context);
            
        } else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "APPRAISALMANDATORY",defaultValue: "") == "Y" && Appraisal_list.count != 0) {
            
            var pending_list="";
            for i in 0 ..< Appraisal_list.count {
                pending_list += Appraisal_list[0]["PA_NAME"]!+"\n";
            }
            customVariablesAndMethod.getAlert(vc: context,title: "Appraisal Pending",msg: pending_list);
            
        }else if (mandatory_pending_exp_head.count != 0) {
            
            var pending_list="";
            for i in 0 ..< mandatory_pending_exp_head.count {
                pending_list += mandatory_pending_exp_head[0]["PA_NAME"]!+"\n";
            }
            customVariablesAndMethod.getAlert(vc: context,title: "Expenses Pending",msg: pending_list);
            
        }else if(IfRxConditionFulfiled()){
            if(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCRSUMMARYONFINALSUBMIT", defaultValue: "N") == "Y") {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DCRSummery") as!
                DCRSummery
                vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                vc.VCIntent["title"] = "Summary"
                vc.VCIntent["form_type"] = "sum"
                vc.VCIntent["Back_allowed"] = "N"
                
                self.present(vc, animated: false, completion: nil)
                
            } else {
                openFilnaSubmit()
            }
        }else{
            do {
                try customVariablesAndMethod.msgBox(vc: self, msg: "Please Visit \(customVariablesAndMethod.getTaniviaTrakerMenuName(context: self))")
                }catch{ print(error) }
        }


    }
    
    private func IfRxConditionFulfiled() -> Bool{

        do{
        if (IsTeniviaMenuAvilable() && Custom_Variables_And_Method.pub_desig_id == "1" ) {

        /// 0 - not mendetory
        /// 1 - all mendetory
        /// 2 - only those where RXGENYN = 1 are mendetory

            var RxValidateCondition = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DR_RXGEN_VALIDATE",defaultValue: "0");
            var NoRxCalls = cbohelp.getmenu_count(table: "Tenivia_traker");
        var NoRxCallsReqd = 0;//cboDbHelper.getDoctorName(RxValidateCondition).getCount();

        switch (RxValidateCondition){
            case "2":
                NoRxCallsReqd = 1;
            break;
            case "1":
                NoRxCallsReqd = try cbohelp.getDoctorNameCount(RXGENYN: RxValidateCondition);
            break;
            default:
                NoRxCallsReqd = 0;
        }


        if (NoRxCalls >= NoRxCallsReqd) {
            return true;
        }else{
            return false;
        }

        }else{
            return true;
        }
        }catch{
            return false;
        }
    }
    
    private func IsTeniviaMenuAvilable() -> Bool{
        return customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "Tenivia_NOT_REQUIRED",defaultValue: "Y") == ("N") ||
            customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc:self,key:"Rx_NOT_REQUIRED",defaultValue:"Y") == ("N");
    }
    
    private func openFilnaSubmit(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FinalSubmit") as!
        FinalSubmit
        vc.VCIntent["title"] = "Final Submit"
        vc.VCIntent["Back_allowed"] = "Y"
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func onClickRxGen(title : String){
         if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DrRXActivity") as! DrRXActivity
                vc.VCIntent["title"] = title
                self.present(vc, animated: true, completion: nil)
        
        }
        
    }
    
    
    func onClickChemistCall(title : String){
        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {
                
                if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {
                    
                    customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
                } else {
                    
                    customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
                }
        }else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
                if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ChemistCall") as! ChemistCall
                    vc.VCIntent["title"] = title
                    self.present(vc, animated: true, completion: nil)
                }
        }
        
    }

    func onClickCustomerCall(title : String){
        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {
            
            if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {
                
                customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
            } else {
                
                customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
            }
        }else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
            if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "CustomerCall") as! CustomerCall
                vc.VCIntent["title"] = title
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func onClickStockistCall(title : String){
        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {
            
            if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {
                
                customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
            } else {
                
                customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
            }
        }else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
            if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StockistCall") as!
                StockistCall
                vc.VCIntent["title"] = title
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    

    var size = 0;
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size = objCustomCollectionViewLayout.MyCollectionViewLayoutSet(collectionView: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout)
//
        if(size == 0){
            let numberOfItemsPerRow : Int = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
             size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        }
        return CGSize(width: size - 32 , height: size - 12)
//          print(size)
//        print(UIScreen.main.bounds)
//    return size
        
    }
    
    
    public func onClickDayPlanning() {
        //dcr_plan();

        if (customVariablesAndMethod.internetConneted(context: self) && customVariablesAndMethod.IsGPS_ON(context: self)) {
                //getActivity().startService(new Intent(getActivity(), BackgroundDataService.class));
                //new Thread(threadConvertAddress).start();
                dcr_plan();
            }
    }
    
    
    
    
    //==================================================================dcr planing===========================
    func dcr_plan(){
    //Start of call to service
    
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["sPaId" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        params["sMobileVersion"] = "\(Custom_Variables_And_Method.VERSION)"
        params["iDCR_ID"] = Custom_Variables_And_Method.DCR_ID

        var tables = [Int]()


        tables.append(-1)

        progressHUD.show(text: "Please wait ...\n Checking your DCR Status" )
//        self.view.addSubview(progressHUD)

        CboServices().customMethodForAllServices(params: params, methodName: "DCR_DAYPLAN_LOAD_1", tables: tables, response_code: MESSAGE_INTERNET_DCR_PLAN, vc : self)

        
    //End of call to service

        
    }
    
    ////////////////onClick Doctor Calll//////////////////
    
    func onClickDrCall(name : String) {
        

        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {

            if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {

                customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
            } else {

                customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
            }
        }
//        else if (customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "MOBILEDATAYN", defaultValue: "N") == "Y"  && !Custom_Variables_And_Method.internetConneted(context : self)) {
//            customVariablesAndMethod.Connect_to_Internet_Msg(context: self);
//
//        }
        else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
            
            if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DoctorCallViewController")  as! DoctorCallViewController
                myviewcontroller.VCIntent["title"] = name
                self.present(myviewcontroller, animated: true, completion:  nil)
            }
    }
}

    
    func onClickReminder(name : String) {
    
        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {
        
            if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {
            
            customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
            } else {
            
            customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
            }
        }else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
            if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ReminderCall") as! ReminderCall
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)
            }
        }
    
    }
    
    
    func onClickChemistReminder(name : String) {
    
        if (!customVariablesAndMethod.drChemEntryAllowed(context: self)) {
        
            if (DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real",defaultValue: "") == "") {
            
            customVariablesAndMethod.getAlert(vc: self, title: "Day Plan !!!", msg: "Please open your DCR Days first....")
                
            } else {
            
            customVariablesAndMethod.getAlert(vc: self,title: "final Submit Pending!!!",msg: "You Need to Final submit Your Pending Dcr First" + "\n" + "...Then Visit Again....")
            }
            
        } else if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
            if (IsAllowedToCallAtThisTime() && IsRouteApproved()) {
                
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //let vc = storyboard.instantiateViewController(withIdentifier: "ChemistReminderCall") as! ChemistReminderCall
                let vc = storyboard.instantiateViewController(withIdentifier: "ChemistR_Call") as! ChemistR_Call
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)
            }
        }
    
    }


    ////////////////////////


        
        

        override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
            switch response_code {
                
                    case MESSAGE_INTERNET_DCR_PLAN:
                        
                        self.parser_dcr_plan(dataFromAPI : dataFromAPI)
                        progressHUD.dismiss()
                        break;
                    case MESSAGE_INTERNET_IS_CALL_UNLOCKED:
                        
                        parser_is_call_unlocked(dataFromAPI : dataFromAPI)
                        progressHUD.dismiss()
                        break;
        
                    case 99:
                         progressHUD.dismiss()
                         customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
                         
                       
                        break;
                    default:
                      progressHUD.dismiss()
            }
        }
    
    
    private func parser_dcr_plan(dataFromAPI : [String : NSArray]) {
        do{

           if(!dataFromAPI.isEmpty){

                let  jsonArray =   dataFromAPI["Tables0"]!

                let innerJson = jsonArray[0] as! [String : AnyObject]

                if try (jsonArray.count > 0 &&
                    ( innerJson.getString(key: "STATUS_CODE")  == "Y" || innerJson.getString(key: "STATUS_CODE")  == "W")) {
                    if try (innerJson.getString(key: "STATUS_CODE")  == "W") {
                        AppAlert.getInstance()
                            .setNagativeTxt(nagativeTxt: "Later")
                            .DecisionAlert(vc: self,
                                           title: try innerJson.getString(key: "TITLE"),
                                           massege: try innerJson.getString(key: "MSG"),
                                listener: { () -> OnClickListener in
                                    class anonymous  : OnClickListener {
                                        var parent : DcrmenuInGrid!
                                        var innerJson : [String : AnyObject]!
                                        var dataFromAPI : [String : NSArray]!
                                        
                                        func onPositiveClicked(item: UIView?, result: String) {
                                            do{
                                                if (try !innerJson.getString(key: "URL").isEmpty){
                                                    
                                                   Custom_Variables_And_Method.getInstance()
                                                    .setDataForWebView(vcself: parent, mode: 0,
                                                                       title: try innerJson.getString(key: "TITLE"), url: try innerJson.getString(key: "URL"))
                                                }else{
                                                    try parent.openDCR(dataFromAPI: dataFromAPI);
                                                }
                                            }catch {
                                                    print("MYAPP", "objects are: \(error)")
                                                    Custom_Variables_And_Method.getInstance().getAlert(vc: parent, title: "Missing field error", msg: error.localizedDescription )
                                                    
                                                    
                                                    
                                                    let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                                                    
                                                    let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription)", vc: parent)
                                                    
                                                    objBroadcastErrorMail.requestAuthorization()
                                                }
                                        }
                                        
                                        func onNegativeClicked(item: UIView?, result: String) {
                                            do{
                                                try parent.openDCR(dataFromAPI: dataFromAPI)
                                            }catch {
                                                print("MYAPP", "objects are: \(error)")
                                                Custom_Variables_And_Method.getInstance().getAlert(vc: parent, title: "Missing field error", msg: error.localizedDescription )
                                                
                                                
                                                
                                                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                                                
                                                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription)", vc: parent)
                                                
                                                objBroadcastErrorMail.requestAuthorization()
                                            }
                                        }
                                        init(parent : DcrmenuInGrid,InnerJson : [String : AnyObject],dataFromAPI : [String : NSArray]) {
                                            self.parent = parent
                                            self.innerJson = InnerJson
                                            self.dataFromAPI = dataFromAPI
                                        }
                                    }
                                    return anonymous(parent: self,InnerJson: innerJson,dataFromAPI: dataFromAPI)
                            })
                    }else{
                        try openDCR(dataFromAPI: dataFromAPI)
                    }
                    
                }else if(jsonArray.count > 0 && innerJson["STATUS_CODE"] as! String == "R" ){
                    Multi_Class_Service_call().parser_Reset(vc : self,dataFromAPI: dataFromAPI)
                }else{
                    customVariablesAndMethod.getAlert(vc: self, title: innerJson["TITLE"] as! String, msg: innerJson["STATUS"] as! String, url: innerJson["URL"] as! String)
                    
                }

            
            }
        } catch {
            print("MYAPP", "objects are: \(error)")
            customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
            
            
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription)", vc: context)
            
            objBroadcastErrorMail.requestAuthorization()
            //CboServices.getAlert(context,"Missing field error",getResources().getString(R.string.service_unavilable) +error.toString());
            // e.printStackTrace();
        }


}


    private func openDCR(dataFromAPI : [String : NSArray]) throws {
        
        let  table2 =   dataFromAPI["Tables2"]!
        
        for i in 0 ..< table2.count{
            let c = table2[i] as! [String : AnyObject]
             getDelegate().getDCR()
                .setShowRouteAsPerTP(showRouteAsPerTP:try c.getString(key: "DCR_TP_AREA_AUTOYN"))
                .setShowWorkWithAsPerTP(showWorkWithAsPerTP:try c.getString(key: "DCR_LOCKWW"))
                .setNoOfAddAreaAlowed(noOfAddAreaAlowed:try c.getString(key: "DCR_NOADDAREA"))
                .setWorkWithTitle(workWithTitle:try c.getString(key: "WW_TITLE"))
                .setRouteTitle(routeTitle: try c.getString(key: "ROUTE_TITLE"))
                .setAreaTitle(areaTitle:try c.getString(key: "AREA_TITLE"))
                .setAdditionalAreaApprovalReqd(additionalAreaApprovalReqd:try c.getString(key: "ADDAREA_APPYN"));
        }
        
        let  jsonArray =   dataFromAPI["Tables0"]!
        
        let innerJson = jsonArray[0] as! [String : AnyObject]
        
        Custom_Variables_And_Method.DCR_DATE_TO_SUBMIT = innerJson["DCR_DATE"] as! String
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self, key: "DCR_DATE", value: innerJson["DCR_DATE"] as! String)
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self, key: "DATE_NAME",value: innerJson["DATE_NAME"] as! String)
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self, key: "CUR_DATE",value: innerJson["CUR_DATE"] as! String)
        Custom_Variables_And_Method.DCR_DATE = innerJson["DATE_NAME"] as! String
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self, key: "mark", value: innerJson["NewFlash"] as! String)
        
        
        
        
        let jsonArray1 =   dataFromAPI["Tables1"]!
        
        Custom_Variables_And_Method.DcrPending_datesList.removeAll()
        for i in 0 ..< jsonArray1.count{
            let innerJson = jsonArray1[i] as! [String : AnyObject]
            Custom_Variables_And_Method.DcrPending_datesList.append( innerJson["DATE_NAME"] as! String)
        }
        
        if (Custom_Variables_And_Method.DCR_ID == "0" || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "dcr_date_real" , defaultValue: "" ) == ""){
            
            Custom_Variables_And_Method.ROOT_NEEDED = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "root_needed", defaultValue: "N");
            
            if (Custom_Variables_And_Method.ROOT_NEEDED == "Y") {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DCR_Route_new")  as! DCR_Route_new
                myviewcontroller.VCIntent["plan_type"] = "p"
                self.present(myviewcontroller, animated: true, completion:  nil)
                
            } else {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DCR_Area_new")  as! DCR_Area_new
                myviewcontroller.VCIntent["plan_type"] = "p"
                self.present(myviewcontroller, animated: true, completion:  nil)
            }
            
        } else {
            //if data or dcr are pending
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "GetDCR")  as! GetDCR
            //                    myviewcontroller.VCIntent =
            context.present(myviewcontroller, animated: true, completion:  nil)
        }
    }
    
    
    
    private func parser_is_call_unlocked(dataFromAPI : [String : NSArray]) {
    
        do {
            if (!dataFromAPI.isEmpty){
                let jsonArray =  dataFromAPI["Tables0"]!
                
                  for i in 0 ..< jsonArray.count{
                    let innerJson = jsonArray[i] as! [String : AnyObject]
                    if (CheckType == "A"){
                        if  (jsonArray.count > 0 && (innerJson["CALL_UNLOCK"]!.contains("[DIVERT_UNLOCK]"))) {
                            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "DIVERTLOCKYN", value : "" );
                            customVariablesAndMethod.getAlert(vc: self, title: "Route Approved !!!", msg: "Your Calls have been Approved \nYou can please proceed")
                         
                        }
                        else {
                            customVariablesAndMethod.getAlert(vc: self, title: "Route Approval !!!", msg: "Your Route Approval is Pending... \nYou Route must be approved first !!!\nPlease contact your Head-Office for APPROVAL")
                        }
                    } else {
                        if (jsonArray.count > 0 && ( innerJson["CALL_UNLOCK"]?.contains("[CALL_UNLOCK]"))!) {
                            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self, key : "CALL_UNLOCK_STATUS", value : "[CALL_UNLOCK]");
                            customVariablesAndMethod.getAlert(vc : self, title : "CALL UNLOCKED", msg : "Your Calls have been Unlocked \nYou can please proceed")
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

    
    
    private func addAllTab() {
    
         DRC_Menu = cbohelp.getMenu(menu: "DCR", code: "" )
        keyValue = DRC_Menu
        
        getKeyList.removeAll()
        count_Calls.removeAll()
        
           for i in 0 ..<  DRC_Menu.count{
                getKeyList.append( DRC_Menu[i]["menu_code"]!)
                count_Calls.append(get_count( menu: DRC_Menu[i]["menu_code"]!))
            }
        
            if(!getKeyList.contains("D_CHEMCALL") && !getKeyList.contains("D_RETCALL")){
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "CHEMIST_NOT_VISITED",value : "Y");
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "CHEMIST_NOT_REQUIRED",value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "CHEMIST_NOT_REQUIRED",value : "N");
            }
            if(!getKeyList.contains("D_STK_CALL")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "STOCKIST_NOT_VISITED",value : "Y");
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "STOCKIST_NOT_REQUIRED",value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "STOCKIST_NOT_REQUIRED",value : "N");
            }
            if(!getKeyList.contains("D_NLC_CALL")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "NonListed_NOT_REQUIRED",value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "NonListed_NOT_REQUIRED",value : "N");
            }
            if(!getKeyList.contains("D_DRCALL")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Doctor_NOT_REQUIRED",value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Doctor_NOT_REQUIRED",value : "N");
            }
            if(!getKeyList.contains("D_RCCALL")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Doctor_RC_NOT_REQUIRED",value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Doctor_RC_NOT_REQUIRED",value : "N");
            }
            if(!getKeyList.contains("D_AP")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Appraisal_NOT_REQUIRED",value : "Y");
            }else{
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Appraisal_NOT_REQUIRED",value: "N");
            }
        
            if(!getKeyList.contains("D_EXP")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Expense_NOT_REQUIRED", value : "Y");
            }else{
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Expense_NOT_REQUIRED", value : "N");
            }
            if(!getKeyList.contains("D_DR_RX")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Tenivia_NOT_REQUIRED", value : "Y");
            }else {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key :  "Tenivia_NOT_REQUIRED", value :  "N");
            }
        
        if(!getKeyList.contains("D_RX_GEN")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Rx_NOT_REQUIRED", value : "Y");
        }else {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key :  "Rx_NOT_REQUIRED", value :  "N");
        }
        
        if(!getKeyList.contains("D_RX_GEN_NA")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key : "Rx_NA_NOT_REQUIRED", value : "Y");
        }else {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc : self , key :  "Rx_NA_NOT_REQUIRED", value :  "N");
        }
        
        if(!getKeyList.contains("D_DAIRY")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "Dairy_NOT_REQUIRED",value: "Y");
        }else {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "Dairy_NOT_REQUIRED", value: "N");
        }
        if(!getKeyList.contains("D_POULTRY")){
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context,key: "Polutary_NOT_REQUIRED",value: "Y");
        }else {
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "Polutary_NOT_REQUIRED", value: "N");
        }
        
//            for  i in 0 ..< keyValue.count {
//            listOfAllTab.add(keyValue.get(getKeyList.get(i)));
//            }
    }
    
    //D_CHEM_RCCALL
    private func get_count( menu : String) -> Int{
        var result=0;
        var table="";
        var flag=false;
        switch (menu){
        case "D_RCCALL":
            flag=true;
            table="phdcrdr_rc";
            result=1;
            break;
        case "D_DRCALL":
            flag=true;
            table="tempdr";
            result=1;
            break;
        case "D_CHEMCALL","D_CUST_CALL" :
            flag=true;
            table="chemisttemp";
            result=1;
            break;
        case "D_RETCALL":
            flag=true;
            table="chemisttemp";
            result=1;
            break;
        case "D_CHEM_RCCALL":
            flag=true;
            table="phdcrchem_rc";
            result=1;
            break;
        case "D_STK_CALL":
            flag=true;
            table="phdcrstk";
            result=1;
            break;
        case "D_NLC_CALL":
            flag=true;
            table="NonListed_call";
            result=1;
            break;
        case "D_EXP":
            flag=true;
            table="Expenses";
            result=0;
            break;
        case "D_DR_RX","D_RX_GEN","D_RX_GEN_NA":
            flag=true;
            table="Tenivia_traker";
            result=1;
            break;
            
        case "D_FAR":
            flag=true;
            table="PHFarmer";
            result=1;
            break;
        case "D_AP":
            flag=false;
            result=cbohelp.get_Appraisal(flag: "1",pa_id: "").count
            break;
            
        case "D_DAIRY":
            flag=false;
            result=cbohelp.getCountphdairy_dcr(DOC_TYPE: "D");
            break;
        case "D_POULTRY":
            flag=false;
            result=cbohelp.getCountphdairy_dcr(DOC_TYPE : "P");
            break;

            
        default:
           flag=false;
        }
        
        if(flag && !(table == "")){
            result=cbohelp.getmenu_count(table: table);
            }
        return result;
    }

    func checkforCalls() -> Bool{
        var result=0;
        result += cbohelp.getmenu_count(table: "phdcrdr_rc");
        result += cbohelp.getmenu_count(table: "tempdr");
        result += cbohelp.getmenu_count(table: "chemisttemp");
        result += cbohelp.getmenu_count(table: "phdcrstk");
       // result += cbohelp.getmenu_count(table: "PHFarmer");
        
        if (result==0){
            return false;
        }else {
            return true;
        }
    }
    
    
    func IsAllowedToCallAtThisTime() -> Bool{
        let FIRST_CALL_LOCK_TIME = Float(customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "FIRST_CALL_LOCK_TIME",defaultValue: "0"))!
        if (FIRST_CALL_LOCK_TIME == 0) {return true}
    
        if (checkforCalls()) {return true}
    
        let current_time = Float(customVariablesAndMethod.getCurrentBestTime(context: self))!
    
        if (current_time > FIRST_CALL_LOCK_TIME && !customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "CALL_UNLOCK_STATUS",defaultValue: "[CALL_UNLOCK]").contains("[CALL_UNLOCK]")){
            
            if (!customVariablesAndMethod.internetConneted(context: self,ShowAlert: false)) {
                

                customVariablesAndMethod.getAlert(vc: self, title: "Call Locked", msg: "Your Calls have been Locked... \nYou must have made your first Call before \(FIRST_CALL_LOCK_TIME) O'Clock\nSwitch ON your Internet and Check if Unlocked...")
                
                
            }else{
                CheckIfCallsUnlocked(type: "C");
            }
            return false;
        }
    
        return true;
    }
    
    
    func IsRouteApproved() -> Bool{
        let DIVERTLOCKYN = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "DIVERTLOCKYN",defaultValue: "");
        if (DIVERTLOCKYN != "Y") {
            return true;
        }
    
        if (!customVariablesAndMethod.internetConneted(context: self,ShowAlert: false)) {
         
            
            customVariablesAndMethod.getAlert(vc: self, title: "Route Approval !!!", msg: "Your Route Approval is Pending... \nYou Route must be approved first !!!\nSwitch ON your Internet and Check if Approved...")
            
            
        }else{
            CheckIfCallsUnlocked(type: "A");
        }
    
    
        return false;
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
        
        progressHUD.show(text: "Please Wait.. \n Checking Your Call Status...")
        
        CboServices().customMethodForAllServices(params: params, methodName: "CallUnlockStatus", tables: tables, response_code: MESSAGE_INTERNET_IS_CALL_UNLOCKED, vc : self)
       
        //End of call to service
    }
    

    
    
    
    
}


