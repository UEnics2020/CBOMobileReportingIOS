//
//  Doctor_Visit_Adapter.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 10/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class Doctor_Visit_Adapter: NSObject, UITableViewDelegate , UITableViewDataSource{
    
    var isCollaps = [Bool]()
    var tableView : UITableView!
    var i = 0
    
    private var total_Exps_height : CGFloat = 165.0
    
    
    
    var  summaryData = [[String : String]]()
    let cbohelp = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var context : CustomUIViewController!
    var month = "";
   
    
    init(tableView : UITableView , vc : CustomUIViewController , summaryData : [[String : String]] ,month : String) {
        super.init()
        
        context = vc
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        self.summaryData = summaryData
        self.tableView = tableView
        self.month = month
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let headerNib = UINib.init(nibName: "DashboardReportCellHeading", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "DashboardReportCellHeading")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if isCollaps[indexPath.section] == true {
//            //return 0
//            return UITableViewAutomaticDimension
//        }else {
            return  UITableViewAutomaticDimension
       // }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return summaryData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DashboardReportCellHeading") as! DashboardReportCellHeading
        headerView.headerTitle.text = " \(section + 1).\(String(describing: summaryData[section]["DR_NAME"]!))"
        
        headerView.myView.layer.shadowRadius = 3.0
        headerView.myView.layer.masksToBounds = false
        headerView.myView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerView.myView.layer.shadowOpacity = 0.5
      
        headerView.uptoMonth.text = "CLASS \(String(describing: summaryData[section]["CLASS"]!))"
        
        headerView.month.isHidden = true
        headerView.sign.isHidden = true
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("DoctorWiseRow", owner: self, options: nil)?.first as! DoctorWiseRow
        //cell.selectionStyle = .none

        cell.amount.text = ":"
        switch indexPath.row {
        case 0:
            cell.reamrk.text = "Visit Frequency"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["FREQ"]
        case 1:
            cell.reamrk.text = "No of Calls"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["NO_CALL"]
        case 2:
            cell.reamrk.text = "Visited Dates"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["CALL_DATE"]
        case 3:
            cell.reamrk.text = "Dr. Sales"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["DR_SALE"]
        case 4:
            cell.reamrk.text = "Missed Calls"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["MISSEDCALL"]
        case 5:
            cell.reamrk.text = "Last Call"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["LASTCALL"]
        case 6:
            cell.reamrk.text = "Dr. Camp"  //
            cell.amount_cumm.text = summaryData[indexPath.section]["DR_CAMP"]
        default:
            print("nothing")
        }
       
        return cell
    }
    
    
    
    
}
