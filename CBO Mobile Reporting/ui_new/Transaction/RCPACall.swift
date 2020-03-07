//
//  RCPACall.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit

class RCPACall: CustomUIViewController {
    
    @IBOutlet weak var doctorFilterView: UIButton!
    @IBOutlet weak var chemistFilterView: UIButton!
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    @IBOutlet weak var backButton: CustomeUIButton!
    @IBOutlet weak var showButton: CustomeUIButton!
    
    @IBOutlet weak var che_name: UILabel!
    @IBOutlet weak var dr_name: UILabel!
    
    private var docList = [SpinnerModel]();
    private var cheList = [SpinnerModel]();
    let CALL_DILOG = 5
    
    let cbohelp = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    var che_id="",doc_name="",doc_id="",ch_name = "",type="";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
        }
        
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        doctorFilterView.addTarget(self, action: #selector(onDoctorDropDown), for: .touchUpInside )
        chemistFilterView.addTarget(self, action: #selector(onChemistDropDown), for: .touchUpInside )
        showButton.addTarget(self, action: #selector(onClickShowButton), for: .touchUpInside )
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func onClickShowButton(){
        
        if doc_name == "" && ch_name == "" {
            
            customVariablesAndMethod.getAlert(vc: self,title: "Error",msg: "Please select Doctor/Chemist");
            
            
        } else {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                           let vc = storyboard.instantiateViewController(withIdentifier: "ListExpend") as! ListExpend
                            vc.doc_id = doc_id
                            vc.che_id = che_id
                            vc.VCIntent["title"] = "R.C.P.A Call"
                           self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func onChemistDropDown() {
        
        type="chemist"
        docList =  getChemistlist(context: self, type: "chemist")
    }
    
    @objc func onDoctorDropDown() {
        
        type="doctor"
        docList =  getChemistlist(context: self, type: "doctor")
    }
    
    @objc func closeVC(){
        myTopView.CloseCurruntVC(vc: self)
    }

    
    func getChemistlist(context : CustomUIViewController, type: String ) -> [SpinnerModel]{
        
        do{
            var statement = try cbohelp.getDoctorListLocal()
            
            // chemist.add(new SpinnerModel("--Select--",""));
            
            if type == "chemist" {
                statement = try cbohelp.getChemistListLocal()
            }
            
            let db = cbohelp
            docList.removeAll()
            
            if type == "chemist" {
                
                while let c = statement.next() {
                    docList.append(
                        
                        try SpinnerModel(name: c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_name")]! as! String,
                                         id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_id")]!)"
                        )
                    );
                    
                }
                
            } else {
                
                while let c = statement.next() {
                    docList.append(
                        
                        try SpinnerModel(name: c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_name")]! as! String,
                                         id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "dr_id")]!)"
                        )
                    );
                    
                }
                
            }
            
            
            
            Call_Dialog(vc: context, title: "Select ...", dr_List: docList, callTyp: "C", responseCode: CALL_DILOG).show()
            
        } catch {
            print(error)
        }
        
        return docList
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
            switch response_code {
                
      
            case CALL_DILOG:
                
                let data = dataFromAPI["data"]!
                let inderData = data[0] as! Dictionary<String , String>
                //Dr_name.text = docList[Int(inderData["Selected_Index"]!)!].getName()
                
               
                if type == "chemist" {
                    che_id = docList[Int(inderData["Selected_Index"]!)!].getId()
                    ch_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
                    che_name.text = ch_name
                } else {
                    doc_id = docList[Int(inderData["Selected_Index"]!)!].getId()
                    doc_name = docList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0];
                    dr_name.text = doc_name
                    
                }
                
               
                //pressedAddDoctor.setText(text: "Update Chemist")
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
