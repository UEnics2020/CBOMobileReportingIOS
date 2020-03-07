//
//  CustomDropDownTF.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 27/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class CustomDropDownTF: UITextField {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftPadding: CGFloat = 5
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 35);
    
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    @IBInspectable var rightPadding : CGFloat = 0
    
    
    @IBInspectable var color: UIColor = AppColorClass.colorPrimaryDark!{
        didSet {
            updateView()
        }
    }
    
    //    @IBInspectable var borderWidth: CGFloat = 1 {
    //        didSet {
    //            updateBorderWidth(borderWidth)
    //        }
    //    }
    //    func sharedInit() {
    //        updateBorderWidth(borderWidth)
    //
    //    }
    //    fileprivate func updateBorderWidth(_ value: CGFloat) {
    //        mywidth = value
    //
    //    }
    //    var mywidth : CGFloat = 1.0
    func updateView() {
        if let image = rightImage {
            self.borderStyle = UITextBorderStyle.none;
            rightViewMode = UITextFieldViewMode.always
            leftViewMode =  UITextFieldViewMode.always
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
            
            self.layer.cornerRadius = 8
            
            let slashRight = UIView(frame: CGRect(x: -5 , y: -5, width: 2, height: self.frame.size.height / 2 + (self.frame.size.height / 4 )))
            slashRight.backgroundColor = color
    
            self.layer.borderWidth = 2
            self.layer.borderColor = color.cgColor
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = color
            rightView = imageView
            rightView?.addSubview(slashRight)
          
            
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes : attributes) //[NSAttributedStringKey.foregroundColor: color])
    }
    let attributes = ([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 12)!,
                       NSAttributedStringKey.foregroundColor: AppColorClass.colorPrimaryDark!])

}
