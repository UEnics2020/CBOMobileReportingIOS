//
//  ApprovalMenuInGrid.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 22/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class ApprovalMenuInGrid: CustomUIViewController , MenuGridAdaptorDelegate{

    var adpator : MenuGridAdaptor!
    
    @IBOutlet weak var approvalMenGrid: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var Transaction_Menu = [[String : String]]()
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    var MenuCode = "APPROVAL";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuCode = VCIntent["Code"]! as String;
        
        Transaction_Menu = cbohelp.getMenu(menu: MenuCode, code: "" )
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()

        adpator = MenuGridAdaptor(collectionViewGrid: approvalMenGrid, vc: self, menu: Transaction_Menu )
        
        adpator.delegate = self
        approvalMenGrid.delegate = adpator
        approvalMenGrid.dataSource = adpator
    }
    
    
    
    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: MenuCode, menu_code: menu_code)
        
        if (!url.isEmpty){
            
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        }else {
            switch menu_code{
                case "A_REM":

                    onClickRemainder(name: name);
                break
                
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
        }
    }
    
    
        func  onClickRemainder(name: String) {
           
              if(customVariablesAndMethod.internetConneted(context: self)){
                
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyboard.instantiateViewController(withIdentifier: "ReminderApproval" ) as! ReminderApproval
                  vc.VCIntent["title"] =  name
                  self.present(vc, animated: true, completion: nil)
              }
              
         }
    
}

