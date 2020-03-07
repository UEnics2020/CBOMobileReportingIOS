//
//  MultiSelectDetailView.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 11/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
protocol IMultiSelectDetailView : class {
    func onClickListner();
    func onBindTableCell(index: Int,item : mOthExpense) -> UITableViewCell;
    func onRowSelected(index: Int,item : mOthExpense);
}

class MultiSelectDetailView : UIView, UITableViewDataSource , UITableViewDelegate{
    @IBOutlet var tabGesture: UITapGestureRecognizer!
    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var listview: UITableView!
    @IBOutlet weak var listheight: NSLayoutConstraint!
    @IBOutlet weak var list_left_margin: NSLayoutConstraint!
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var headerView: UIView!
    private weak var delegate : IMultiSelectDetailView?

    private var dataList = [mOthExpense]()
    private var AddBtnRequired = true;
    private var headerReqd = true;
    
    
    @IBAction func tapOnTapGesture(_ sender: UITapGestureRecognizer) {
        //MARK:- use of Delegate with same Class type
        delegate?.onClickListner();
    }

    
    //getter
    func getTitle()-> String{
        return title.text!
    }
    
    func getSubTitle()-> String{
        return subTitle.text!
    }
    
    func getDetail()-> String{
        return detail.text!
    }
    
    func getDataList() -> [mOthExpense]{
        return dataList;
    }
    
    func IsAddBtnReqd() -> Bool {
        return self.AddBtnRequired;
    }
    
    //setter
    func setDelegate(delegate : IMultiSelectDetailView){
        self.delegate = delegate;
    }
    
    func setTitle(text : String) -> MultiSelectDetailView{
        title.text = text;
        return self;
    }
    
    func setSubTitle(text : String) -> MultiSelectDetailView{
        subTitle.text = text;
        return self;
    }
    
    func setDetail(text : String)-> MultiSelectDetailView{
        detail.text = text;
        return self;
    }
    
    func updateDataList(dataList : [mOthExpense]) -> MultiSelectDetailView{
        self.dataList.removeAll()
        self.dataList = dataList;
       
        listview.reloadData()
        listview.frame.size.height = listview.contentSize.height
        view.frame.size.height = listview.frame.size.height + headerView.frame.size.height
        
        //self.frame.size.height =  view.frame.size.height+20
        return self;
    }
    
    func setAddBtnReqd(required : Bool) -> MultiSelectDetailView {
        AddBtn.isHidden = !required
        self.AddBtnRequired = required;
        return self;
    }
    
    
    func setHeaderReqd(required : Bool) -> MultiSelectDetailView {
            self.headerReqd = required;
        return self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLoad(mainView: self)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLoad(mainView: self)
    }
    
    func initLoad( mainView : UIView) {
        Bundle.main.loadNibNamed("MultiSelectDetailView", owner: self, options: nil)
        self.addSubview(view)
        view.frame = mainView.bounds
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.5
        // layer.borderColor = UIColor(hex: "BDBDBD") as! CGColor
        
        self.backgroundColor =  UIColor(hex: "BDBDBD")
        self.listview.delegate = self
        self.listview.dataSource = self
        listview.alwaysBounceVertical = false;
        // self.listview.register(FilterViewRow.self, forCellReuseIdentifier: "cell")
        
        
        
    }
      
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        listheight.constant = CGFloat(110 * dataList.count)
        list_left_margin.constant = 30
        //listview.frame.size.height = listview.contentSize.height
        //view.frame.size.height = listview.frame.size.height + headerView.frame.size.height
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cell = Bundle.main.loadNibNamed("FilterViewRow", owner: self, options: nil)?.first as! FilterViewRow
//
//        cell.selectionStyle = .none
        
        //let tempValues = dataList[indexPath.row]
        
//        cell.myLabel.text = tempValues.title
//        
//        if (tempValues.isHighlighted()){
//            
//            cell.myLabel.textColor = UIColor(hex: "FF8333");
//        }
        
        return delegate!.onBindTableCell(index: indexPath.row, item: dataList[indexPath.row])
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onBindTableCell(index: indexPath.row, item: dataList[indexPath.row])
        
//        ReplyMsg.removeAll()
//        ReplyMsg["Selected_Index"]  = "\(indexPath.row)"
//
//        self.dismiss(animated: true, completion: nil)
//        vc.getDataFromApi(response_code: responseCode, dataFromAPI: ["data" : [ReplyMsg]])
        
    }
    
    
}
