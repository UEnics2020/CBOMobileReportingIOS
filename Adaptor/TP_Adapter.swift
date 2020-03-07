//
//  TP_Adapter.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 11/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class TP_Adapter: NSObject, UITableViewDelegate , UITableViewDataSource{
    
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
        

    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return  UITableViewAutomaticDimension
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("tp_reports_row", owner: self, options: nil)?.first as! tp_reports_row
        //cell.selectionStyle = .none
        cell.tv_tp_date.text = summaryData[indexPath.row]["date"]

        cell.tv_tp_workwith.text = summaryData[indexPath.row]["work_with"]
        cell.tv_tp_area.text = summaryData[indexPath.row]["station"]
        cell.tv_tp_remark.text = summaryData[indexPath.row]["station_remark"]
        
        return cell
    }

}
