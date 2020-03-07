//
//  ExpandableDashboardAdapter.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class ExpandableDashboardAdapter: NSObject , UITableViewDelegate , UITableViewDataSource{
    
    var isCollaps = [Bool]()
    var tableView : UITableView!
    var headers = [String]()
    var i = 0
    var isCellCollaps = [[Bool]]()
    
    private var total_Exps_height : CGFloat = 165.0
    
  
    
    var  summaryData = [[String : [[String : String]]]]()
    let cbohelp = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var context : CustomUIViewController!
    var month = "";
   
    init(tableView : UITableView , vc : CustomUIViewController , summaryData : [[String : [[String : String]]]] , headers :[String] , isCollaps : [Bool] ,month : String) {
        super.init()
        
        context = vc
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        self.summaryData = summaryData
        self.tableView = tableView
        self.isCollaps = isCollaps
        self.headers = headers
        self.month = month
        
        tableView.dataSource = self
        tableView.delegate = self

        let headerNib = UINib.init(nibName: "DashboardReportCellHeading", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "DashboardReportCellHeading")
        
    }
    
 
    @objc func headerButtonPressed(sender : UIButton){
        print("header button pressed")
        isCollaps[sender.tag] = !isCollaps[sender.tag]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isCollaps[indexPath.section] == true {
            //return 0
            return 0
        }else {
            return  UITableViewAutomaticDimension
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DashboardReportCellHeading") as! DashboardReportCellHeading
        headerView.headerTitle.text = headers[section]
    
        headerView.myView.layer.shadowRadius = 3.0
        headerView.myView.layer.masksToBounds = false
        headerView.myView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.myView.layer.shadowOpacity = 0.5
        

        headerView.headerButton.addTarget(self, action: #selector(headerButtonPressed), for: .touchUpInside)
        headerView.month.text = month
        headerView.uptoMonth.text = "Upto \(month)"
        headerView.headerButton.tag = section
        
        if isCollaps[section] == true{
            headerView.sign.text = "+"
        }else{
            headerView.sign.text = "-"
        }
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData[section][headers[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("marketing_view", owner: self, options: nil)?.first as! marketing_view
        //cell.selectionStyle = .none
        cell.remark.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["REMARK"]   //array1[indexPath.row]
        cell.amount.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["AMOUNT"]   //array2[indexPath.row]
        cell.amount_cumm.text = summaryData[indexPath.section][headers[indexPath.section]]![indexPath.row]["AMOUNT_CUMM"]   //array3[indexPath.row]
        
//        datanum1["REMARK"] = try jasonObj1.getString(key: "REMARK") as? String
//        datanum1["AMOUNT"] = try jasonObj1.getString(key: "AMOUNT") as? String
//        datanum1["AMOUNT_CUMM"] = try jasonObj1.getString(key: "AMOUNT_CUMM") as? String
//
        // cell.backgroundColor = AppColorClass.colorPrimary
        return cell
    }
    
    
    
    
   
    
    
    
    
    
    
    
    
}
