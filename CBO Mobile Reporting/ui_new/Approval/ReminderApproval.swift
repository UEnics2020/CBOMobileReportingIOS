//
//  ReminderApproval.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class ReminderApproval: CustomUIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
   // @IBOutlet weak var topview: UIView!
    @IBOutlet weak var closebtn: UIButton!
   // @IBOutlet weak var header: UILabel!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    private var cbohelop = CBO_DB_Helper.shared
    private var progressHUD : ProgressHUD? = nil
    let MESSAGE_INTERNET_Mail = 1
    private var customVariablesAndMethod: Custom_Variables_And_Method!
    
    var data = [ReportingModel]()
    var domain = "", params = "", heading = ""
    //private var reportModel: ReportingModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //header.text = heading
        
        /*topview.layer.shadowRadius = 3.0
        topview.layer.masksToBounds = false
        topview.layer.shadowOffset = CGSize(width: 0, height: 2)
        topview.layer.shadowOpacity = 0.5
        topview.backgroundColor =  AppColorClass.colorPrimary*/
        
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
        }
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        closebtn.layer.shadowRadius = 3.0
        closebtn.layer.masksToBounds = false
        closebtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        closebtn.layer.shadowOpacity = 0.5
        closebtn.backgroundColor =  AppColorClass.colorPrimary

       customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        getReminderData()
        // Do any additional setup after loading the view.
    }
    
    @objc func closeVC(){
        myTopView.CloseCurruntVC(vc: self)
    }
    
    @IBAction func close(_ sender: UIButton) {
        
        myTopView.CloseCurruntVC(vc: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("ReminderRow", owner: self, options: nil)?.first as! ReminderRow
        
        let position = indexPath.row
        cell.Name.text = (data[position].getPARICULARS());
        cell.Qty.setTitle(data[position].getADD_VALUE(), for: .normal)
        
        cell.Name.textColor = AppColorClass.colorPrimary
        cell.Qty.layer.cornerRadius = 4
        
        cell.Qty.layer.borderWidth = 4
        cell.Qty.layer.borderColor = AppColorClass.colorPrimary?.cgColor
        
        //cell.Qty.layer.borderWidth = 2
        //cell.Qty.layer.borderColor = UIColor.white.cgColor
        
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].getPARICULARS())
        let url = domain+data[indexPath.row].getADD_URL()+params
        customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: data[indexPath.row].getPARICULARS(), url: url)
    }

    func getReminderData(){
        
         // tableview.isHidden = true
          let methodName = "APPROVAL_REMINDER"
        
          var params = [String : String]()
                 
          params["sCompanyFolder"] = "demotest"
          params["FMCYN"] = ""
          params["iPA_ID"] = "11190"
        
          progressHUD = ProgressHUD(vc: self)
          progressHUD?.show(text: "Please Wait...")
          var tables = [Int]()
          tables.append(0)
          tables.append(1)
          CboServices().customMethodForAllServices(params: params, methodName: methodName, tables: tables, response_code:  MESSAGE_INTERNET_Mail, vc: self)
        
          
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
        switch response_code {
        case MESSAGE_INTERNET_Mail:
            progressHUD!.dismiss()
            parser_data(dataFromAPI: dataFromAPI)
            break
       
        default:
            progressHUD!.dismiss()
            print("hello")
        }
    }
    
    
    private func parser_data(dataFromAPI: [String : NSArray] ) {
        do {
            if(!dataFromAPI.isEmpty){
            let jsonArray =   dataFromAPI["Tables0"]!
            let jsonArray1 =   dataFromAPI["Tables1"]!
            var datanum1 = [String : String]()
            
                
            for i in 0 ..< jsonArray1.count {
                
                let innerJson = jsonArray1[i] as! [String : AnyObject]
                
                domain = try! innerJson.getString(key: "DOMAIN")
                params = try! innerJson.getString(key: "QUERY")
                
            }
                
            for i in 0 ..< jsonArray.count{
                
                let innerJson = jsonArray[i] as! [String : AnyObject]
                var reportModel = ReportingModel()
                
                if try! innerJson.getString(key: "ADD_VALUE") as? String  != "0" {
                    reportModel = ReportingModel()
                    
                    reportModel.setPARICULARS(PARICULARS: "\(innerJson["PARICULARS"] as! String) (Add)")
                    reportModel.setADD_VALUE(ADD_VALUE: innerJson["ADD_VALUE"] as! String)
                    reportModel.setADD_URL(ADD_URL: innerJson["ADD_URL"] as! String)
                    
                    data.append(reportModel)
                }
                
                if try! innerJson.getString(key: "EDIT_VALUE") as? String  != "0" {
                    reportModel = ReportingModel()
                    reportModel.setPARICULARS(PARICULARS: "\(innerJson["PARICULARS"] as! String) (Edit)")
                    reportModel.setADD_URL(ADD_URL: innerJson["EDIT_URL"] as! String)
                    reportModel.setADD_VALUE(ADD_VALUE: innerJson["EDIT_VALUE"] as! String)
                    
                    data.append(reportModel)
                    
                }
                
                if try! innerJson.getString(key: "DELETE_VALUE") as? String  != "0" {
                    reportModel = ReportingModel()
                    reportModel.setPARICULARS(PARICULARS: "\(innerJson["PARICULARS"] as! String) (Delete)")
                    reportModel.setADD_URL(ADD_URL: innerJson["DELETE_URL"] as! String)
                    reportModel.setADD_VALUE(ADD_VALUE: innerJson["DELETE_VALUE"] as! String)
                    
                    data.append(reportModel)
                    
                }
                
               // data.append(reportModel)
                
            }
                
                
        }
            print("datanum1  ",data.count)
            tableview.isHidden = false
            tableview.reloadData()
        }catch {
            print("Error", "objects are: \(error)")
            customVariablesAndMethod.getAlert(vc: mcontext, title: "Missing field error", msg: error.localizedDescription )
            
            
            
            let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
            
            let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: mcontext)
            
            objBroadcastErrorMail.requestAuthorization()
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
