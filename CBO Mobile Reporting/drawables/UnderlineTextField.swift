//
//  UnderlineTextField.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 26/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class UnderlineTextField: UITextField {

    
    
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
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
            self.borderStyle = UITextBorderStyle.none;
            let border = CALayer()
            let width =  CGFloat (mywidth)

            border.borderColor =  mycolor.cgColor


            border.frame = CGRect(x: 0, y: self.frame.size.height,   width:  self.frame.size.width, height: self.frame.size.height)
            let textArea = UITextView()
            textArea.backgroundColor = UIColor.red
//            textArea.frame(
           self.textInputView.addSubview(textArea)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true

        }
    }
}
