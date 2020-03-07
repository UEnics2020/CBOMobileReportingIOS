//
//  UnLogedReportAdaptor.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/08/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
class UnLogedReportAdaptor : NSObject , UITableViewDelegate , UITableViewDataSource {
    
    private var tableView : UITableView!
    private var vc : CustomUIViewController!
    var data = [[String: String]]();
    
    init(vc: CustomUIViewController , tableView : UITableView,data : [[String: String]]) {
        super.init()
        self.vc = vc
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
        self.data = data;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("UnLogedReportRow", owner: self, options: nil)?.first as! UnLogedReportRow
        
        cell.Sno.text = data[indexPath.row]["type"]
        cell.Name.text = data[indexPath.row]["name"]
        cell.Head_Qtr.text = data[indexPath.row]["time"]
        
        return cell
    }
}
