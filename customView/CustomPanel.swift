//
//  CustomPanel.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/03/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

protocol CustomPanelDelegate  : class {
    func onClickListner (sender : CustomPanel)
    func onDivertChangeListner(sender: CustomPanel, ischecked: Bool)
}
class CustomPanel: UIView ,CheckBoxDelegate {
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
         setDivertRemarkEnabled(enabled: ischecked && IsDiverRemarkReqd())
        delegate?.onDivertChangeListner(sender: self,ischecked: ischecked)
    }
    
    var obj : CustomPanel!
   
    @IBOutlet weak var CheckBox: CheckBox!
    @IBOutlet weak var divertTitle: UILabel!
    @IBOutlet weak var DivertCheckBox: UIStackView!
    @IBOutlet weak var diverRemarkSaparetor: UIView!
    @IBOutlet weak var divertRemark: CustomTextView!
    @IBOutlet var tabGesture: UITapGestureRecognizer!
    @IBOutlet weak var CustomTextview: CustomTextView!
    @IBOutlet var view: UIView!
    
    
   
    
    @IBOutlet weak var title: UILabel!
    
    weak  var  delegate : CustomPanelDelegate?
    
    
    //getter
    func getTitle()-> String{
        return title.text!
    }
    func getHint()-> String{
        return CustomTextview.getHint()
    }
    
    func getText()-> String{
        return CustomTextview.getText()
    }
    
    func getDivertRemark() -> String {
        return divertRemark!.getText()
    }
    
    func IsdivertReqd()-> Bool{
        return DivertCheckBox.isHidden;
    }
    
    func IsDiverted()-> Bool{
        return CheckBox.isChecked();
    }
    
    private var divertRemarkReqd = false;
    func IsDiverRemarkReqd() -> Bool{
        return divertRemarkReqd
    }
    
    //setter
    
    func setText(text : String){
        CustomTextview.setText(text: text)
        
    }
    func setTitle(text : String){
        title.text = text;
        divertRemark.setHint(placeholder: "Please Enter " + getDivertText() + " Remark..")
        divertTitle.text = getDivertText()
    }
   
    func setHint(placeholder : String)  {
        CustomTextview.setHint(placeholder: placeholder)
    }
    
    func setdivertReqd(required : Bool)  {
       DivertCheckBox.isHidden = !required;
        
        if !required {
            setDivertRemarkReqd(required: required)
        }
    }
    func setDiverted(divert : Bool)  {
        CheckBox.setChecked(checked: divert)
        setDivertRemarkEnabled(enabled: divert && IsDiverRemarkReqd())
    }
    
    
    func setDivertRemarkReqd(required : Bool){
        divertRemarkReqd = required
        if !required {
            setDivertRemarkEnabled(enabled: required)
        }
    }
    
    func setDivertRemarkEnabled(enabled : Bool){
        divertRemark.isHidden = !enabled
        diverRemarkSaparetor.isHidden = !enabled
        if !enabled{
            setDivertRemark(remark: "")
        }
    }
    
   
    func setDivertRemark(remark : String) {
        return divertRemark!.setText(text: remark)
    }
    
    @IBAction func tapOnTapGesture(_ sender: UITapGestureRecognizer) {
        //MARK:- use of Delegate with same Class type
        delegate?.onClickListner(sender: obj)
    }
    
    private  var SelfTag : Int!
    
    func  setTag(tag : Int) {
        SelfTag = tag
    }
    func getTag() -> Int {
        return SelfTag!
    }
    
    private var divertText = ""
    func  setDivertText(divertText : String) {
        self.divertText = divertText
        divertRemark.setHint(placeholder: "Please Enter " + getDivertText() + " Remark..")
        divertTitle.text = getDivertText()
    }
    func getDivertText() -> String {
        if (divertText.isEmpty){
            return "Divert " + getTitle()
        }
        return divertText
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //MARK:- Delegate with same Class type
        obj = self;
        Bundle.main.loadNibNamed("CustomPanel", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        layer.cornerRadius = 5
        layer.borderWidth = 1.5
//        layer.borderColor = UIColor(hex: "BDBDBD") as! CGColor
        
        CustomTextview.setEnabled(enable: false)
        CustomTextview.LineView = false
        setHint(placeholder: "Press + Sign")
        divertRemark.setHint(placeholder: "Please Enter " + getDivertText() + " Remark..")
        divertTitle.text = getDivertText()
        divertRemark.LineView = false
        CustomTextview.myCustomeTextVIew.isUserInteractionEnabled = false
        setdivertReqd(required: false)
        CheckBox.delegate = self
        
        
    }
}
