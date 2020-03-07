//
//  GetDCR.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 25/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class GetDCR: CustomUIViewController {

    
    @IBOutlet weak var refreshDcr: UIButton!
    @IBOutlet weak var lblDCR_Date: UILabel!
    
    @IBOutlet weak var lblWorkWith: UILabel!
    
    @IBOutlet weak var lblRoute: UILabel!
    
    @IBOutlet weak var lblArea: UILabel!
    
    @IBOutlet weak var replanBuuton : UIButton!
    
    var progressHUD : ProgressHUD!
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
   
    
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    @IBOutlet weak var topView: UIView!
    let INTERNET_MSG_LOGIN = 0 ,MESSAGE_INTERNET_DOWNLOADALL = 1
    var multiCallService : Multi_Class_Service_call!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topView.backgroundColor = AppColorClass.colorPrimary
        
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        progressHUD = ProgressHUD(vc: self)
        multiCallService = Multi_Class_Service_call()
        
        var params = [String:String]()
        params["sCompanyFolder"]  = cbohelp.getCompanyCode()
        params["iDcrId"] = Custom_Variables_And_Method.DCR_ID
        
        //        replanBuuton.addTarget(self, action: #selector(pressedReplanfunc(vc:)), for: .touchUpInside)
        
        let tables = [0]
        // avoid deadlocks by not using .main queue here
        
        progressHUD.show(text: "Please wait ...\n Checking your DCR Status" )
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "GETDCR", tables: tables, response_code: INTERNET_MSG_LOGIN, vc : self , multiTableResponse: false)
        
        
        refreshDcr.addTarget(self, action: #selector(DownloadAll), for: .touchUpInside)
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
            case INTERNET_MSG_LOGIN:
                parser_utilities(dataFromAPI : dataFromAPI)
                progressHUD.dismiss()
            break;
            case MESSAGE_INTERNET_DOWNLOADALL:
                multiCallService.parser_DCRCOMMIT_DOWNLOADALL(dataFromAPI : dataFromAPI)
                progressHUD.dismiss()
                customVariablesAndMethod.getAlert(vc: self, title: "Refreshed...", msg: "DCR Sucessfully Refreshed...")
                break;
            case 99:
                   progressHUD.dismiss()
                customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break;
            default:
                 progressHUD.dismiss()
        }
    }
    
    @objc func DownloadAll(){
        multiCallService.DownLoadAll(vc: self, response_code: MESSAGE_INTERNET_DOWNLOADALL,progressHUD: progressHUD)
    }
    
    private func parser_utilities(dataFromAPI : [String : NSArray])
    {
        if(!dataFromAPI.isEmpty){
            let jsonArray =   dataFromAPI["Tables0"]!
           
            for i in 0 ..< jsonArray.count{
                let innerJson = jsonArray[i] as! [String : AnyObject]
                lblArea.text = (innerJson["AREA"] as! String)
                lblRoute.text = (innerJson["ROUTE_NAME"] as! String)
                lblDCR_Date.text = (innerJson["DCR_DATE"] as! String)
                lblWorkWith.text = (innerJson["WORKWITH1"] as! String)
                    + "\n" + (innerJson["WORKWITH2"] as! String)
                    + "\n" + (innerJson["WORKWITH2"] as! String)
            }
        }
    }
    
    @IBAction func pressedReplan(_ sender: CustomeUIButton) {
        
        
        if (checkforCalls()) {
            AppAlert.getInstance()
                .setPositiveTxt(positiveTxt: "Replan")
                .DecisionAlert(vc: self, title: "Call Found!!!",
                               massege: "Are you sure to Replan ? \nSome Calls found in your Day Summary.\n" +
                    "Else Reset your Day Plan from Utility",
                               listener: { () -> OnClickListener in
                                class anonymous  : OnClickListener {
                                    var parent : GetDCR!
                                    
                                    func onPositiveClicked(item: UIView?, result: String) {
                                        parent.openForReplan()
                                    }
                                    
                                    func onNegativeClicked(item: UIView?, result: String) {
                                        
                                    }
                                    init(parent : GetDCR) {
                                        self.parent = parent
                                    }
                                }
                                return anonymous(parent: self)
                });
        }  else {
            openForReplan()
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
    
    private func openForReplan(){
        Custom_Variables_And_Method.ROOT_NEEDED = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "root_needed", defaultValue: "N");
        
        if (Custom_Variables_And_Method.ROOT_NEEDED == "Y") {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DCR_Route_new")  as! DCR_Route_new
            myviewcontroller.VCIntent["plan_type"] = "R"
            self.present(myviewcontroller, animated: true, completion:  nil)
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let myviewcontroller =  storyboard.instantiateViewController(withIdentifier: "DCR_Area_new")  as! DCR_Area_new
            myviewcontroller.VCIntent["plan_type"] = "R"
            self.present(myviewcontroller, animated: true, completion:  nil)
        }
    }
    
    
    @IBAction func pressedBottomBackButton(_ sender: CustomeUIButton) {
         Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    
    @IBAction func pressedBackButton(_ sender: UIButton) {
        Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
}
