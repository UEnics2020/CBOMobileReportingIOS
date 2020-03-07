//
//  UnderlinedUIView.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 28/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class UnderlinedUIView: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            updateBorderWidth(borderWidth)
        }
    }
    
    @IBInspectable var borderColor: UIColor = AppColorClass.colorPrimaryDark! {
        didSet {
            updateBorderColor(borderColor)
        }
    }
    
    
    func sharedInit() {
        updateBorderWidth(borderWidth)
        updateBorderColor(borderColor)
    }
    
    //-------------------------------------------------------------------------------
    //MARK: - Private setter helpers
    //-------------------------------------------------------------------------------
    fileprivate func updateBorderWidth(_ value: CGFloat) {
        mywidth = value
        
    }
    var mywidth : CGFloat = 1.0
    var mycolor : UIColor = AppColorClass.colorPrimaryDark!
    fileprivate func updateBorderColor(_ color: UIColor) {
        mycolor = color
    }
    
    @IBInspectable var bottomBorderColor: UIColor! {
        get {
            return self.bottomBorderColor
        }
        set {
            
            
            
            
            let border = CALayer()
            let width =  CGFloat (mywidth)
            border.borderColor =  mycolor.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - 1  ,   width:  self.frame.size.width, height: self.frame.size.height)
            
            let newView = UIView()
            
            newView.frame = CGRect(x: 0, y: 20 ,   width:  self.frame.size.width - 10, height:  width)
            
            newView.backgroundColor = mycolor
            self.insertSubview(newView, aboveSubview: superview!)
            
            
//            border.borderWidth = width
//            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
            
           
            
        }
    }
}

