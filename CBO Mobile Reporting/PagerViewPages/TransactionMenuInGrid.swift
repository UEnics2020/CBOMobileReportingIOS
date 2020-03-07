//
//  CBOContantViewController3.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 07/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class TransactionMenuInGrid: CustomUIViewController , MenuGridAdaptorDelegate{

      var adpator : MenuGridAdaptor!
    @IBOutlet weak var collectionView: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var Transaction_Menu = [[String : String]]()
     var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    var MenuCode = "TRANSACTION";
    override func viewDidLoad() {
        super.viewDidLoad()

        MenuCode = VCIntent["Code"]! as String;
        
        Transaction_Menu = cbohelp.getMenu(menu: MenuCode, code: "" )
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        adpator = MenuGridAdaptor(collectionViewGrid: collectionView, vc: self, menu: Transaction_Menu )
        
        adpator.delegate = self
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = adpator;
        
        collectionView.dataSource = adpator;
        
        
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Transaction_Menu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CBOContantCollectionViewCell {
        
            
            cell1.myImageView.image = setImage(menu_code:  Transaction_Menu[indexPath.row]["menu_code"]! )
            cell1.myNotificationBackground.layer.cornerRadius = cell1.myNotificationBackground.frame.height / 2
            cell1.myNotificationBackground.isHidden = true
            cell1.myNotificationCounter.text = ""
            cell1.myLabel.text = Transaction_Menu[indexPath.row]["menu_name"]
            return cell1
        }
        return UICollectionViewCell()
    }

    func setImage(menu_code : String) -> UIImage{
        var image : UIImage!
        
        
        if (menu_code == ("T_LR")) {
            image = UIImage(named: "request_leave_white.png")
        } else if (menu_code == ("T_LR1")) {
            image = UIImage(named: "request_leave_white.png")
        } else  if (menu_code == ("T_SS")) {
            image = UIImage(named: "secondary_sale.png")
        } else if (menu_code == ("T_COMP")) {
            image = UIImage(named: "view_last_complaint_white.png")
        } else if (menu_code == ("T_CV")) {
            image = UIImage(named: "complaint_view.png")
        } else if (menu_code == ("T_RCPA")) {
            image = UIImage(named: "rcpa_white.png")
        } else if (menu_code == ("T_FAR")) {
            image = UIImage(named: "farmer_meeting_white.png")
        } else if (menu_code == ("T_ADDDOC")) {
            image = UIImage(named: "add_doctor.png")
        } else if (menu_code == ("T_DRSHALE")) {
            image = UIImage(named: "secondary_sales_white.png")
        } else if (menu_code == ("T_ADDCHEM")) {
            image = UIImage(named: "add_chemist.png")
        } else if (menu_code == ("T_ADDTP")) {
            image = UIImage(named: "add_tourp.png")
        } else if (menu_code == ("T_TPAPROVE")) {
            image = UIImage(named: "tp_reports_.png")
        } else if (menu_code == ("T_CHALACK")) {
            image = UIImage(named: "challan_reciv.png")
        } else if (menu_code == ("T_RM")) {
            image = UIImage(named: "route_master.png")
        } else if (menu_code == ("T_EXP")) {
            image = UIImage(named: "expense_statement.png")
        } else if (menu_code == ("T_EDITDOC")) {
            image = UIImage(named: "doctor_edit_approval.png")
        } else {
            image = UIImage(named: "reset_day_plan_white.png")
        }
        
        return image!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onClickListener(menu_code: Transaction_Menu[indexPath.row]["menu_code"]! , name : Transaction_Menu[indexPath.row]["menu_name"]!)
        
    }
    
    
    func onClickListener(menu_code : String , name : String) {
        
       let url = cbohelp.getMenuUrl(menu: MenuCode, menu_code: menu_code)
        
        if (!url.isEmpty) {
            
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        
        } else {
            
            switch menu_code{
                
            case "T_RCPA":
                
                if (Custom_Variables_And_Method.DCR_ID == "0"  || customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "dcr_date_real", defaultValue: "") == "") {
                   
                    customVariablesAndMethod.getAlert(vc: self,title: "Day Plan",msg: "Please open your DCR Day first....");
                
                
                } else {
                    onClickRcpa(title: name)
                    
                }
                
                break
            
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            
            }
        }
        
    }
    
    func onClickRcpa(title : String){
         if (customVariablesAndMethod.IsGPS_GRPS_ON(context: self)) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "RCPACall") as! RCPACall
                vc.VCIntent["title"] = title
                self.present(vc, animated: true, completion: nil)
        
        }
        
    }

    
    
    
    
    
}
