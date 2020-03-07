//
//  CBOContantViewController2.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 07/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class MailScreen: CustomUIViewController ,MenuGridAdaptorDelegate{
    
    var adpator : MenuGridAdaptor!
    var count_Calls = [Int]()
    
     var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    @IBOutlet weak var collectionView: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var MAIL_Menu = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllTab();
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        adpator = MenuGridAdaptor(collectionViewGrid: collectionView, vc: self, menu: MAIL_Menu,count_Calls : count_Calls)
        
        adpator.delegate = self
        collectionView.delegate = adpator
        collectionView.dataSource = adpator
       
    }
    override func viewWillAppear(_ animated: Bool) {
        addAllTab();
        collectionView.reloadData()
        
    }
    
    func addAllTab(){
        MAIL_Menu = cbohelp.getMenu(menu: "MAIL", code: "" )
        count_Calls.removeAll()
        for i in 0 ..<  MAIL_Menu.count{
            count_Calls.append(get_count( menu: MAIL_Menu[i]["menu_code"]!))
        }
    }
    
    func  get_count(menu : String) -> Int{
        var result = 0;
        var mail_category = "";
        var flag = false;
        switch (menu){
        case "M_IN":
            flag=true;
            mail_category="i";
            result=1;
        break;
            case "NOTIFICATION":
            flag=true;
            mail_category="NOTIFICATION";
            result=1;
        break;
    
        default:
            flag = false
        }
        
        if(flag && mail_category == ("NOTIFICATION")){
            result = cbohelp.getNotification_count();
        }else if(flag && mail_category != ("")){
            result = cbohelp.getNoOfUnreadMail(mail_category: mail_category);
        }
        return result;
    }

    
    override func viewDidAppear(_ animated: Bool) {
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MAIL_Menu.count
    }


    
    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: "MAIL", menu_code: menu_code)
       
        
        if (!url.isEmpty){
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        }else {
            
            switch menu_code{
            case "M_COM" :
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ComposeMailView") as! ComposeMailView
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)
                break
   
            case "M_IN" :
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)
                break
                
            case "M_SITEM" :
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)
                break
                
            case "NOTIFICATION" :
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
                vc.VCIntent["title"] = name
                self.present(vc, animated: true, completion: nil)

                break

            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
        }
    }
    
    
    
    

}
