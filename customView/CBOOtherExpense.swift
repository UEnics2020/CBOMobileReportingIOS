//
//  CBOOtherExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 12/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
class CBOOtherExpense : MultiSelectDetailView,IMultiSelectDetailView {
   
    
    internal func onClickListner() {
        if (IsAddBtnReqd()){
            listener?.AddExpenseClicked(expense_type: getExp_type());
        }
    }
    
    
    func onBindTableCell(index: Int,item: mOthExpense) -> UITableViewCell {
        //        let cell = Bundle.main.loadNibNamed("FilterViewRow", owner: self, options: nil)?.first as! FilterViewRow
        //        return cell;
        
        let cell = Bundle.main.loadNibNamed("AnotherExpensesRow1", owner: self, options: nil)?.first as! AnotherExpensesRow1
        cell.selectionStyle = .none
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        
        cell.hed.text = item.getExpHead().getName()
        cell.hed.textColor = AppColorClass.colorPrimaryDark
        
        cell.slashView.backgroundColor = AppColorClass.colorPrimaryDark
        cell.amount.text = String(item.getAmount())
        cell.Remark.text = item.getRemark()
        cell.attached.isHidden = (item.getAttachment() == "") ? true : false
        
        cell.editButton.addTarget(self, action: #selector(pressedEditButton(sender:)), for: .touchUpInside)
        cell.editButton.tag = index
        cell.deleteButton.tag = index
        cell.editButton.descriptiveName = String(item.getExpHead().getId())
        
        cell.deleteButton.descriptiveName = item.getExpHead().getName()
        
        cell.deleteButton.addTarget(self, action: #selector(pressedDeleteButton(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func onRowSelected(index: Int,item: mOthExpense){
        print("<#T##items: Any...##Any#>")
    }
    
    
    private var context : CustomUIViewController!;
    private var exp_type : eExpanse = eExpanse.None;
    
    private var DefaultAmount : Double = 0;
    private var ManualAount : Double = 0;
    private var OtherDetail = "";
    private var ManualMandetory = false;
    
    private var listener : Expense_interface?

    public func setListener(listener : Expense_interface?){
        self.listener = listener;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //var list = getDataList();
        
//        list.append(mOthExpense());
//        list.append(mOthExpense());
//        list.append(mOthExpense());
//        list.append(mOthExpense());
        
      //  updateDataList(dataList: list)
        setDelegate(delegate: self);
        setHeaderReqd(required: false);
        setTitle();

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setContext( activity : CustomUIViewController, exp_type : eExpanse){
        self.context = activity;
        setExp_type(exp_type: exp_type);
    }
    
    public func getExp_type() -> eExpanse {
        return exp_type;
    }
    
    public func setExp_type( exp_type : eExpanse) {
        self.exp_type = exp_type;
        setTitle();
    }
    
    public func setTitle(){
        var title = "";
        var subTitle = "";
        switch (getExp_type()){
            case eExpanse.TA:
                title = "TA";
                break;
            case eExpanse.DA:
                title = "DA";
                break;
            default:
                title = "Other Expenses";
        }
        if ((!getOtherDetail().isEmpty && !getOtherDetail().contains("*"))
        || (!getOtherDetail().isEmpty && ManualAount == 0 && DefaultAmount != 0 && !(IsAddBtnReqd() && IsManualMandetory()))) {
        subTitle =  " ( " + getOtherDetail() + " ) ";
        }
        
        setTitle(text: title);
        setSubTitle(text: subTitle);
    }
    
    public func getOtherDetail() -> String {
        return OtherDetail;
    }
    
    public func setOtherDetail(otherDetail : String) {
        OtherDetail = otherDetail;
        setTitle();
    }
    
    public func getDefaultAmount() -> Double{
        return DefaultAmount;
    }
    
    public func setDefaultAmount(defaultAmount : Double) {
        DefaultAmount = defaultAmount;
        updateDataList(dataList: getDataList());
    }
    
    public func IsManualMandetory() -> Bool {
        return ManualMandetory;
    }
    
    public func setManualMandetory( manualMendetory : Bool) {
        ManualMandetory = manualMendetory;
    }
    
    public func getAmount() -> Double {
       
       if( ManualAount > 0 || (IsAddBtnReqd() && IsManualMandetory())){
         return ManualAount;
       } else{
         return DefaultAmount;
       }
        
    }
    
    override func updateDataList(dataList : [mOthExpense]) -> MultiSelectDetailView{
        super.updateDataList(dataList : dataList);
        var total : Double = 0;
        dataList.forEach { othExpense in
           total += othExpense.getAmount();
        }
        ManualAount = total;
        setDetail(text: "₹ \( getAmount())");
        setTitle();
        return self;
    }
    
    @objc func pressedEditButton(sender : UIButton){
            
    //        print(sender.tag , sender.descriptiveName!)
           // delegate?.onEdit(id: "\(sender.tag)", name: sender.descriptiveName!)
        listener?.Edit_ExpenseClicked(othExpense: getDataList()[sender.tag], expense_type: getExp_type())

    }
        
     
    @objc func pressedDeleteButton(sender : UIButton){
           // delegate?.onDelete(id: "\(sender.tag)", name:sender.descriptiveName!)
        listener?.delete_ExpenseClicked(othExpense: getDataList()[sender.tag], expense_type: getExp_type())
    }
        
    
}



protocol Expense_interface : class {
    func AddExpenseClicked( expense_type : eExpanse);
    func Edit_ExpenseClicked( othExpense : mOthExpense,expense_type : eExpanse);
    func delete_ExpenseClicked(othExpense : mOthExpense,expense_type : eExpanse);
}
