//
//  MailDetailsVC.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 15/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class MailDetailsVC: CustomUIViewController {

    private let MAIL_POPULATE = 1
    private var mailAdaptor : MailDetailsAdaptor!
    
    private let summarydata = ["vikas","vaibhav","mukesh","deepak","sudhanshu","Akash","bharat", "Amrita"]
    private var customVariablesAndMethod: Custom_Variables_And_Method!
    private var progressHUD : ProgressHUD!
    
    private var cc_Ids = "";
    private var to_Ids = "";
    private var replyto_Ids = "";
    private var cc_Names = "";
    private var to_Names = "";
    private var replyto_Names = "";
    
    private var cbohelp : CBO_DB_Helper!
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var lbl_Title: UILabel!
    
    @IBOutlet weak var lbl_DateTime: UILabel!
    
    @IBOutlet weak var lbl_From: UILabel!

    @IBOutlet weak var lbl_Subject: UILabel!
    
    
    @IBOutlet weak var lbl_Remark: UILabel!
    
    @IBOutlet weak var btn_Attachment: UIButton!
    
    @IBOutlet weak var btn_Reply: UIButton!
    
    @IBOutlet weak var btn_Forward: UIButton!
    
    @IBOutlet weak var btn_ReplyAll: UIButton!
    
    @IBOutlet weak var btn_ReplyAll2: UIButton!
    
    @IBOutlet weak var btn_Reply2: UIButton!
    
    @IBOutlet weak var btn_Forward2: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        if VCIntent["title"] != nil{
            myTopView.setText(title:  VCIntent["title"]!)
        }
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        btn_Reply.addTarget(self, action: #selector(pressedReply), for: .touchUpInside)
        
        btn_Forward.addTarget(self, action: #selector(pressedForward), for: .touchUpInside)
        
        btn_Reply2.addTarget(self, action: #selector(pressedReply), for: .touchUpInside)
    
        btn_Forward2.addTarget(self, action: #selector(pressedForward), for: .touchUpInside)
    
        btn_ReplyAll.addTarget(self, action: #selector(pressedReplyAll), for: .touchUpInside)
        
        btn_ReplyAll2.addTarget(self, action: #selector(pressedReplyAll), for: .touchUpInside)
    
        cbohelp = CBO_DB_Helper.shared
        
        
        switch (VCIntent["category"]!.lowercased()){
        case "i":
            PopulateMail_History();
            break;
        case "s","r","f":
            btn_Reply.isHidden = true
            btn_Reply2.isHidden = true
            btn_ReplyAll.isHidden = true
            btn_ReplyAll2.isHidden = true
            PopulateMail_History();
            break;
        case "d":
            btn_Reply.isHidden = true
            btn_Reply2.isHidden = true
            btn_ReplyAll.isHidden = true
            btn_ReplyAll2.isHidden = true
            btn_Forward.isHidden = true
            btn_Forward2.isHidden = true
            break;
        default:
            print("null")
        }
        
       
        
    }
    
    private func PopulateMail_History(){
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iPaId"] = "\(Custom_Variables_And_Method.PA_ID)"
        params["iId"] =  VCIntent["mail_id"]!
        params["sMailType"] = ""
        let tables = [0,1,2]
        progressHUD = ProgressHUD(vc: self)
        progressHUD.show(text: "Please Wait...")
        CboServices().customMethodForAllServices(params: params, methodName: "MailPopulate", tables: tables, response_code: MAIL_POPULATE , vc: self, multiTableResponse: true)
    }
    
    @objc func closeVC(){
        myTopView.CloseCurruntVC(vc: self)
    }
    
    @objc func pressedReply(){
        composeMail(mailType: "R")
    }
    
    @objc func pressedReplyAll(){
        composeMail(mailType: "RA")
    }
    
    private func composeMail(mailType : String){
        
        self.dismiss(animated: false , completion: nil)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ComposeMailView") as! ComposeMailView
        
        vc.VCIntent["mail_id"] =  VCIntent["mail_id"]!
        
        switch mailType{
            case "R":
                vc.VCIntent["mail_cc_ids"] = ""
                vc.VCIntent["mail_cc_names"] = ""
                vc.VCIntent["mail_to_ids"] = replyto_Ids
                vc.VCIntent["mail_to_names"] = replyto_Names
               break;
            case "RA":
                vc.VCIntent["mail_cc_ids"] = cc_Ids
                vc.VCIntent["mail_cc_names"] = cc_Names
                vc.VCIntent["mail_to_ids"] = to_Ids
                vc.VCIntent["mail_to_names"] = to_Names
                break;
            case "F":
                vc.VCIntent["mail_cc_ids"] = ""
                vc.VCIntent["mail_cc_names"] = ""
                vc.VCIntent["mail_to_ids"] = ""
                vc.VCIntent["mail_to_names"] = ""
                break;
            default:
                print("null")
        }
        
        vc.VCIntent["mail_type"] = mailType
        vc.VCIntent["mailSubject"] = lbl_Title.text!
        vc.VCIntent["remark"] = lbl_Remark.text
        
        vc.VCIntent["title"] = "Compose"
        self.presentingViewController?.present(vc, animated: false, completion: nil)
    }
    
    @objc func pressedForward(){
         composeMail(mailType: "F")
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        
        switch response_code {
        case MAIL_POPULATE:
            progressHUD.dismiss()
            parser_MailData(dataFromAPI: dataFromAPI)
            break
        case 99:
            progressHUD.dismiss()
            customVariablesAndMethod.msgBox(vc: self, msg: (dataFromAPI["Error"]![0] as! String))
            
            break
        default:
            progressHUD.dismiss()
            print("print")
        }
    }
    
    
    
    private func parser_MailData(dataFromAPI: [String : NSArray]){
        
        do{
            if !dataFromAPI.isEmpty{
                let jsonArray =   dataFromAPI["Tables0"]!
                for i in 0 ..< jsonArray.count{
                    let innerJson = jsonArray[i] as! [String : AnyObject]
                    
                    lbl_Title.text = (innerJson["SUBJECT"] as! String)
                    lbl_DateTime.text = (innerJson["DOC_DATE"] as! String)
                    lbl_Remark.text = (innerJson["REMARK"] as! String)
                    if VCIntent["from"] != nil{
                        lbl_From.text = VCIntent["from"]!
                    }
                    print(innerJson)
                }
                
                let jsonArray2 =   dataFromAPI["Tables2"]!
                var cc_count = 0;
                var to_count = 0;
                var replyto_count = 0;
                for i in 0 ..< jsonArray2.count{
                    let object = jsonArray2[i] as! [String : AnyObject]
                    
                    if (try object.getInt(key: "ID") == 0){
                        var saparator = "";
                        if (replyto_count != 0){
                            saparator = ",";
                        }
                        replyto_Ids = try (to_Ids + saparator + object.getString(key: "PA_ID"));
                        replyto_Names = try (to_Names + saparator + object.getString(key:"PA_NAME"));
                        replyto_count += 1;
                    }
                    if (try object.getInt(key: "CCYN") == 0){
                        var saparator = "";
                        if (to_count != 0){
                            saparator = ",";
                        }
                        to_Ids = try (to_Ids + saparator + object.getString(key: "PA_ID"));
                        to_Names = try (to_Names + saparator + object.getString(key: "PA_NAME"));
                        to_count += 1;
                    }else{
                        var saparator = "";
                        if (cc_count != 0){
                            saparator = ",";
                        }
                        cc_Ids = try (cc_Ids + saparator + object.getString(key: "PA_ID"));
                        cc_Names = try (cc_Names + saparator + object.getString(key: "PA_NAME"));
                        cc_count += 1;
                    }
                }
                
                
                let jsonArray1 =   dataFromAPI["Tables1"]!
                
                
                mailAdaptor = MailDetailsAdaptor(vc: self, tableView: tableView, data: jsonArray1 as! [[String : AnyObject]])
                tableView.reloadData()
            }
        }catch{
            print("MYAPP", "objects are: \(error)")
            customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription )
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
            
            objBroadcastErrorMail.requestAuthorization()
        }
        
        
    }
}
