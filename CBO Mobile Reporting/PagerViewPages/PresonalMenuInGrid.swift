//
//  CBOContantViewController5.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 07/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class PresonalMenuInGrid  : CustomUIViewController , MenuGridAdaptorDelegate{
    
        var adpator : MenuGridAdaptor!

    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var Personal_Menu = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        Personal_Menu = cbohelp.getMenu(menu: "PERSONAL_INFO", code: "" )
        
        adpator = MenuGridAdaptor(collectionViewGrid: collectionView, vc: self, menu: Personal_Menu )
        
        adpator.delegate = self
        collectionView.delegate = adpator;
        collectionView.dataSource = adpator;
    }
    
    
    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: "PERSONAL_INFO", menu_code: menu_code)
         if (!url.isEmpty){
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        }else {
            switch menu_code{
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
        }
    }
    
   
    
}
