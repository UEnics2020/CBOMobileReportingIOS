//
//  VisualAdAdaptor.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 21/03/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import Foundation
class CheckVisualAdAdaptor : NSObject , UITableViewDataSource , UITableViewDelegate, CheckBoxDelegate{
   
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! [Any]
        let index = tag[1] as! Int
        print(sample_id[index] + " , " + sample_name[index])
    }
    
    
    let promoted_tag = 0
    var sample_id = [String]()
    var sample_name = [String]()
    var dataList = [DocSampleModel]()
    var tableView : UITableView!
 
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var storyboard : UIStoryboard!
    var context = CustomUIViewController()
    
    init(tableView : UITableView   , vc : CustomUIViewController , dataList : [DocSampleModel] , sample_id : [String]  , sample_name : [String]) {
        super.init()
        self.tableView = tableView
        self.sample_id = sample_id
        self.sample_name = sample_name
        self.dataList = dataList
        context = vc
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = Bundle.main.loadNibNamed("VisualAdRow", owner: self, options: nil)?.first as! VisualAdRow
        cell.selectionStyle = .none
        cell.adName.text = dataList[indexPath.row].getName()
        cell.checkbox.isHidden = false
        cell.promoted.isHidden = true
        cell.checkbox.delegate = self
        cell.checkbox.setTag(tag: [promoted_tag,indexPath.row,cell] )
        //cell.checkbox.setChecked(checked: list[index].isSelected());
        if (dataList[indexPath.row].get_Checked()){
            
            cell.adName.textColor = UIColor(hex: "#7c7b7b")
           // cell.promoted.isHidden = false
            cell.contentView.backgroundColor = UIColor(hex: "#e7e7e8")
            
//          view.setBackgroundResource(R.drawable.list_selector_selected);
            
        }else {
            cell.adName.textColor = UIColor(hex:"#000000")
           // cell.promoted.isHidden = true
            cell.contentView.backgroundColor = UIColor.white
//    view.setBackgroundResource(R.drawable.list_selector_unselected);
        }
        
        
        
        
        switch (dataList[indexPath.row].get_file_ext().lowercased()) {
        case ".pdf":
            cell.myImageView?.image = UIImage(named: "pdf_icon.png")
            break;
        case ".avi",".mov",".3gp",".mp4":
            cell.myImageView?.image = UIImage(named: "mp4_icon.png")
            break
        case ".mp3":
            cell.myImageView?.image = UIImage(named: "music_icon.png")
            break;
        case ".html":
            cell.myImageView?.image = UIImage(named: "web_login_white.png")
            break;
        
        case ".bmp",".jpg",".gif",".png":
            cell.myImageView?.image = UIImage(named: "image_icon.png")
            break
        
        default:
            
            cell.myImageView?.image = UIImage(named: "no_image.png")
        }
        return cell
    }
    

    
}
    


