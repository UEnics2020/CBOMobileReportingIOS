//
//  UtilitiesMenuInGrid.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 22/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class UtilitiesMenuInGrid: CustomUIViewController , MenuGridAdaptorDelegate{
    
    var adpator : MenuGridAdaptor!
    @IBOutlet weak var collectionView: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var Utilities_Menu = [[String : String]]()
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    var multiCallService : Multi_Class_Service_call!
    var progressHUD : ProgressHUD!
    
    let MESSAGE_INTERNET_UTILITES=2,MESSAGE_INTERNET_RESET_DCR=3
    
//    override func viewDidAppear(_ animated: Bool) {
//        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities_Menu = cbohelp.getMenu(menu: "UTILITY", code: "" )
        // Do any additional setup after loading the view.
        progressHUD = ProgressHUD(vc : self)
        multiCallService = Multi_Class_Service_call()
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        adpator = MenuGridAdaptor(collectionViewGrid: collectionView, vc: self, menu: Utilities_Menu )
        adpator.delegate = self
        collectionView.delegate = adpator;
        collectionView.dataSource = adpator;
        
    }
    
    //MARK:- function to access the cell from collection view
    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: "UTILITY", menu_code: menu_code)
        if (!url.isEmpty){
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        } else {
            
            switch menu_code{
            case "U_UPDOWN":
                multiCallService.UploadDownLoad(vc: self, response_code: MESSAGE_INTERNET_UTILITES,progressHUD: progressHUD)
                break
            case "U_RESET":
                onClickResetDayplan();
                break;
                // upload pic
            case "U_UPPIC":
                onClickUploadPic()
                break
                

            // for visual ad
            case "U_DOWNAID" :
                
                onClickDownloadVisualad()
                break
                
                
            case "U_SHOWAID" :
                onClickShowVisualAd()
                break
                
                
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
            
        }
//        if (!url.isEmpty){
//            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
//        }else if (menu_code == ("U_UPPIC")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_UPDOWN")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_RESET")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_CAPSIGN")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_MAP")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_WEB")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_DOWNAID")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_SHOWAID")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("U_PI")) {
//            print("User has been selected \(menu_code) index cell")
//
//        } else if (menu_code == ("Show Demo Kilometer")) {
//            print("User has been selected \(menu_code) index cell")
//
//        }
//        else{
//            print("User has been selected \(menu_code) index cell")
//
//        }
        
    }
    
    /////////////////// onClickShowVisualAd()
    
    func onClickShowVisualAd(){
    
        if customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "DCRSAMPLE_AFTERVISUALAIDYN", defaultValue: "N") == "Y" {
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_SAVE_SHOW", value: "N");
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      
            let vc = storyboard.instantiateViewController(withIdentifier: "CheckboxShowVisualAd") as! CheckboxShowVisualAd
            Custom_Variables_And_Method.DR_ID = "0"
            vc.VCIntent["title"] = "Visual Aids"
            vc.VCIntent["who"] = ""
            vc.vc =  self
            self.present(vc, animated: true, completion: nil)
            
        } else {
             
             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
             let showVisualAdVC = storyBoard.instantiateViewController(withIdentifier: "ShowVisualAd") as! ShowVisualAd
             //let showVisualAdVC = storyBoard.instantiateViewController(withIdentifier: "CheckboxShowVisualAd") as! CheckboxShowVisualAd
             Custom_Variables_And_Method.DR_ID = "0"
            
             showVisualAdVC.VCIntent["title"] = "Visual Aids"
             showVisualAdVC.VCIntent["who"] = ""
             self.present(showVisualAdVC, animated: true, completion: nil)
            
        }
        
    }
    
    
    /////////////////////// onClickDownloadVisualad
    func onClickDownloadVisualad(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "VisualAidDownload") as! VisualAidDownload
        let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "AvailableDownload") as! AvailableDownload
        
        visualAidDownloadVC.VCIntent["title"] = "Visual Aids Download"
        
        self.present(visualAidDownloadVC, animated: true, completion: nil)
    }
    
    ///////////////////onClickUpload Pic
    func onClickUploadPic(){
        
        print("u just clicked on upload image")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let uploadImageVC = storyBoard.instantiateViewController(withIdentifier: "UploadImageVC") as! UploadImageVC
        self.present(uploadImageVC, animated: true, completion: nil)
        
    }
    
    //////////////////onClickResetDayplan
    func onClickResetDayplan() {
    
        if (Custom_Variables_And_Method.DCR_ID == ("0")) {
            
            customVariablesAndMethod.msgBox(vc: self ,msg: "Please Plan your Dcr Day..");
            
        } else {
            
            var msg = "Are Sure to Reset your DCR ?"
            if (IscallsFound()){
                msg = "Some Calls found !!!!\nAre you sure to Reset your Dcr\nAll Calls will be Deleted..."
            }
            
            customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "MANUAL_TA",value: "0.0");
            
            customVariablesAndMethod.getDecisionAlert(vc: self, title: "Reset DCR!!!",Ok_Title: "Reset", msg: msg, completion: {_ in
                self.multiCallService.ResetDCR(vc: self, response_code: self.MESSAGE_INTERNET_RESET_DCR,progressHUD: self.progressHUD)
            })
            
        }

    }
    
    func IscallsFound() -> Bool{
        var result = cbohelp.getmenu_count(table: "phdcrdr_rc");
        result += cbohelp.getmenu_count(table: "tempdr");
        result += cbohelp.getmenu_count(table: "chemisttemp");
        result += cbohelp.getmenu_count(table: "phdcrstk");
        result += cbohelp.getmenu_count(table: "NonListed_call");
        result += cbohelp.getmenu_count(table: "Tenivia_traker");
        return result>0;
    }
    
    
        override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
            switch response_code {
    
            case MESSAGE_INTERNET_UTILITES:
                multiCallService.parser_utilites( dataFromAPI  : dataFromAPI)
                break
            case MESSAGE_INTERNET_RESET_DCR:
                multiCallService.parser_Reset(vc : self, dataFromAPI  : dataFromAPI)
                break
            case 99:
                progressHUD.dismiss()
                customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
                break
            default:
                progressHUD.dismiss()
                print("Error")
            }
        }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let size = objCustomCollectionViewLayout.MyCollectionViewLayoutSet(collectionView: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout)
//        
//        return size
//        
//    }
    
}
