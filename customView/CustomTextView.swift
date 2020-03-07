//
//  CustomTextView.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 11/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

protocol CustomTextViewDelegate : class {
    
    func onTextChangeListner( sender : CustomTextView ,text : String);
}

class CustomTextView: UIView , UITextViewDelegate{
    
    @IBOutlet var BottomLine: UIView!
    @IBOutlet var view: UIView!
    private  var SelfTag : Any!
    var SelfObj : CustomTextView!
    weak var delegate: CustomTextViewDelegate?
  
    @IBOutlet weak var myCustomeTextVIew: UITextView!
    var placeholder : String = "Enter Text"
    var text : String = ""
    var FromFilter = 0
    var ToFilter = 0
    
    public var onTextChanged: ((String) -> (Void))?
    
    func setText(text : String) {
        myCustomeTextVIew.text = text
        if text == ""{
            myCustomeTextVIew.textColor = UIColor.gray
            myCustomeTextVIew.text = placeholder
        } else {
            textchengeEvent()
        }
    }
    
    func setEnabled(enable : Bool){
        myCustomeTextVIew.isEditable =  enable
    }
    
     func getEnable() -> Bool{
        return myCustomeTextVIew.isEditable
    }
    
    func getHint()-> String{
        return placeholder
    }
    
    func getText()-> String{
        return text
    }
    
    
    func getTag() -> Any {
        return  SelfTag
    }
    func setTag(tag : Any){
        SelfTag = tag
    }
    
    func setHint(placeholder : String)  {
        
         //textchengeEvent()
        if myCustomeTextVIew.textColor == UIColor.gray{
            self.placeholder = placeholder
            myCustomeTextVIew.text = placeholder
        }
    }
    
    
    @IBInspectable var LineView : Bool = true{
        didSet{
            if LineView == false {
                   BottomLine.backgroundColor = .white
            }
        }
    }
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var boarderWidth: CGFloat = 0 {
        didSet {
           
            layer.borderWidth = boarderWidth
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       setuUp()
    }
    
    func setuUp(){
        Bundle.main.loadNibNamed("CustomTextView", owner: self, options: nil)
        self.addSubview(view)
        SelfObj = self
        view.frame = self.bounds
        layer.borderColor = AppColorClass.colorPrimary?.cgColor
        myCustomeTextVIew.textColor = UIColor.gray
        
        myCustomeTextVIew.delegate = self
        text = myCustomeTextVIew.text
        if text == ""{
            myCustomeTextVIew.textColor = UIColor.gray
            myCustomeTextVIew.text = placeholder
        }else{
            myCustomeTextVIew.textColor = UIColor.black
            
        }
        
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setuUp()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text == "" || text == placeholder{
            
             myCustomeTextVIew.textColor = UIColor.gray
            myCustomeTextVIew.text = ""
            
        }else{
            text = myCustomeTextVIew.text
             myCustomeTextVIew.textColor = UIColor.black
        }
        // show ket board
    }
    func textViewDidChange(_ textView: UITextView) {
        textchengeEvent()
        delegate?.onTextChangeListner(sender: SelfObj, text: text)
        onTextChanged?(text)
    }
    
    func setfilter(from : Int , to : Int){
        FromFilter = from
        ToFilter = to
    }
    
    func textchengeEvent(){
        text = myCustomeTextVIew.text
        if text == "" || placeholder.contains(text) {
            myCustomeTextVIew.textColor = UIColor.gray
            
            // if text != ""{
            myCustomeTextVIew.text = placeholder
            //}
            if text.count >= placeholder.count {
                let x1 = text.index(text.startIndex, offsetBy: placeholder.count)..<text.endIndex
                text = String(text[x1])
                myCustomeTextVIew.text = text
            }else if  text.count < placeholder.count {
                text = ""
                myCustomeTextVIew.text = text
            }
            
        }else{
            
            myCustomeTextVIew.textColor = UIColor.black
            
        }
    }
   
    func textViewDidEndEditing(_ textView: UITextView) {
        text = myCustomeTextVIew.text
        if text == "" || text == placeholder{
            myCustomeTextVIew.textColor = UIColor.gray
            myCustomeTextVIew.text = placeholder
            text = ""
            
        }else{
            text = myCustomeTextVIew.text
            myCustomeTextVIew.textColor = UIColor.black
            
        }
        // hide keyboard
    }
    
    
    func setKeyBoardType(keyBoardType: UIKeyboardType){
        myCustomeTextVIew.keyboardType = keyBoardType
    }
    
    
    func setSecureTextEnable(enable: Bool){
        myCustomeTextVIew.isSecureTextEntry = enable
    }
    
    func setFocus(focus : Bool){
        if !focus {
            myCustomeTextVIew.resignFirstResponder()
        }
        
    }
    
}

extension UITextView{
    
    @IBInspectable  var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    public func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

