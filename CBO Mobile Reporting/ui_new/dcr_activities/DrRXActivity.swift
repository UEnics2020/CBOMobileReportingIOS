//
//  DrRXActivity.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 01/02/19.
//  Copyright © 2019 rahul sharma. All rights reserved.
//

import UIKit
import CoreLocation
import NotificationCenter
class DrRXActivity : CustomUIViewController , CheckBoxDelegate , ParantSummaryAdaptorDalegate {
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! Int
        
        switch tag {
        case 0:
            do{
                if(ischecked){
                     if (tenivia_traker.count > 0 && (  (tenivia_traker["id"]!.contains ("-99")) || (tenivia_traker["id"]!.contains ("-1")))) {
                        customVariablesAndMethod.getAlert(vc: context, title: "ALERT !!!", msg: "Are you sure to save as\n\"No " + head + " for the day\"", completion: {_ in
                            self.Save_RX(who: 1);
                            //myTopView.CloseCurruntVC(vc: context)
                        })
                    
                        
                    }else{
                        customVariablesAndMethod.msgBox(vc: context,msg: head + " for the day");
                        sender.setChecked(checked: false);
                    }
                }
            }catch{
                print("error")
            }
            
            break
            
        default:
            print ("no tag assigned")
        }
    }
    
    func onEdit(id: String, name: String) {
        if(id != ("-1")) {
            getAlert(id:id, name : name ,  title: "Edit")
        }else{
            customVariablesAndMethod.msgBox(vc: self, msg: "you can't edit  " + name)
        }
    }
    
    func onDelete(id: String, name: String) {
         getAlert(id : id ,name : name , title: "Delete")
    }
    
    
    func getAlert(id  : String  , name : String , title : String){
        var msg = ""
        
        
        var alertViewController : UIAlertController!
        let edit = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.setTabsUI()
            self.dr_id = id
            self.doc_name = name
            self.Dr_name.text = self.doc_name
            
            self.isFound(Dr_id: self.dr_id, Dr_name: self.doc_name)
        }
        
        let delete = UIAlertAction(title: title.uppercased(), style: .default) { (action) in
            self.dr_id = id
            self.doc_name = name
            self.Dr_name.text = self.doc_name
            self.cbohelp.delete_tenivia_traker (DR_ID: id);
            self.DeleteRx(dr_id: id,dr_name: name);
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
    
    @IBOutlet weak var summaryBackButton: CustomeUIButton!
    @IBOutlet weak var CallView: CustomBoarder!
    @IBOutlet weak var Summaryview: CustomBoarder!
    
    @IBOutlet weak var callButton: CustomHalfRoundButton!
    @IBOutlet weak var summaryButton: CustomHalfRoundButton!
    @IBOutlet weak var slelectedTabBarButtom: UIView!
    
    @IBOutlet weak var SummaryTableView: UITableView!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var Dr_name: UILabel!
    @IBOutlet weak var Dr_btn: UIButton!
    @IBOutlet weak var itemtableView: UITableView!
    @IBOutlet weak var no_prescription_chk: CheckBox!
    
    @IBOutlet weak var Submit: CustomeUIButton!
    @IBOutlet weak var no_prescription_txt: UILabel!
    
    var presenter : ParantSummaryAdaptor!
    var drPres_Adapter : DrPres_Adapter!
    var header = [String]()
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var context : CustomUIViewController!
    var progress :  ProgressHUD!
    
    var tenivia_traker = [String : [String]]();
    var summary_list = [[String : [String : [String]]]]()
    var head = "";
    
    var docList = [SpinnerModel]();
    var list = [DrPres_Model]();
    
    let CALL_DILOG = 5,DCRRX_COMMIT = 6,DCRRX_DELETE = 7
    
    var RxReqdType = "0";
    var dr_id="",doc_name=""
    var qtyInput = false;
    
    var sbId = ""
    var sbQty = ""
    var sbamt = ""
    var sbQty_caption = ""
    var sbamt_caption = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CallView.isHidden = false
        Summaryview.isHidden = true
        
        
        slelectedTabBarButtom.backgroundColor = AppColorClass.tab_sellected
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        
        context = self
        progress  =  ProgressHUD(vc : context)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        if VCIntent["title"] != nil{
            head = VCIntent["title"]!
            myTopView.setText(title: head)
        }
        
        RxReqdType = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "DR_RXGEN_VALIDATE",defaultValue: "0");
        
        Dr_btn.addTarget(self, action: #selector(OnClickDrLoad), for: .touchUpInside )
        callButton.addTarget(self, action: #selector(pressedCallButton), for: .touchUpInside)
        summaryButton.addTarget(self, action: #selector(pressedSummaryButton), for: .touchUpInside)
        
        callButton.setText(text: head)
        no_prescription_txt.text = "No "+head+" for the day"
        no_prescription_chk.delegate = self
        no_prescription_chk.setTag(tag: 0)
        
        summaryBackButton.isHidden = true
        getItemList()
        genrateSummary()
        presenter.delegate = self
        
        Submit.addTarget(self, action: #selector(SaveRX), for: .touchUpInside)
        
        if  (RxReqdType != "1"){
            if (tenivia_traker.count > 0 && !tenivia_traker["id"]!.contains ("-99")) {
                no_prescription_txt.isHidden = true
                no_prescription_chk.isHidden = true
            }
        }
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
            
       
        case CALL_DILOG:
            let data = dataFromAPI["data"]!
            let inderData = data[0] as! Dictionary<String , String>
            //Dr_name.text = docList[Int(inderData["Selected_Index"]!)!].getName()
            dr_id = docList[Int(inderData["Selected_Index"]!)!].getId()
            doc_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
            Dr_name.text = doc_name
            isFound(Dr_id: dr_id, Dr_name: doc_name)
            
            break
            
        case DCRRX_COMMIT:
            onRxCommit();
            progress.dismiss()
            break;
        case DCRRX_DELETE:
            progress.dismiss()
            customVariablesAndMethod.msgBox(vc: context,msg: doc_name+" Sucessfully Deleted."){_ in
                self.myTopView.CloseCurruntVC(vc: self)
            }
            break;
        case 99:
            progress.dismiss()
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            progress.dismiss()
            print("Error")
            
        }
    }
    
    
    func getItemList(){
        do{
            let statement = try cbohelp.getAllProducts(itemidnotin: "0");
            let db = cbohelp
            list.removeAll()
            while let c = statement.next() {
                
                list.append(
                    try DrPres_Model(name: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "item_name")]!)",
                        id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "item_id")]!)", name_amt: ""
                    )
                );
            }
            if (list.count > 0){
                
                drPres_Adapter = DrPres_Adapter(vc: self, tableView: itemtableView, list: list)
               
                
            }
        }catch {
            print(error)
        }
    }
    

    
    // on call
    
    @objc func OnClickDrLoad(){
        do{
            let statement = try cbohelp.getDoctorName(RXGENYN: RxReqdType);
            // chemist.add(new SpinnerModel("--Select--",""));
            let db = cbohelp
            docList.removeAll()
            while let c = statement.next() {
                
                docList.append(
                    try SpinnerModel(name: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_name")]!)",
                        id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_id")]!)"
                    )
                );
            }
            
            Call_Dialog(vc: self, title: "Select Doctor...", dr_List: docList, callTyp: "DS", responseCode: CALL_DILOG).show()
            //docList = new ArrayList<SpinnerModel>();
            //GPS_Timmer_Dialog(context,mHandler,"Scanning Doctors...",GPS_TIMMER).show();
        }catch {
            print(error)
        }
    }
    
    
    private func isFound( Dr_id : String,  Dr_name : String) {
    
        if (tenivia_traker.count > 0 && tenivia_traker["id"]!.contains (Dr_id)) {
        
        
        
            var tenivia_traker_DR  : [String : [String]] = cbohelp.getCallDetail (table: "tenivia_traker", look_for_id: Dr_id, show_edit_delete: "1");
        
        
            if (tenivia_traker_DR["gift_name"]![0] != ("")) {
                
            
                
                let gift_name1 = tenivia_traker_DR["gift_name"]![0].components(separatedBy: ",");
                let gift_qty1 = tenivia_traker_DR["gift_qty"]![0].components(separatedBy: ",");
       
        
                for i in 0 ..< list.count{
                    if(gift_name1.contains(list[i].getName())){
                        for j in 0 ..< gift_name1.count{
                            if (list[i].getName ().lowercased() == (gift_name1[j].lowercased())) {
                                list[i].setQty(qty: gift_qty1[j])
                                break
                            }
                        }
                    }else{
                         list[i].setQty(qty: "")
                    }
                }
               
            }
            Submit.setText(text: "Update");
           
        } else {
            for i in 0 ..< list.count{
                list[i].setQty(qty: "")
            }
             Submit.setText(text: "Submit");
        }
         itemtableView.reloadData()
        
    }

    
    
    //MARK:- callButton
    @objc func pressedCallButton(){
        setTabsUI()
    }
    
    @objc func pressedSummaryButton(){
        callButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_sellected!)
        Summaryview.isHidden = false
        CallView.isHidden = true
    }
    
    func setTabsUI(){
        callButton.setButtonColor(color: AppColorClass.tab_sellected!)
        summaryButton.setButtonColor(color: AppColorClass.tab_unsellected!)
        CallView.isHidden  = false
        Summaryview.isHidden = true
    }
    
    func genrateSummary(){
        var headers = [ String]()
        var isCollaps = [Bool]()
        tenivia_traker = cbohelp.getCallDetail(table: "tenivia_traker",look_for_id: "",show_edit_delete: "1")
       
        do {
            summary_list.append([ head :tenivia_traker])
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
        myTopView.setText(title: headers[0])
        
        SummaryTableView.dataSource = presenter
        SummaryTableView.delegate = presenter
    }
    
    @objc func pressedBack(){
        myTopView.CloseCurruntVC(vc: self)
    }
    
    @objc func SaveRX(){
        Save_RX(who: 0)
    }
    
    private func Save_RX( who : Int){
        saveData(who: who);
        if (Dr_name.text == ("--Select--")) {
            customVariablesAndMethod.msgBox(vc: self,msg: "Please Select Name First...");
        }else if (qtyInput) {
            SaveTask();
        } else {
            customVariablesAndMethod.msgBox(vc: self,msg: "Please fill atlest One Qty...");
        }
        
    
    }
    
    private func saveData( who : Int) {
        qtyInput = false;
        sbId = ""
        sbQty = ""
        sbamt = ""
        sbQty_caption = ""
        sbamt_caption = ""
    
        if (who == 1){
            qtyInput = true;
            if (RxReqdType != ("1")) {
                dr_id = "-1";
                doc_name = "No " + head;
                Dr_name.text = doc_name
            }
            sbId.append("-1");
            sbQty.append("0");
            sbamt.append("0");
            sbQty_caption.append("");
            sbamt_caption.append("");
        }else {
             for i in 0 ..< list.count{
                let item : DrPres_Model = list[i]
                if(!item.getQty().trimmingCharacters(in: .whitespaces).isEmpty && Double(item.getQty())! != 0){
                     qtyInput = true;
                    if(sbId.count == 0){
                        sbId.append(item.getId());
                        sbQty.append(item.getQty());
                        sbamt.append(item.getamt());
                        sbQty_caption.append(item.getName());
                        sbamt_caption.append(item.getName_amt());
                    }else{
                        sbId.append(",")
                          sbId.append(item.getId())
                        sbQty.append(",")
                            sbQty.append(item.getQty());
                        sbamt.append(",")
                            sbamt.append(item.getamt());
                        sbQty_caption.append(",")
                            sbQty_caption.append(item.getName());
                        sbamt_caption.append(",")
                            sbamt_caption.append(item.getName_amt());
                    }
                }
            }
        }
    }
    
    private func SaveTask() {
        if (dr_id == ("-1")){
            onRxCommit();
            return;
        }
    
        
        //Start of call to service
        
        var request = [String:String]()
        request["sCompanyFolder"] = cbohelp.getCompanyCode()
        request["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
        request["DOC_DATE"] = customVariablesAndMethod.currentDate()
        request["iDCRID"] = Custom_Variables_And_Method.DCR_ID
        request["iDR_ID"] = dr_id
        request["sITEMID"] = sbId
        request["sQTY"] = sbQty
        request["sAMOUNT"] = sbamt
        
        var tables = [Int]();
        tables.append(-1);
        
        progress = ProgressHUD(vc: self)
        progress.show(text: "Please Wait...")
        CboServices().customMethodForAllServices(params: request, methodName: "DCRRX_COMMIT_1", tables: tables, response_code: DCRRX_COMMIT, vc: self)
        
        
        //End of call to service
    
    
    
    }
    
    private func onRxCommit(){
        var remark = "";
        if (sbId == ("-1")){
            remark = no_prescription_txt.text!
        }
        if(tenivia_traker.count > 0 && tenivia_traker["name"]!.contains(doc_name)) {
            cbohelp.Update_tenivia_traker(DR_ID: dr_id, DR_NAME: doc_name, QTY: sbQty
                ,  AMOUNT: sbamt, QTY_CAPTION: sbQty_caption, ITEM_ID: sbId, AMOUN_CAPTION: sbamt_caption,  TIME: customVariablesAndMethod.currentTime(context: self), REMARK: remark);
        
        }else{
            cbohelp.Insert_tenivia_traker(DR_ID: dr_id, DR_NAME: doc_name, QTY: sbQty
                ,  AMOUNT: sbamt, QTY_CAPTION: sbQty_caption, ITEM_ID: sbId, AMOUN_CAPTION: sbamt_caption,  TIME: customVariablesAndMethod.currentTime(context: self), REMARK: remark);
        
        }
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "D_DR_RX_VISITED",value: "Y");
        customVariablesAndMethod.msgBox(vc: context,msg: "Successfully Submitted..."){_ in
            self.myTopView.CloseCurruntVC(vc: self)
        }
   
    }
    
    private func DeleteRx( dr_id : String, dr_name : String) {
        
        
        //Start of call to service
        
        var request = [String:String]()
        request["sCompanyFolder"] = cbohelp.getCompanyCode()
        request["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
        request["DOC_DATE"] = customVariablesAndMethod.currentDate()
        request["iDCRID"] = Custom_Variables_And_Method.DCR_ID
        request["iDR_ID"] = dr_id
        
        
        var tables = [Int]();
        tables.append(-1);
        
        progress = ProgressHUD(vc: self)
        progress.show(text: "Please Wait...")
        CboServices().customMethodForAllServices(params: request, methodName: "DCRRX_DELETE", tables: tables, response_code: DCRRX_DELETE, vc: self)
        
        
        //End of call to service
        

    }

}
