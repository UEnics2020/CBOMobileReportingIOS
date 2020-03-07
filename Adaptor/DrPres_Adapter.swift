//
//  DrPres_Adapter.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 01/02/19.
//  Copyright © 2019 rahul sharma. All rights reserved.
//

import UIKit

class DrPres_Adapter: NSObject , UITableViewDelegate , UITableViewDataSource,CustomTextViewDelegate {
    func onTextChangeListner(sender: CustomTextView, text: String) {
        let tag = sender.getTag() as! [Any]
        let from =  tag[0] as! Int
        let index = tag[1] as! Int
        let cell = tag[2] as! RxItemRowTableViewCell
        switch from {
        case Amt_tag:
            list[index].setamt(amt:  text)
            break
        case Qty_tag:
            
            
            if(text != "") {
                if (RX_MAX_QTY != 0 && Int(text)! > RX_MAX_QTY) {
                    
                    vc.customVariablesAndMethod1.getAlert(vc: vc,title: "Not Allowed!!!",msg:  "Qty. cannot be more then \( RX_MAX_QTY)") {_ in
                        self.list[index].setQty(qty: "\(self.RX_MAX_QTY)");
                        cell.Qty.setText(text: "\(self.RX_MAX_QTY)")
                        
                    }
                   
                }else{
                    list[index].setQty(qty: text)
                    
                }
            }else{
               list[index].setQty(qty: text)
            }
            
            break
        default:
            print ("no tag assigned")
        }
    }
    
    private var list : [DrPres_Model]!
    private var tableView : UITableView!
    private var vc : CustomUIViewController!
    private var RX_MAX_QTY = 0;
    let Amt_tag = 0,Qty_tag = 1
    
    
    init(vc : CustomUIViewController , tableView : UITableView , list : [DrPres_Model]) {
        super.init()
        self.vc = vc
        self.list = list
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
        RX_MAX_QTY = Int(Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(vc: vc,key: "RX_MAX_QTY",defaultValue: "0"))!;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RxItemRowTableViewCell", owner: self, options: nil)?.first as! RxItemRowTableViewCell
        
        cell.selectionStyle = .none
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        
        cell.amt.delegate = self
        cell.amt.setTag(tag: [Amt_tag,indexPath.row,cell] )
        cell.Qty.delegate = self
        cell.Qty.setTag(tag: [Qty_tag,indexPath.row,cell] )
        
        
        cell.amt.setKeyBoardType(keyBoardType: UIKeyboardType.numberPad)
        cell.Qty.setKeyBoardType(keyBoardType: UIKeyboardType.numberPad)
        
        cell.amt.setHint(placeholder: "Amt.")
        cell.Qty.setHint(placeholder: "Qty")
        cell.Name.text = list[indexPath.row].getName()
        cell.Name_amt.text = list[indexPath.row].getName_amt()
        
        cell.amt.setText(text: list[indexPath.row].getamt())
        cell.Qty.setText(text: list[indexPath.row].getQty())
        
        return cell
        
    }
    
    

}

