//
//  MenuGridAdaptor.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 23/03/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

protocol MenuGridAdaptorDelegate{
    func onClickListener(menu_code : String , name : String)
}

class MenuGridAdaptor : NSObject , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    fileprivate var menu = [[String : String]]()
      private let objCustomCollectionViewLayout = CustomCollectionViewLayout()

    private var collectionViewGrid  : UICollectionView!
    private var context = CustomUIViewController()
    var count_Calls = [Int]()
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    
    var delegate : MenuGridAdaptorDelegate?

    init(collectionViewGrid : UICollectionView   , vc : CustomUIViewController , menu :  [[String : String]]) {
        super.init()
        
        self.collectionViewGrid = collectionViewGrid
        context = vc
        self.menu = menu
       
       
        if #available(iOS 11.0, *) {
            self.collectionViewGrid?.collectionViewLayout = columnLayout
            self.collectionViewGrid?.contentInsetAdjustmentBehavior = .always
            
        }else{
        
         collectionViewGrid.collectionViewLayout = objCustomCollectionViewLayout.MycollectionViewCellSpaceing(collectionView : collectionViewGrid)
        }
        
       
        self.collectionViewGrid.register(UINib(nibName: "CBOContantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        
       
    }
    
    
    init(collectionViewGrid : UICollectionView   , vc : CustomUIViewController , menu :  [[String : String]],count_Calls : [Int]) {
        super.init()
        
        self.collectionViewGrid = collectionViewGrid
        context = vc
        self.menu = menu
        self.count_Calls = count_Calls
        
       
        
        if #available(iOS 11.0, *) {
            self.collectionViewGrid?.collectionViewLayout = columnLayout
            self.collectionViewGrid?.contentInsetAdjustmentBehavior = .always
            
        }else{
        
         collectionViewGrid.collectionViewLayout = objCustomCollectionViewLayout.MycollectionViewCellSpaceing(collectionView : collectionViewGrid)
        }
        
         self.collectionViewGrid.register(UINib(nibName: "CBOContantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CBOContantCollectionViewCell {
        
            cell1.myImageView.image = setImage(menu_code:  menu[indexPath.row]["menu_code"]! )
            
            cell1.myNotificationBackground.layer.cornerRadius = cell1.myNotificationBackground.frame.height / 2
            if count_Calls.count > 0 {
                if count_Calls[indexPath.row] ==  0{
                    cell1.myNotificationBackground.isHidden = true
                    cell1.myNotificationCounter.text = ""
                }else {
                    cell1.myNotificationBackground.isHidden = false
                    cell1.myNotificationCounter.text = "\(count_Calls[indexPath.row])"
                }
            }else{
                cell1.myNotificationBackground.isHidden = true
                cell1.myNotificationCounter.text = ""
            }
            cell1.myLabel.text = menu[indexPath.row]["menu_name"]
            return cell1
        }
        return UICollectionViewCell()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.onClickListener(menu_code: menu[indexPath.row]["menu_code"]! , name : menu[indexPath.row]["menu_name"]!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = objCustomCollectionViewLayout.MyCollectionViewLayoutSet(collectionView: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout)
        return size
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
            
        } else  if (menu_code == ("CP")) {
            image = UIImage(named: "change_pwd.png")
            
        } else if (menu_code == ("SS")) {
            image = UIImage(named: "salary_slip.png")
            
        } else if (menu_code == ("CIR")) {
            image = UIImage(named: "circular.png")
            
        } else if (menu_code == ("DECL")) {
            image = UIImage(named: "decl_ofsaving.png")
            
        } else if (menu_code == ("IP")) {
            image = UIImage(named: "perso_info.png")
            
        } else if (menu_code == ("FORM16")) {
            image = UIImage(named: "form16.png")
            
        } else if (menu_code == ("HL")) {
            image = UIImage(named: "dcr_reports_white.png")
            
        } else if (menu_code == ("LEAVE")) {
            image = UIImage(named: "request_leave_white.png")
            
        } else if (menu_code == ("LEAVE1")) {
            image = UIImage(named: "request_leave_white.png")
            
        }else if (menu_code == ("R_LOGUNL")) {
            image = UIImage(named: "logged_unlogged_white.png")
            
        } else if (menu_code == ("R_DCRRPT")) {
            image = UIImage(named: "dcr_reports_white.png")
            
        } else if (menu_code == ("R_DASH")) {
            image = UIImage(named: "secondary_sales_white.png")
            
        } else if (menu_code == ("R_DRWISE")) {
            image = UIImage(named: "dr_wise_reports.png")
            
        } else if (menu_code == ("R_TP")) {
            image = UIImage(named: "tp_reports_.png")
            
        } else if (menu_code == ("R_SPO")) {
            image = UIImage(named: "spo_reports.png")
            
        }else if (menu_code == ("DOB_DOA")) {
            image = UIImage(named: "birthday.png")
            
        }else if (menu_code == ("MSG_HO")) {
            image = UIImage(named: "msg_ho.png")
            
        }else if (menu_code == ("GIFT_DIST")) {
            image = UIImage(named: "gift_distribution_status.png")
            
        }else if (menu_code == ("T_LR")) {
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
            
        } else if (menu_code == ("M_COM")) {
            image = UIImage(named: "compose_mail_white.png")
            
        } else if (menu_code ==  ("M_IN")) {
            image = UIImage(named: "inbox_white.png")
            
        } else if (menu_code ==  ("M_SITEM")) {
            image = UIImage(named: "sent_white.png")
            
        } else if (menu_code ==  ("NOTIFICATION")) {
            image = UIImage(named: "notification.png")
            
        } else if (menu_code == ("U_UPPIC")) {
            image = UIImage(named: "upload_image_white.png")
            
        } else if (menu_code == ("U_UPDOWN")) {
            image = UIImage(named: "upload_download_white.png")
            
        } else if (menu_code == ("U_CAPSIGN")) {
            image = UIImage(named: "capture_image_white.png")
            
        } else if (menu_code == ("U_MAP")) {
            image = UIImage(named: "map_view_white.png")
            
        } else if (menu_code == ("U_WEB")) {
            image = UIImage(named: "web_login_white.png")
            
        } else if (menu_code == ("U_DOWNAID")) {
            image = UIImage(named: "upload_download_white.png")
            
        } else if (menu_code == ("U_SHOWAID")) {
            image = UIImage(named: "dcr_reports_white.png")
            
        } else if (menu_code == ("U_PI")) {
            image = UIImage(named: "perso_info.png")
            
        } else if (menu_code == ("Show Demo Kilometer")) {
            image = UIImage(named: "map_view_white.png")
            
        } else if (menu_code == ("D_DP")) {

            image = UIImage(named: "dcr_reports_white.png")

        } else if (menu_code == ("D_RCCALL")) {
            image = UIImage(named: "reminder_card_white.png")
            
        } else if (menu_code == ("D_DRCALL")) {
            image = UIImage(named: "doctor_call_white.png")
        }
        else if (menu_code == ("D_DR_RX") || menu_code == ("D_RX_GEN") || menu_code == ("D_RX_GEN_NA")) {
            image = UIImage(named: "add_doctor.png")
        }
        else if (menu_code == ("D_DRSAM")) {
            image = UIImage(named: "doctor_sameple_white.png")
            
        } else if (menu_code == ("D_DRSAM")) {
            image = UIImage(named: "chemist_call_white.png")
            
        } else if (menu_code == ("D_CHEMCALL")) {
            image = UIImage(named: "chemist_call_white.png")
            
        } else if (menu_code == ("D_RETCALL")) {
            image = UIImage(named: "chemist_call_white.png")
            
        } else if (menu_code == ("D_STK_CALL")) {
            image = UIImage(named: "stockist_call_white.png")
            
        } else if (menu_code == ("D_NLC_CALL")) {
            image = UIImage(named: "non_listedcall.png")
            
        }else if (menu_code == ("D_FAR")) {
            image = UIImage(named: "farmer_meeting_white.png")
            
        } else if (menu_code == ("D_AP")) {
            image = UIImage(named: "appraisal.png")
            
        } else if (menu_code == ("D_EXP")) {
            image = UIImage(named: "expense_white.png")
            
        } else if (menu_code == ("D_SUM")) {
            image = UIImage(named: "summary_white.png")
            
        } else if (menu_code == ("D_FINAL")) {
            image = UIImage(named: "final_submit_white.png")
            
        } else if (menu_code == ("U_RESET")) {
            //  RESET DAYPLAN
            image = UIImage(named: "reset_day_plan.png")
            
        } else if (menu_code == ("T_DELCHEM")) {
            
            // delete chemist
            
            image = UIImage(named: "delete_chemist.png")
                   
        } else if (menu_code == ("T_SOP")) {
            
            // SECONDARY OPENING
            image = UIImage(named: "secondary_opening.png")
                   
        } else if (menu_code == ("T_FGO")) {
            
            // FGO REQUEST
            image = UIImage(named: "final_submit_white.png")
                   
        } else if (menu_code == ("R_NOCALLDR")) {
            
            image = UIImage(named: "no_of_call_by_no_of_dr.png")// NO OF CALL BY NO OF DR
                          
        } else if (menu_code == ("R_PLIST")) {
                   
            // PROCE LIST
            image = UIImage(named: "price_list.png")
                          
        } else if (menu_code == ("R_CHEM_LIST")) {
                   
            // CHEMIST LIST
            image = UIImage(named: "chemist_list.png")
                          
        } else if (menu_code == ("AC_OUTST_BAL")) {
                   
            // OUTSTANDING BALANCE
            image = UIImage(named: "outstanding_summery.png")
                          
        } else if (menu_code == ("AC_LEDGER")) {
                   
            // ACCOUNT LEDGER
            image = UIImage(named: "account_ledger.png")
                          
        } else if (menu_code == ("LSTATUS")) {
                   
            // LEAVE STATUS
            image = UIImage(named: "leave_status.png")
                          
        }else if (menu_code == ("LSTATUS")) {
                   
            // LEAVE STATUS
            image = UIImage(named: "final_submit_white.png")
                          
        }else if (menu_code == ("DQS")) {
                   
            // DOWNLOAD QUICK SUPPORT
            image = UIImage(named: "dwnld_quick_sprt.png")
                          
        } else if (menu_code == ("A_DRADD")) {
                   
            // DR ADDITION APPROVAL
            image = UIImage(named: "dr_add_approval.png")
                          
        }else if (menu_code == ("LEAVE_APP")) {
                   
            // LEAVE APPROVAL
            image = UIImage(named: "leave_approval.png")
                          
        }else if (menu_code == ("CHADD_APP")) {
            
            // CHEMIST ADDITION APPROVAL
            image = UIImage(named: "chemist_add_approval.png")
            
        } else if (menu_code == ("CHEDEL_APP")) {
                   
            // CHEMIST DELETION APPROVAL
            image = UIImage(named: "chemist_delete_approval.png")
                          
        } else if (menu_code == ("EXP_APR")) {
                   
            // EXPENSE APPROVAL
            image = UIImage(named: "expense_approval.png")
                          
        } else if (menu_code == ("A_REM")) {
                   
            // REMINDER APPROVAL
            image = UIImage(named: "reminder_approval.png")
                          
        } else if (menu_code == ("A_DRDEL")) {
                   
            // DR DELETION APPROVAL
            image = UIImage(named: "dr_deletion_approval.png")
                          
        }else if (menu_code == ("A_DREDIT")) {

            // DR EDITION APPROVAL
            image = UIImage(named: "dr_edit_approval.png")

        }else if (menu_code == ("CHEEDIT_APP")) {

            // CHEMIST EDITION APPROVAL
            image = UIImage(named: "chemist_edit_approval.png")

        } else{
            
            image = UIImage(named: "reset_day_plan_white.png")
        }
        return image!
    }
    
    
    
    
   
    
    
    
   

}
