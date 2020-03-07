//
//  NotificationVC.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 14/06/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
class NotificationVC : CustomUIViewController{
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var tableView: UITableView!
     private var cboDbHelper : CBO_DB_Helper = CBO_DB_Helper.shared
   
    private var notificationAdaptor : Notification_Adaptor!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]! )
        }
        
       var data = cboDbHelper.getNotificationMsg();
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        notificationAdaptor = Notification_Adaptor(vc: self, tableView: tableView, notification: data )
        
    }

    @objc func closeVC(){
        myTopView.CloseCurruntVC(vc: self)
    }



}
