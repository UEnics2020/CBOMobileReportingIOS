//
//  DOB_AnniversaryAdaptor.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 12/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//



import UIKit

class DOB_AnniversaryAdaptor : NSObject, UITableViewDelegate , UITableViewDataSource {
    
    var tableView : UITableView!
    
    private var total_Exps_height : CGFloat = 165.0
    
    var  summaryData = [[String : [[String : String]]]]()
    let cbohelp = CBO_DB_Helper.shared
    var context : CustomUIViewController!
    var headers  = [String]()
    
    init(tableView : UITableView , vc : CustomUIViewController , summaryData : [[String : [[String : String]]]] , headers :[String] ) {
        super.init()
        context = vc

        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView = tableView
        self.headers = headers
        self.summaryData = summaryData
        
        let headerNib = UINib.init(nibName: "DOB_Header", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "DOB_Header")
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        return  UITableViewAutomaticDimension
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return headers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DOB_Header") as! DOB_Header
        
        headerView.shadowView.layer.shadowRadius = 3.0
        headerView.shadowView.layer.masksToBounds = false
        headerView.shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.shadowView.layer.shadowOpacity = 0.5
        
        headerView.lbl_Title.text = headers[section]
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData[section][headers[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("DOB_DOA_Row", owner: self, options: nil)?.first as! DOB_DOA_Row
        cell.selectionStyle = .none
        cell.callbtn.isHidden = true
        cell.msgbtn.isHidden = true
        cell.label_Detail.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["PA_NAME"] //"Section : \(indexPath.section)  Row : \(indexPath.row)"
        cell.label_DOB.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["DOB"]
        cell.label_Anniversary.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["DOA"]
        return cell
    }
    
}

