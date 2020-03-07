//
//  Doctor_registration_GPS.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 29/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class Doctor_registration_GPS: CustomUIViewController {

    @IBOutlet weak var latlong: CustomDisableTextView!
    @IBOutlet weak var MyTopView: TopViewOfApplication!
    @IBOutlet weak var dr_name: CustomDisableTextView!
    
    @IBOutlet weak var cancel: CustomeUIButton!
    @IBOutlet weak var register: CustomeUIButton!
    @IBOutlet weak var loc_img: UIImageView!
    @IBOutlet weak var refresh: CustomeUIButton!
    
    @IBOutlet weak var lane1: CustomTextView!
    
    @IBOutlet weak var state: CustomTextView!
    @IBOutlet weak var pincode: CustomTextView!
    @IBOutlet weak var city: CustomTextView!
    @IBOutlet weak var lane2: CustomTextView!
    
    @IBOutlet weak var addressLayout: UIStackView!
    var dr_id = ""
    var lastLatLong = ""
    var callTyp = "D"
    var REG_ADDRESS_KM = 0.0
    
    var cbohelp = CBO_DB_Helper.shared
    
    
    var syncServices: SyncService!
    var progess : ProgressHUD!
    var vc : CustomUIViewController!
    let MESSAGE_INTERNET_SYNC=1,LATLONG_ADDRESS=2,LATLONG_ADDRESS_COMMIT = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTopView.backButton.addTarget(self, action: #selector(closeCurrentView), for: .touchUpInside)
        cancel.addTarget(self, action: #selector(closeCurrentView), for: .touchUpInside)
        refresh.addTarget(self, action: #selector(setLetLong), for: .touchUpInside)
        register.addTarget(self, action: #selector(Submit_register), for: .touchUpInside)
        
        dr_name.setText(text: VCIntent["dr_name"]!)
        dr_id = VCIntent["dr_id"]!
        
        callTyp = VCIntent["callTyp"]!
        if callTyp == "D" {
            MyTopView.setText(title: "Doctor Registration...")
        }else if callTyp == "C" {
            MyTopView.setText(title: "Chemist Registration...")
        }else if callTyp == "DA" {
             callTyp = "DP";
            MyTopView.setText(title: "Dairy Registration...")
        }else if callTyp == "PA" {
             callTyp = "DP";
            MyTopView.setText(title: "Poultry Registration...")
        }else{
            MyTopView.setText(title: "Stockist Registration...")
        }
        
        setLetLong()
        
        REG_ADDRESS_KM =   (Double)( customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self,key: "REG_ADDRESS_KM",defaultValue: "0"))!;
        if(REG_ADDRESS_KM > 0){
            addressLayout.isHidden = false
        }else{
             addressLayout.isHidden = true
        }
        
        lane1.setHint(placeholder: "Enter Lane 1...")
        lane2.setHint(placeholder: "Enter Lane 2...")
        city.setHint(placeholder: "Enter City..")
        pincode.setHint(placeholder: "Enter pincode...")
        pincode.setKeyBoardType(keyBoardType: .numberPad)
        state.setHint(placeholder: "Enter State")
        
    }
    
    @objc func Submit_register(){
        setLetLong()
        if(lastLatLong != nil && lastLatLong != ("")){
            lastLatLong = customVariablesAndMethod1.get_best_latlong(context: self);
            
            
            if(!customVariablesAndMethod1.internetConneted(context: self , ShowAlert: false,SkipMadatory: true)){
                cbohelp.updateLatLong(latlong: lastLatLong,id: dr_id,type: callTyp,index: "");
                
                customVariablesAndMethod1.getAlert(vc: self, title: "Registered", msg: dr_name.getText() + "\nRegistration Successfully Completed... ", completion: {_ in
                    self.MyTopView.CloseCurruntVC(vc: self)
                });
                
                
            }else if(!addressLayout.isHidden){
                validateAddress()
            }else{
                cbohelp.updateLatLong(latlong: lastLatLong,id: dr_id,type: callTyp,index: "");
                syncServices = SyncService(context: self)
                progess = ProgressHUD(vc : self)
                progess.show(text: "Please Wait.. \nRegistration in progess..." )
                syncServices.DCR_sync_all(responseCode: MESSAGE_INTERNET_SYNC,ReplyYN : "Y")
            }
           
        }else{
            customVariablesAndMethod1.msgBox(vc: self, msg: "Unknown location....\n Cannot reister at this moment")
            
        }
    }
    
    
    private func validateAddress(){
        if (lane1.getText().isEmpty){
            customVariablesAndMethod1.getAlert(vc: self, title: "Alert!!!", msg: "Please enter Lane1...")
            //lane1.setError("Please enter Lane1...");
        }else if (lane2.getText().isEmpty){
            customVariablesAndMethod1.getAlert(vc: self, title: "Alert!!!", msg: "Please enter Lane2...")
        }else if (city.getText().isEmpty){
            customVariablesAndMethod1.getAlert(vc: self, title: "Alert!!!", msg: "Please enter city...")
        }else if (pincode.getText().isEmpty){
            customVariablesAndMethod1.getAlert(vc: self, title: "Alert!!!", msg: "Please enter pincode...")
        }else if (state.getText().isEmpty){
            customVariablesAndMethod1.getAlert(vc: self, title: "Alert!!!", msg: "Please enter state...")
        }else {
            let address = lane1.getText() + "," + lane2.getText() + "," + city.getText()
            + "," + state.getText() + "," + pincode.getText();
            getLatLongFrom(address: address);
        }
    }
    
    private func getLatLongFrom( address : String) {
        progess = ProgressHUD(vc : self)
        progess.show(text: "Please Wait.. \nVerifing your Address..." )
        AddressToLatLong(context: self,address : address)
        .getLatLong(response_code: LATLONG_ADDRESS)
    }
    
    @objc func setLetLong() {
        lastLatLong =  customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self, key: "shareLatLong", defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON)
        latlong.setText(text: lastLatLong)
        setLocImg();
    }

    
    func setLocImg(){
        if(lastLatLong != nil && lastLatLong != ("")){
            loc_img.image = #imageLiteral(resourceName: "loc.jpg")
        }else{
             loc_img.image = #imageLiteral(resourceName: "un_loc.png")
           
        }
    }
    
    @objc func closeCurrentView()
    {
        MyTopView.CloseCurruntVC(vc: self)
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        switch response_code {
        case MESSAGE_INTERNET_SYNC:
            progess.dismiss()
            syncServices.parser_sync(result: dataFromAPI)
            customVariablesAndMethod1.getAlert(vc: self, title: "Registered1", msg: dr_name.getText() + "\nRegistration Successfully Completed... ", completion: {_ in
                self.MyTopView.CloseCurruntVC(vc: self)
            });
            
        case LATLONG_ADDRESS:
            
            let LatLong = dataFromAPI["latLong"]![0] as! String
            let address = dataFromAPI["address"]![0] as! String
            let km1 = distance(lat1: Double(LatLong.components(separatedBy: ",")[0])!, lon1: Double(LatLong.components(separatedBy: ",")[1])!
                ,  lat2: Double(lastLatLong.components(separatedBy: ",")[0])!, lon2: Double(lastLatLong.components(separatedBy: ",")[1])!, unit: "K");
            
           progess.dismiss()
            if (km1>=REG_ADDRESS_KM){
                AppAlert.getInstance().Alert(vc: self, title: "Invalid Address!!!",massege: "Entered Address does not seems to valid as per your current Loction" +
                    "\n\nYou are \(km1) Kms away from the Address you entered\nPlease Check your Address and Try again..."){
                    
                };
            }else {
                if (cbohelp.getCompanyCode().uppercased() == ("DEMO") || cbohelp.getCompanyCode().uppercased() == ("DEMOTEST")) {
                    AppAlert.getInstance().Alert(vc: self, title: "Alert!!!", massege: "Distance : - \( km1)") {
                        self.registerDoctorAddress(MOBILE_LAT_LONG: self.lastLatLong,ADDRESS_LAT_LONG: LatLong,address: address,KM: "\(km1)");
                        }
                }else {
                    
                    registerDoctorAddress(MOBILE_LAT_LONG: lastLatLong,ADDRESS_LAT_LONG: LatLong,address: address,KM: "\(km1)");
                }
            }
        case LATLONG_ADDRESS_COMMIT:
            progess.dismiss()
            cbohelp.updateLatLong(latlong: lastLatLong,id: dr_id,type: callTyp,index: "");
            syncServices = SyncService(context: self)
            progess = ProgressHUD(vc : self)
            progess.show(text: "Please Wait.. \nRegistration in progess..." )
            syncServices.DCR_sync_all(responseCode: MESSAGE_INTERNET_SYNC,ReplyYN : "Y")
        case 99:
            progess.dismiss()
            customVariablesAndMethod1.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            
            break
        default:
            progess.dismiss()
            self.dismiss(animated: true, completion: nil)
            print("Error")
            
        }
       
    }
    
    private func registerDoctorAddress( MOBILE_LAT_LONG : String, ADDRESS_LAT_LONG : String , address : String, KM : String){
    
        var params = [String:String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPa_Id"] = "\(Custom_Variables_And_Method.PA_ID)"
        params["iDCS_ID"] = dr_id
        params["sLANE1"] = lane1.getText()
        params["sLANE2"] = lane2.getText()
        params["sCITY"] = city.getText()
        params["sPIN"] = pincode.getText()
        params["sSTATE"] = state.getText()
        params["sCATEGORY"] = callTyp
        params["sLAT_LONG"] = MOBILE_LAT_LONG
        params["sLOC_EXTRA"] = ADDRESS_LAT_LONG + "_" + address
        params["sDiff_Km"] =  KM
        
        let tables = [0]
        progess = ProgressHUD(vc : self)
        progess.show(text: "Please wait ...\n Registration in progress......" )
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCSREG_COMMIT", tables: tables, response_code: LATLONG_ADDRESS_COMMIT, vc : self )
  
    }

}
