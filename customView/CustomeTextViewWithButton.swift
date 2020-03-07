//
//  CustomeTextViewWithButton.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 11/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
//MARK:- Delegate with same Class type
protocol CustomTextViewWithButtonDelegate  : class {
    func onClickListnter (sender : CustomTextViewWithButton)
}

class CustomTextViewWithButton: UIView {
    var obj : CustomTextViewWithButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var view: UIView!
    
    weak  var  delegate : CustomTextViewWithButtonDelegate?
    @IBOutlet weak var CustomTextview: CustomTextView!
    
    @IBOutlet weak var myCustomButton: CustomeUIButton!
    func setText(text : String){
        CustomTextview.setText(text: text)
        
    }

    func getHint()-> String{
        return CustomTextview.getHint()
    }
    
    func getText()-> String{
        return CustomTextview.getText()
    }
    
    func setHint(placeholder : String)  {
        CustomTextview.setHint(placeholder: placeholder)
    }
    
    @IBAction func tapOnTapGesture(_ sender: UITapGestureRecognizer) {
        //MARK:- use of Delegate with same Class type
        delegate?.onClickListnter(sender: obj)
    }
    
    private  var SelfTag : Int!
    
    func  setTag(tag : Int) {
        SelfTag = tag
    }
    func getTag() -> Int {
        return SelfTag!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //MARK:- Delegate with same Class type
        obj = self;
        Bundle.main.loadNibNamed("CustomTextViewWithButton", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        
        CustomTextview.setEnabled(enable: false)
        setHint(placeholder: "Press + Sign")
        CustomTextview.myCustomeTextVIew.isUserInteractionEnabled = false
        
        
        
    }
   
}
